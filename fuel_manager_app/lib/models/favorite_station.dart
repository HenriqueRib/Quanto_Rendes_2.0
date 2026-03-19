class FavoriteStation {
  final int? id;
  final String name;
  final String? address;
  final String? brand; // Shell, Ipiranga, BR, etc
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  FavoriteStation({
    this.id,
    required this.name,
    this.address,
    this.brand,
    this.latitude,
    this.longitude,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'brand': brand,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FavoriteStation.fromMap(Map<String, dynamic> map) {
    return FavoriteStation(
      id: map['id'] as int?,
      name: map['name'] as String,
      address: map['address'] as String?,
      brand: map['brand'] as String?,
      latitude: map['latitude'] != null ? (map['latitude'] as num).toDouble() : null,
      longitude: map['longitude'] != null ? (map['longitude'] as num).toDouble() : null,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  FavoriteStation copyWith({
    int? id,
    String? name,
    String? address,
    String? brand,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  }) {
    return FavoriteStation(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      brand: brand ?? this.brand,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => name;
}

class StationBrand {
  static const List<String> brands = [
    'Shell',
    'Ipiranga',
    'BR Petrobras',
    'Ale',
    'Raízen',
    'Cosan',
    'Total',
    'Repsol',
    'Gulf',
    'Outro',
  ];
}
