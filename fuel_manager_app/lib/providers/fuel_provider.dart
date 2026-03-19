import 'package:flutter/foundation.dart';
import '../database/database_helper.dart';
import '../models/fuel_entry.dart';

class FuelProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  
  List<FuelEntry> _entries = [];
  FuelStatistics _statistics = FuelStatistics.empty();
  bool _isLoading = false;
  String? _error;
  int? _currentCarId;

  List<FuelEntry> get entries => _entries;
  FuelStatistics get statistics => _statistics;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasEntries => _entries.isNotEmpty;

  Future<void> loadEntries(int? carId) async {
    _isLoading = true;
    _error = null;
    _currentCarId = carId;
    notifyListeners();

    try {
      if (carId != null) {
        _entries = await _db.getFuelEntriesByCarId(carId);
        _statistics = await _db.getStatisticsByCarId(carId);
      } else {
        _entries = await _db.getAllFuelEntries();
        _statistics = await _db.getAllStatistics();
      }
    } catch (e) {
      _error = 'Erro ao carregar abastecimentos: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshStatistics() async {
    try {
      if (_currentCarId != null) {
        _statistics = await _db.getStatisticsByCarId(_currentCarId!);
      } else {
        _statistics = await _db.getAllStatistics();
      }
      notifyListeners();
    } catch (e) {
      _error = 'Erro ao atualizar estatísticas: $e';
      notifyListeners();
    }
  }

  Future<bool> addEntry(FuelEntry entry) async {
    try {
      final id = await _db.insertFuelEntry(entry);
      final newEntry = entry.copyWith(id: id);
      _entries.insert(0, newEntry);
      _entries.sort((a, b) => b.date.compareTo(a.date));
      await refreshStatistics();
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erro ao adicionar abastecimento: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateEntry(FuelEntry entry) async {
    try {
      await _db.updateFuelEntry(entry);
      final index = _entries.indexWhere((e) => e.id == entry.id);
      if (index != -1) {
        _entries[index] = entry;
      }
      await refreshStatistics();
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erro ao atualizar abastecimento: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteEntry(int id) async {
    try {
      await _db.deleteFuelEntry(id);
      _entries.removeWhere((e) => e.id == id);
      await refreshStatistics();
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erro ao deletar abastecimento: $e';
      notifyListeners();
      return false;
    }
  }

  Future<FuelEntry?> getLastEntry(int carId) async {
    try {
      return await _db.getLastFuelEntryByCarId(carId);
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getMonthlySpending(int carId, {int months = 12}) async {
    try {
      return await _db.getMonthlySpending(carId, months: months);
    } catch (e) {
      return [];
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
