import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  // In-Memory Shared Subscriber Registry (Reflects across Diner & Owner views)
  static final List<Subscriber> subscribers = [
    Subscriber(
      id: "sub_101",
      userName: "Rohan Patil",
      phone: "+91 98765 43210",
      planName: "Monthly 2-Meals (Lunch + Dinner)",
      dinerPersona: DinerPersona.student,
      mealsRemaining: 42,
      totalMeals: 60,
      skipsUsed: 2,
      maxSkips: 6,
      creditBalancePaise: 10000, // ₹100
      todayLunchStatus: "ATTENDED",
      todayDinnerStatus: "SCHEDULED",
      orders: [
        IndividualMealOrder(
          orderId: "ord_101_1",
          date: "16 Oct 2026",
          mealType: "LUNCH",
          status: "ATTENDED",
          notes: "Checked in at 01:15 PM IST",
        ),
        IndividualMealOrder(
          orderId: "ord_101_2",
          date: "16 Oct 2026",
          mealType: "DINNER",
          status: "SCHEDULED",
          notes: "Preparation assigned • Cutoff 05:00 PM",
        ),
      ],
    ),
    Subscriber(
      id: "sub_102",
      userName: "Priya Sharma",
      phone: "+91 98111 22233",
      planName: "Executive Lunch Box (Working Adult)",
      dinerPersona: DinerPersona.working,
      mealsRemaining: 24,
      totalMeals: 30,
      skipsUsed: 1,
      maxSkips: 4,
      creditBalancePaise: 5000, // ₹50
      todayLunchStatus: "ATTENDED",
      todayDinnerStatus: "NOT_INCLUDED",
      orders: [
        IndividualMealOrder(
          orderId: "ord_102_1",
          date: "16 Oct 2026",
          mealType: "LUNCH",
          status: "ATTENDED",
          notes: "Delivered to IT Park Tower 2",
        ),
      ],
    ),
    Subscriber(
      id: "sub_103",
      userName: "Nana Saheb Joshi",
      phone: "+91 94220 55566",
      planName: "Senior Care Nutritional Diet",
      dinerPersona: DinerPersona.senior,
      mealsRemaining: 54,
      totalMeals: 60,
      skipsUsed: 0,
      maxSkips: 6,
      creditBalancePaise: 0,
      todayLunchStatus: "ATTENDED",
      todayDinnerStatus: "SCHEDULED",
      orders: [
        IndividualMealOrder(
          orderId: "ord_103_1",
          date: "16 Oct 2026",
          mealType: "LUNCH",
          status: "ATTENDED",
          notes: "Low spice, extra soft chapati",
        ),
        IndividualMealOrder(
          orderId: "ord_103_2",
          date: "16 Oct 2026",
          mealType: "DINNER",
          status: "SCHEDULED",
          notes: "Delivery requested at 07:30 PM",
        ),
      ],
    ),
  ];

  static Subscriber getSubscriber(String id) {
    return subscribers.firstWhere(
      (s) => s.id == id,
      orElse: () => subscribers[0],
    );
  }

  static final List<DishItem> fallbackDinnerMenu = [
    DishItem(category: "Sabzi", en: "Paneer Butter Masala", mr: "पनीर बटर मसाला", hi: "पनीर बटर मसाला"),
    DishItem(category: "Dal", en: "Dal Tadka", mr: "तडका डाळ", hi: "दाल तड़का"),
    DishItem(category: "Bread", en: "Jowar Bhakri / Chapati", mr: "ज्वारीची भाकरी / चपाती", hi: "ज्वार की रोटी / चपाती"),
    DishItem(category: "Rice", en: "Jeera Rice", mr: "जिरा राईस", hi: "जीरा चावल"),
    DishItem(category: "Dessert", en: "Gulab Jamun", mr: "गुलाबजाम", hi: "गुलाब जामुन"),
  ];

  static final List<LedgerRecord> fallbackLedger = [
    LedgerRecord(
      id: "txn_001",
      type: "SUBSCRIPTION_PAYMENT",
      debit: 0,
      credit: 320000,
      balance: 320000,
      note: "30-Day Subscription via Razorpay Sandbox",
      timestamp: "16 Oct, 10:00 AM",
    ),
    LedgerRecord(
      id: "txn_002",
      type: "MEAL_SKIP_CREDIT",
      debit: 0,
      credit: 5000,
      balance: 325000,
      note: "Skipped Dinner (Before 17:00 IST cutoff)",
      timestamp: "16 Oct, 02:15 PM",
    ),
  ];

  static Future<Map<String, dynamic>> skipMeal(String subId) async {
    final sub = getSubscriber(subId);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/subscriptions/skip'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'subId': subId,
          'mealType': 'DINNER',
          'date': DateTime.now().toIso8601String().split('T')[0],
        }),
      ).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        sub.todayDinnerStatus = "SKIPPED";
        return data;
      }
    } catch (_) {
      // Local fallback
    }

    // Local state update
    if (sub.skipsUsed < sub.maxSkips) {
      sub.skipsUsed += 1;
      sub.mealsRemaining = (sub.mealsRemaining - 1).clamp(0, sub.totalMeals);
      sub.creditBalancePaise += 5000;
      sub.todayDinnerStatus = "SKIPPED";

      // Append order log for mess owner review
      sub.orders.insert(
        0,
        IndividualMealOrder(
          orderId: 'ord_${DateTime.now().millisecondsSinceEpoch}',
          date: '16 Oct 2026',
          mealType: 'DINNER',
          status: 'SKIPPED',
          notes: 'Diner requested skip before 05:00 PM cutoff • ₹50 Credited',
        ),
      );

      fallbackLedger.insert(
        0,
        LedgerRecord(
          id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
          type: 'MEAL_SKIP_CREDIT',
          debit: 0,
          credit: 5000,
          balance: sub.creditBalancePaise + 320000,
          note: 'Skipped Tonight\'s Dinner (${sub.userName})',
          timestamp: 'Just now',
        ),
      );

      return {
        'success': true,
        'creditAwardedPaise': 5000,
        'mealsRemaining': sub.mealsRemaining,
        'creditBalancePaise': sub.creditBalancePaise,
        'skipsUsed': sub.skipsUsed,
        'message': 'Meal skipped! ₹50 credited to your ledger.',
      };
    } else {
      sub.todayDinnerStatus = "SKIPPED";
      return {
        'success': true,
        'creditAwardedPaise': 0,
        'message': 'Max skips quota reached for this cycle. Kitchen notified to avoid food waste.',
      };
    }
  }

  // Mess Owner Attendance Action
  static void markAttendance(String subId, String mealType) {
    final sub = getSubscriber(subId);
    if (mealType == 'LUNCH') {
      sub.todayLunchStatus = 'ATTENDED';
    } else if (mealType == 'DINNER') {
      sub.todayDinnerStatus = 'ATTENDED';
    }
    sub.orders.insert(
      0,
      IndividualMealOrder(
        orderId: 'ord_att_${DateTime.now().millisecondsSinceEpoch}',
        date: '16 Oct 2026',
        mealType: mealType,
        status: 'ATTENDED',
        notes: 'Attendance recorded by Mess Staff',
      ),
    );
  }
}
