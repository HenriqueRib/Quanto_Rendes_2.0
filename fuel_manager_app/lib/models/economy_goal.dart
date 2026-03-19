class EconomyGoal {
  final int? id;
  final int carId;
  final double targetConsumption; // km/L desejado
  final double? monthlyBudget; // orçamento mensal em R$
  final double? monthlyKmLimit; // limite de km por mês
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final DateTime createdAt;

  EconomyGoal({
    this.id,
    required this.carId,
    required this.targetConsumption,
    this.monthlyBudget,
    this.monthlyKmLimit,
    required this.startDate,
    this.endDate,
    this.isActive = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'car_id': carId,
      'target_consumption': targetConsumption,
      'monthly_budget': monthlyBudget,
      'monthly_km_limit': monthlyKmLimit,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory EconomyGoal.fromMap(Map<String, dynamic> map) {
    return EconomyGoal(
      id: map['id'] as int?,
      carId: map['car_id'] as int,
      targetConsumption: (map['target_consumption'] as num).toDouble(),
      monthlyBudget: map['monthly_budget'] != null ? (map['monthly_budget'] as num).toDouble() : null,
      monthlyKmLimit: map['monthly_km_limit'] != null ? (map['monthly_km_limit'] as num).toDouble() : null,
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date'] as String) : null,
      isActive: map['is_active'] == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  EconomyGoal copyWith({
    int? id,
    int? carId,
    double? targetConsumption,
    double? monthlyBudget,
    double? monthlyKmLimit,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return EconomyGoal(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      targetConsumption: targetConsumption ?? this.targetConsumption,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      monthlyKmLimit: monthlyKmLimit ?? this.monthlyKmLimit,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  double getConsumptionProgress(double actualConsumption) {
    if (targetConsumption <= 0) return 0;
    return (actualConsumption / targetConsumption).clamp(0.0, 2.0);
  }

  double getBudgetProgress(double actualSpent) {
    if (monthlyBudget == null || monthlyBudget! <= 0) return 0;
    return (actualSpent / monthlyBudget!).clamp(0.0, 2.0);
  }

  double getKmProgress(double actualKm) {
    if (monthlyKmLimit == null || monthlyKmLimit! <= 0) return 0;
    return (actualKm / monthlyKmLimit!).clamp(0.0, 2.0);
  }

  bool isConsumptionGoalMet(double actualConsumption) {
    return actualConsumption >= targetConsumption;
  }

  bool isBudgetWithinLimit(double actualSpent) {
    if (monthlyBudget == null) return true;
    return actualSpent <= monthlyBudget!;
  }

  bool isKmWithinLimit(double actualKm) {
    if (monthlyKmLimit == null) return true;
    return actualKm <= monthlyKmLimit!;
  }
}
