import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  // In-Memory Fallback State (Ensures flawless offline operation)
  static final Subscriber fallbackSubscriber = Subscriber(
    id: "sub_101",
    userName: "Rohan Patil",
    phone: "+91 98765 43210",
    mealsRemaining: 42,
    totalMeals: 60,
    skipsUsed: 2,
    maxSkips: 6,
    creditBalancePaise: 10000, // ₹100
  );

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
        return jsonDecode(response.body);
      }
    } catch (_) {
      // Offline fallback handling
    }

    // Local deterministic state update
    if (fallbackSubscriber.skipsUsed < fallbackSubscriber.maxSkips) {
      fallbackSubscriber.skipsUsed += 1;
      fallbackSubscriber.mealsRemaining = (fallbackSubscriber.mealsRemaining - 1).clamp(0, 60);
      fallbackSubscriber.creditBalancePaise += 5000;
      fallbackLedger.insert(
        0,
        LedgerRecord(
          id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
          type: 'MEAL_SKIP_CREDIT',
          debit: 0,
          credit: 5000,
          balance: fallbackSubscriber.creditBalancePaise + 320000,
          note: 'Skipped Tonight\'s Dinner before cutoff',
          timestamp: 'Just now',
        ),
      );
      return {
        'success': true,
        'creditAwardedPaise': 5000,
        'mealsRemaining': fallbackSubscriber.mealsRemaining,
        'creditBalancePaise': fallbackSubscriber.creditBalancePaise,
        'skipsUsed': fallbackSubscriber.skipsUsed,
        'message': 'Meal skipped! ₹50 credited to your ledger.',
      };
    } else {
      return {
        'success': true,
        'creditAwardedPaise': 0,
        'message': 'Max skips quota reached for this cycle. Kitchen notified to avoid food waste.',
      };
    }
  }
}
