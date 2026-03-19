import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const String _keyPromoCode = 'promo_code';
  static const String _keyAdsRemoved = 'ads_removed';
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyDefaultFuelType = 'default_fuel_type';

  static const List<String> _validPromoCodes = [
    'codeline43',
    'SEMADS2024',
    'PREMIUM',
    'VIPUSER',
  ];

  SharedPreferences? _prefs;
  bool _adsRemoved = false;
  bool _darkMode = false;
  String _appliedPromoCode = '';
  String _defaultFuelType = 'gasoline';
  bool _isLoading = true;

  bool get adsRemoved => _adsRemoved;
  bool get darkMode => _darkMode;
  String get appliedPromoCode => _appliedPromoCode;
  String get defaultFuelType => _defaultFuelType;
  bool get isLoading => _isLoading;
  bool get showAds => !_adsRemoved;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSettings();
  }

  void _loadSettings() {
    _adsRemoved = _prefs?.getBool(_keyAdsRemoved) ?? false;
    _darkMode = _prefs?.getBool(_keyDarkMode) ?? false;
    _appliedPromoCode = _prefs?.getString(_keyPromoCode) ?? '';
    _defaultFuelType = _prefs?.getString(_keyDefaultFuelType) ?? 'gasoline';
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> applyPromoCode(String code) async {
    final normalizedCode = code.trim().toUpperCase();
    final normalizedValidCodes = _validPromoCodes.map((c) => c.toUpperCase()).toList();

    if (normalizedValidCodes.contains(normalizedCode)) {
      _adsRemoved = true;
      _appliedPromoCode = code.trim();
      await _prefs?.setBool(_keyAdsRemoved, true);
      await _prefs?.setString(_keyPromoCode, _appliedPromoCode);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> removePromoCode() async {
    _adsRemoved = false;
    _appliedPromoCode = '';
    await _prefs?.setBool(_keyAdsRemoved, false);
    await _prefs?.setString(_keyPromoCode, '');
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _darkMode = value;
    await _prefs?.setBool(_keyDarkMode, value);
    notifyListeners();
  }

  Future<void> setDefaultFuelType(String type) async {
    _defaultFuelType = type;
    await _prefs?.setString(_keyDefaultFuelType, type);
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    await setDarkMode(!_darkMode);
  }
}
