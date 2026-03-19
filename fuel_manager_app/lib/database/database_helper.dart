import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/car.dart';
import '../models/fuel_entry.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('fuel_manager.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        brand TEXT NOT NULL,
        model TEXT NOT NULL,
        year INTEGER NOT NULL,
        plate TEXT NOT NULL,
        fuel_type TEXT NOT NULL,
        tank_capacity REAL NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE fuel_entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        car_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        odometer REAL NOT NULL,
        liters REAL NOT NULL,
        price_per_liter REAL NOT NULL,
        total_price REAL NOT NULL,
        fuel_type TEXT NOT NULL,
        station TEXT,
        notes TEXT,
        full_tank INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_fuel_entries_car_id ON fuel_entries (car_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_fuel_entries_date ON fuel_entries (date)
    ''');
  }

  // ==================== CAR OPERATIONS ====================

  Future<int> insertCar(Car car) async {
    final db = await database;
    final map = car.toMap();
    map.remove('id');
    return await db.insert('cars', map);
  }

  Future<List<Car>> getAllCars() async {
    final db = await database;
    final result = await db.query('cars', orderBy: 'name ASC');
    return result.map((map) => Car.fromMap(map)).toList();
  }

  Future<Car?> getCarById(int id) async {
    final db = await database;
    final result = await db.query('cars', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return Car.fromMap(result.first);
  }

  Future<int> updateCar(Car car) async {
    final db = await database;
    return await db.update(
      'cars',
      car.toMap(),
      where: 'id = ?',
      whereArgs: [car.id],
    );
  }

  Future<int> deleteCar(int id) async {
    final db = await database;
    await db.delete('fuel_entries', where: 'car_id = ?', whereArgs: [id]);
    return await db.delete('cars', where: 'id = ?', whereArgs: [id]);
  }

  // ==================== FUEL ENTRY OPERATIONS ====================

  Future<int> insertFuelEntry(FuelEntry entry) async {
    final db = await database;
    final map = entry.toMap();
    map.remove('id');
    return await db.insert('fuel_entries', map);
  }

  Future<List<FuelEntry>> getFuelEntriesByCarId(int carId, {int? limit}) async {
    final db = await database;
    final result = await db.query(
      'fuel_entries',
      where: 'car_id = ?',
      whereArgs: [carId],
      orderBy: 'date DESC, id DESC',
      limit: limit,
    );
    return result.map((map) => FuelEntry.fromMap(map)).toList();
  }

  Future<List<FuelEntry>> getAllFuelEntries({int? limit}) async {
    final db = await database;
    final result = await db.query(
      'fuel_entries',
      orderBy: 'date DESC, id DESC',
      limit: limit,
    );
    return result.map((map) => FuelEntry.fromMap(map)).toList();
  }

  Future<FuelEntry?> getFuelEntryById(int id) async {
    final db = await database;
    final result = await db.query('fuel_entries', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return FuelEntry.fromMap(result.first);
  }

  Future<FuelEntry?> getLastFuelEntryByCarId(int carId) async {
    final db = await database;
    final result = await db.query(
      'fuel_entries',
      where: 'car_id = ?',
      whereArgs: [carId],
      orderBy: 'odometer DESC',
      limit: 1,
    );
    if (result.isEmpty) return null;
    return FuelEntry.fromMap(result.first);
  }

  Future<int> updateFuelEntry(FuelEntry entry) async {
    final db = await database;
    return await db.update(
      'fuel_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteFuelEntry(int id) async {
    final db = await database;
    return await db.delete('fuel_entries', where: 'id = ?', whereArgs: [id]);
  }

  // ==================== STATISTICS ====================

  Future<FuelStatistics> getStatisticsByCarId(int carId) async {
    final entries = await getFuelEntriesByCarId(carId);
    return _calculateStatistics(entries);
  }

  Future<FuelStatistics> getAllStatistics() async {
    final entries = await getAllFuelEntries();
    return _calculateStatistics(entries);
  }

  FuelStatistics _calculateStatistics(List<FuelEntry> entries) {
    if (entries.isEmpty) {
      return FuelStatistics.empty();
    }

    double totalLiters = 0;
    double totalSpent = 0;
    double totalKm = 0;
    Map<String, double> consumptionByFuelType = {};
    Map<String, double> spentByFuelType = {};
    Map<String, double> litersByFuelType = {};
    Map<String, double> kmByFuelType = {};

    final sortedEntries = List<FuelEntry>.from(entries)
      ..sort((a, b) => a.odometer.compareTo(b.odometer));

    for (int i = 0; i < sortedEntries.length; i++) {
      final entry = sortedEntries[i];
      totalLiters += entry.liters;
      totalSpent += entry.totalPrice;

      spentByFuelType[entry.fuelType] = 
          (spentByFuelType[entry.fuelType] ?? 0) + entry.totalPrice;
      litersByFuelType[entry.fuelType] = 
          (litersByFuelType[entry.fuelType] ?? 0) + entry.liters;

      if (i > 0 && entry.fullTank) {
        final prevEntry = sortedEntries[i - 1];
        final kmDriven = entry.odometer - prevEntry.odometer;
        if (kmDriven > 0) {
          totalKm += kmDriven;
          kmByFuelType[prevEntry.fuelType] = 
              (kmByFuelType[prevEntry.fuelType] ?? 0) + kmDriven;
        }
      }
    }

    for (final fuelType in litersByFuelType.keys) {
      final km = kmByFuelType[fuelType] ?? 0;
      final liters = litersByFuelType[fuelType] ?? 0;
      if (liters > 0 && km > 0) {
        consumptionByFuelType[fuelType] = km / liters;
      }
    }

    return FuelStatistics(
      totalLiters: totalLiters,
      totalSpent: totalSpent,
      averageConsumption: totalLiters > 0 && totalKm > 0 ? totalKm / totalLiters : 0,
      averagePricePerLiter: totalLiters > 0 ? totalSpent / totalLiters : 0,
      totalKm: totalKm,
      totalEntries: entries.length,
      consumptionByFuelType: consumptionByFuelType,
      spentByFuelType: spentByFuelType,
    );
  }

  Future<List<Map<String, dynamic>>> getMonthlySpending(int carId, {int months = 12}) async {
    final db = await database;
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - months + 1, 1);
    
    final result = await db.rawQuery('''
      SELECT 
        strftime('%Y-%m', date) as month,
        SUM(total_price) as total,
        SUM(liters) as liters,
        fuel_type
      FROM fuel_entries
      WHERE car_id = ? AND date >= ?
      GROUP BY strftime('%Y-%m', date), fuel_type
      ORDER BY month ASC
    ''', [carId, startDate.toIso8601String()]);
    
    return result;
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }
}
