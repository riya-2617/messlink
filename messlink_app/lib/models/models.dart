// MessLink Domain Models

class Mess {
  final String id;
  final String name;
  final String fssai;
  final bool fssaiVerified;
  final String city;
  final String locality;
  final String dietary;
  final double rating;
  final int pricePerMonth;
  final int skipCreditPerMeal;
  final String phone;

  Mess({
    required this.id,
    required this.name,
    required this.fssai,
    required this.fssaiVerified,
    required this.city,
    required this.locality,
    required this.dietary,
    required this.rating,
    required this.pricePerMonth,
    required this.skipCreditPerMeal,
    required this.phone,
  });

  factory Mess.fromJson(Map<String, dynamic> json) {
    return Mess(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      fssai: json['fssai'] ?? '',
      fssaiVerified: json['fssaiVerified'] ?? false,
      city: json['city'] ?? '',
      locality: json['locality'] ?? '',
      dietary: json['dietary'] ?? 'PURE_VEG',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      pricePerMonth: json['pricePerMonth'] ?? 3200,
      skipCreditPerMeal: json['skipCreditPerMeal'] ?? 50,
      phone: json['phone'] ?? '+91 98220 12345',
    );
  }
}

class DishItem {
  final String category;
  final String en;
  final String mr;
  final String hi;
  double confidence;

  DishItem({
    required this.category,
    required this.en,
    required this.mr,
    required this.hi,
    this.confidence = 1.0,
  });

  String getLocalizedName(String lang) {
    if (lang == 'mr') return mr;
    if (lang == 'hi') return hi;
    return en;
  }
}

class Subscriber {
  final String id;
  final String userName;
  final String phone;
  int mealsRemaining;
  final int totalMeals;
  int skipsUsed;
  final int maxSkips;
  int creditBalancePaise;

  Subscriber({
    required this.id,
    required this.userName,
    required this.phone,
    required this.mealsRemaining,
    required this.totalMeals,
    required this.skipsUsed,
    required this.maxSkips,
    required this.creditBalancePaise,
  });
}

class LedgerRecord {
  final String id;
  final String type;
  final int debit;
  final int credit;
  final int balance;
  final String note;
  final String timestamp;

  LedgerRecord({
    required this.id,
    required this.type,
    required this.debit,
    required this.credit,
    required this.balance,
    required this.note,
    required this.timestamp,
  });
}
