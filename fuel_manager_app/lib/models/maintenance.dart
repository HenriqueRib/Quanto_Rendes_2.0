class Maintenance {
  final int? id;
  final int carId;
  final String type; // oil_change, air_filter, fuel_filter, tires, brake_pads, etc
  final String title;
  final double? lastOdometer;
  final DateTime? lastDate;
  final double intervalKm; // intervalo em km
  final int intervalDays; // intervalo em dias
  final bool isCompleted;
  final String? notes;
  final DateTime createdAt;

  Maintenance({
    this.id,
    required this.carId,
    required this.type,
    required this.title,
    this.lastOdometer,
    this.lastDate,
    required this.intervalKm,
    required this.intervalDays,
    this.isCompleted = false,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'car_id': carId,
      'type': type,
      'title': title,
      'last_odometer': lastOdometer,
      'last_date': lastDate?.toIso8601String(),
      'interval_km': intervalKm,
      'interval_days': intervalDays,
      'is_completed': isCompleted ? 1 : 0,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Maintenance.fromMap(Map<String, dynamic> map) {
    return Maintenance(
      id: map['id'] as int?,
      carId: map['car_id'] as int,
      type: map['type'] as String,
      title: map['title'] as String,
      lastOdometer: map['last_odometer'] != null ? (map['last_odometer'] as num).toDouble() : null,
      lastDate: map['last_date'] != null ? DateTime.parse(map['last_date'] as String) : null,
      intervalKm: (map['interval_km'] as num).toDouble(),
      intervalDays: map['interval_days'] as int,
      isCompleted: map['is_completed'] == 1,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Maintenance copyWith({
    int? id,
    int? carId,
    String? type,
    String? title,
    double? lastOdometer,
    DateTime? lastDate,
    double? intervalKm,
    int? intervalDays,
    bool? isCompleted,
    String? notes,
    DateTime? createdAt,
  }) {
    return Maintenance(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      type: type ?? this.type,
      title: title ?? this.title,
      lastOdometer: lastOdometer ?? this.lastOdometer,
      lastDate: lastDate ?? this.lastDate,
      intervalKm: intervalKm ?? this.intervalKm,
      intervalDays: intervalDays ?? this.intervalDays,
      isCompleted: isCompleted ?? this.isCompleted,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  double? getProgressByKm(double currentOdometer) {
    if (lastOdometer == null) return null;
    final kmSinceLast = currentOdometer - lastOdometer!;
    return (kmSinceLast / intervalKm).clamp(0.0, 1.5);
  }

  double? getProgressByDate() {
    if (lastDate == null) return null;
    final daysSinceLast = DateTime.now().difference(lastDate!).inDays;
    return (daysSinceLast / intervalDays).clamp(0.0, 1.5);
  }

  bool needsMaintenance(double currentOdometer) {
    final kmProgress = getProgressByKm(currentOdometer);
    final dateProgress = getProgressByDate();
    
    if (kmProgress != null && kmProgress >= 1.0) return true;
    if (dateProgress != null && dateProgress >= 1.0) return true;
    
    return false;
  }

  bool isOverdue(double currentOdometer) {
    final kmProgress = getProgressByKm(currentOdometer);
    final dateProgress = getProgressByDate();
    
    if (kmProgress != null && kmProgress > 1.0) return true;
    if (dateProgress != null && dateProgress > 1.0) return true;
    
    return false;
  }

  String get typeLabel {
    switch (type) {
      case 'oil_change':
        return 'Troca de Óleo';
      case 'air_filter':
        return 'Filtro de Ar';
      case 'fuel_filter':
        return 'Filtro de Combustível';
      case 'cabin_filter':
        return 'Filtro de Cabine';
      case 'tires':
        return 'Pneus';
      case 'brake_pads':
        return 'Pastilhas de Freio';
      case 'timing_belt':
        return 'Correia Dentada';
      case 'spark_plugs':
        return 'Velas de Ignição';
      case 'coolant':
        return 'Fluido de Arrefecimento';
      case 'transmission':
        return 'Óleo de Câmbio';
      case 'battery':
        return 'Bateria';
      case 'alignment':
        return 'Alinhamento';
      case 'balancing':
        return 'Balanceamento';
      default:
        return title;
    }
  }
}

class MaintenanceType {
  final String type;
  final String label;
  final String icon;
  final double defaultIntervalKm;
  final int defaultIntervalDays;

  const MaintenanceType({
    required this.type,
    required this.label,
    required this.icon,
    required this.defaultIntervalKm,
    required this.defaultIntervalDays,
  });

  static const List<MaintenanceType> all = [
    MaintenanceType(
      type: 'oil_change',
      label: 'Troca de Óleo',
      icon: 'oil',
      defaultIntervalKm: 10000,
      defaultIntervalDays: 365,
    ),
    MaintenanceType(
      type: 'air_filter',
      label: 'Filtro de Ar',
      icon: 'air',
      defaultIntervalKm: 15000,
      defaultIntervalDays: 365,
    ),
    MaintenanceType(
      type: 'fuel_filter',
      label: 'Filtro de Combustível',
      icon: 'fuel',
      defaultIntervalKm: 40000,
      defaultIntervalDays: 730,
    ),
    MaintenanceType(
      type: 'cabin_filter',
      label: 'Filtro de Cabine',
      icon: 'cabin',
      defaultIntervalKm: 15000,
      defaultIntervalDays: 365,
    ),
    MaintenanceType(
      type: 'tires',
      label: 'Pneus',
      icon: 'tire',
      defaultIntervalKm: 50000,
      defaultIntervalDays: 1460,
    ),
    MaintenanceType(
      type: 'brake_pads',
      label: 'Pastilhas de Freio',
      icon: 'brake',
      defaultIntervalKm: 40000,
      defaultIntervalDays: 730,
    ),
    MaintenanceType(
      type: 'timing_belt',
      label: 'Correia Dentada',
      icon: 'belt',
      defaultIntervalKm: 60000,
      defaultIntervalDays: 1825,
    ),
    MaintenanceType(
      type: 'spark_plugs',
      label: 'Velas de Ignição',
      icon: 'spark',
      defaultIntervalKm: 30000,
      defaultIntervalDays: 730,
    ),
    MaintenanceType(
      type: 'coolant',
      label: 'Fluido de Arrefecimento',
      icon: 'coolant',
      defaultIntervalKm: 50000,
      defaultIntervalDays: 730,
    ),
    MaintenanceType(
      type: 'battery',
      label: 'Bateria',
      icon: 'battery',
      defaultIntervalKm: 60000,
      defaultIntervalDays: 1095,
    ),
  ];
}
