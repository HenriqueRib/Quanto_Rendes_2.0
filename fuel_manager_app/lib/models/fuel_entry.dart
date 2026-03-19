class FuelEntry {
  final int? id;
  final int carId;
  final DateTime date;
  final double odometer; // km atual
  final double liters;
  final double pricePerLiter;
  final double totalPrice;
  final String fuelType; // 'gasoline', 'ethanol', 'diesel'
  final String? station;
  final String? notes;
  final bool fullTank;
  final DateTime createdAt;

  FuelEntry({
    this.id,
    required this.carId,
    required this.date,
    required this.odometer,
    required this.liters,
    required this.pricePerLiter,
    required this.totalPrice,
    required this.fuelType,
    this.station,
    this.notes,
    this.fullTank = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'car_id': carId,
      'date': date.toIso8601String(),
      'odometer': odometer,
      'liters': liters,
      'price_per_liter': pricePerLiter,
      'total_price': totalPrice,
      'fuel_type': fuelType,
      'station': station,
      'notes': notes,
      'full_tank': fullTank ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FuelEntry.fromMap(Map<String, dynamic> map) {
    return FuelEntry(
      id: map['id'] as int?,
      carId: map['car_id'] as int,
      date: DateTime.parse(map['date'] as String),
      odometer: (map['odometer'] as num).toDouble(),
      liters: (map['liters'] as num).toDouble(),
      pricePerLiter: (map['price_per_liter'] as num).toDouble(),
      totalPrice: (map['total_price'] as num).toDouble(),
      fuelType: map['fuel_type'] as String,
      station: map['station'] as String?,
      notes: map['notes'] as String?,
      fullTank: map['full_tank'] == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  FuelEntry copyWith({
    int? id,
    int? carId,
    DateTime? date,
    double? odometer,
    double? liters,
    double? pricePerLiter,
    double? totalPrice,
    String? fuelType,
    String? station,
    String? notes,
    bool? fullTank,
    DateTime? createdAt,
  }) {
    return FuelEntry(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      date: date ?? this.date,
      odometer: odometer ?? this.odometer,
      liters: liters ?? this.liters,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      totalPrice: totalPrice ?? this.totalPrice,
      fuelType: fuelType ?? this.fuelType,
      station: station ?? this.station,
      notes: notes ?? this.notes,
      fullTank: fullTank ?? this.fullTank,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get fuelTypeLabel {
    switch (fuelType) {
      case 'gasoline':
        return 'Gasolina';
      case 'ethanol':
        return 'Álcool';
      case 'diesel':
        return 'Diesel';
      default:
        return fuelType;
    }
  }
}

class FuelStatistics {
  final double totalLiters;
  final double totalSpent;
  final double averageConsumption; // km/L
  final double averagePricePerLiter;
  final double totalKm;
  final int totalEntries;
  final Map<String, double> consumptionByFuelType;
  final Map<String, double> spentByFuelType;

  FuelStatistics({
    required this.totalLiters,
    required this.totalSpent,
    required this.averageConsumption,
    required this.averagePricePerLiter,
    required this.totalKm,
    required this.totalEntries,
    required this.consumptionByFuelType,
    required this.spentByFuelType,
  });

  factory FuelStatistics.empty() {
    return FuelStatistics(
      totalLiters: 0,
      totalSpent: 0,
      averageConsumption: 0,
      averagePricePerLiter: 0,
      totalKm: 0,
      totalEntries: 0,
      consumptionByFuelType: {},
      spentByFuelType: {},
    );
  }
}
