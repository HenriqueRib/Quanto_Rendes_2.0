import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/car.dart';
import '../models/fuel_entry.dart';
import '../models/maintenance.dart';
import '../models/favorite_station.dart';
import '../models/economy_goal.dart';

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
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
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

    await _createNewTables(db);
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createNewTables(db);
    }
  }

  Future<void> _createNewTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS maintenance (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        car_id INTEGER NOT NULL,
        type TEXT NOT NULL,
        title TEXT NOT NULL,
        last_odometer REAL,
        last_date TEXT,
        interval_km REAL NOT NULL,
        interval_days INTEGER NOT NULL,
        is_completed INTEGER NOT NULL DEFAULT 0,
        notes TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS favorite_stations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT,
        brand TEXT,
        latitude REAL,
        longitude REAL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS economy_goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        car_id INTEGER NOT NULL,
        target_consumption REAL NOT NULL,
        monthly_budget REAL,
        monthly_km_limit REAL,
        start_date TEXT NOT NULL,
        end_date TEXT,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_maintenance_car_id ON maintenance (car_id)
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_economy_goals_car_id ON economy_goals (car_id)
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
    await db.delete('maintenance', where: 'car_id = ?', whereArgs: [id]);
    await db.delete('economy_goals', where: 'car_id = ?', whereArgs: [id]);
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

  // ==================== MAINTENANCE OPERATIONS ====================

  Future<int> insertMaintenance(Maintenance maintenance) async {
    final db = await database;
    final map = maintenance.toMap();
    map.remove('id');
    return await db.insert('maintenance', map);
  }

  Future<List<Maintenance>> getMaintenanceByCarId(int carId) async {
    final db = await database;
    final result = await db.query(
      'maintenance',
      where: 'car_id = ?',
      whereArgs: [carId],
      orderBy: 'created_at DESC',
    );
    return result.map((map) => Maintenance.fromMap(map)).toList();
  }

  Future<List<Maintenance>> getAllMaintenance() async {
    final db = await database;
    final result = await db.query('maintenance', orderBy: 'created_at DESC');
    return result.map((map) => Maintenance.fromMap(map)).toList();
  }

  Future<int> updateMaintenance(Maintenance maintenance) async {
    final db = await database;
    return await db.update(
      'maintenance',
      maintenance.toMap(),
      where: 'id = ?',
      whereArgs: [maintenance.id],
    );
  }

  Future<int> deleteMaintenance(int id) async {
    final db = await database;
    return await db.delete('maintenance', where: 'id = ?', whereArgs: [id]);
  }

  // ==================== FAVORITE STATIONS OPERATIONS ====================

  Future<int> insertFavoriteStation(FavoriteStation station) async {
    final db = await database;
    final map = station.toMap();
    map.remove('id');
    return await db.insert('favorite_stations', map);
  }

  Future<List<FavoriteStation>> getAllFavoriteStations() async {
    final db = await database;
    final result = await db.query('favorite_stations', orderBy: 'name ASC');
    return result.map((map) => FavoriteStation.fromMap(map)).toList();
  }

  Future<int> updateFavoriteStation(FavoriteStation station) async {
    final db = await database;
    return await db.update(
      'favorite_stations',
      station.toMap(),
      where: 'id = ?',
      whereArgs: [station.id],
    );
  }

  Future<int> deleteFavoriteStation(int id) async {
    final db = await database;
    return await db.delete('favorite_stations', where: 'id = ?', whereArgs: [id]);
  }

  // ==================== ECONOMY GOALS OPERATIONS ====================

  Future<int> insertEconomyGoal(EconomyGoal goal) async {
    final db = await database;
    final map = goal.toMap();
    map.remove('id');
    return await db.insert('economy_goals', map);
  }

  Future<List<EconomyGoal>> getEconomyGoalsByCarId(int carId) async {
    final db = await database;
    final result = await db.query(
      'economy_goals',
      where: 'car_id = ?',
      whereArgs: [carId],
      orderBy: 'created_at DESC',
    );
    return result.map((map) => EconomyGoal.fromMap(map)).toList();
  }

  Future<EconomyGoal?> getActiveEconomyGoal(int carId) async {
    final db = await database;
    final result = await db.query(
      'economy_goals',
      where: 'car_id = ? AND is_active = 1',
      whereArgs: [carId],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return EconomyGoal.fromMap(result.first);
  }

  Future<int> updateEconomyGoal(EconomyGoal goal) async {
    final db = await database;
    return await db.update(
      'economy_goals',
      goal.toMap(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }

  Future<int> deleteEconomyGoal(int id) async {
    final db = await database;
    return await db.delete('economy_goals', where: 'id = ?', whereArgs: [id]);
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

  Future<Map<String, dynamic>> getMonthlyStats(int carId) async {
    final db = await database;
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    final result = await db.rawQuery('''
      SELECT 
        SUM(total_price) as total_spent,
        SUM(liters) as total_liters,
        COUNT(*) as entries_count,
        MAX(odometer) - MIN(odometer) as km_driven
      FROM fuel_entries
      WHERE car_id = ? AND date >= ? AND date <= ?
    ''', [carId, startOfMonth.toIso8601String(), endOfMonth.toIso8601String()]);

    if (result.isEmpty || result.first['total_spent'] == null) {
      return {
        'total_spent': 0.0,
        'total_liters': 0.0,
        'entries_count': 0,
        'km_driven': 0.0,
      };
    }

    return {
      'total_spent': (result.first['total_spent'] as num?)?.toDouble() ?? 0.0,
      'total_liters': (result.first['total_liters'] as num?)?.toDouble() ?? 0.0,
      'entries_count': (result.first['entries_count'] as int?) ?? 0,
      'km_driven': (result.first['km_driven'] as num?)?.toDouble() ?? 0.0,
    };
  }

  Future<double> getAverageMonthlySpending(int carId, {int months = 6}) async {
    final db = await database;
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - months, 1);

    final result = await db.rawQuery('''
      SELECT AVG(monthly_total) as average
      FROM (
        SELECT strftime('%Y-%m', date) as month, SUM(total_price) as monthly_total
        FROM fuel_entries
        WHERE car_id = ? AND date >= ?
        GROUP BY strftime('%Y-%m', date)
      )
    ''', [carId, startDate.toIso8601String()]);

    if (result.isEmpty || result.first['average'] == null) {
      return 0.0;
    }

    return (result.first['average'] as num).toDouble();
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }
}
