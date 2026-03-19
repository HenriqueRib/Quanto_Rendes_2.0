class Car {
  final int? id;
  final String name;
  final String brand;
  final String model;
  final int year;
  final String plate;
  final String fuelType; // 'flex', 'gasoline', 'ethanol', 'diesel'
  final double tankCapacity;
  final DateTime createdAt;

  Car({
    this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.plate,
    required this.fuelType,
    required this.tankCapacity,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'year': year,
      'plate': plate,
      'fuel_type': fuelType,
      'tank_capacity': tankCapacity,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] as int?,
      name: map['name'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as int,
      plate: map['plate'] as String,
      fuelType: map['fuel_type'] as String,
      tankCapacity: (map['tank_capacity'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Car copyWith({
    int? id,
    String? name,
    String? brand,
    String? model,
    int? year,
    String? plate,
    String? fuelType,
    double? tankCapacity,
    DateTime? createdAt,
  }) {
    return Car(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
      fuelType: fuelType ?? this.fuelType,
      tankCapacity: tankCapacity ?? this.tankCapacity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get fuelTypeLabel {
    switch (fuelType) {
      case 'flex':
        return 'Flex';
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

  @override
  String toString() => '$name ($brand $model)';
}
