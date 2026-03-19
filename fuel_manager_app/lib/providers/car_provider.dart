import 'package:flutter/foundation.dart';
import '../database/database_helper.dart';
import '../models/car.dart';

class CarProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  
  List<Car> _cars = [];
  Car? _selectedCar;
  bool _isLoading = false;
  String? _error;

  List<Car> get cars => _cars;
  Car? get selectedCar => _selectedCar;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasCars => _cars.isNotEmpty;

  Future<void> loadCars() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cars = await _db.getAllCars();
      if (_selectedCar != null) {
        _selectedCar = _cars.firstWhere(
          (c) => c.id == _selectedCar!.id,
          orElse: () => _cars.isNotEmpty ? _cars.first : _selectedCar!,
        );
      } else if (_cars.isNotEmpty) {
        _selectedCar = _cars.first;
      }
    } catch (e) {
      _error = 'Erro ao carregar carros: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addCar(Car car) async {
    try {
      final id = await _db.insertCar(car);
      final newCar = car.copyWith(id: id);
      _cars.add(newCar);
      _cars.sort((a, b) => a.name.compareTo(b.name));
      
      if (_selectedCar == null) {
        _selectedCar = newCar;
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erro ao adicionar carro: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCar(Car car) async {
    try {
      await _db.updateCar(car);
      final index = _cars.indexWhere((c) => c.id == car.id);
      if (index != -1) {
        _cars[index] = car;
        if (_selectedCar?.id == car.id) {
          _selectedCar = car;
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erro ao atualizar carro: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCar(int id) async {
    try {
      await _db.deleteCar(id);
      _cars.removeWhere((c) => c.id == id);
      if (_selectedCar?.id == id) {
        _selectedCar = _cars.isNotEmpty ? _cars.first : null;
      }
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erro ao deletar carro: $e';
      notifyListeners();
      return false;
    }
  }

  void selectCar(Car car) {
    _selectedCar = car;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
