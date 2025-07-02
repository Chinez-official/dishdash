import 'package:shared_preferences/shared_preferences.dart';

abstract class OfflineClient {
  Future<bool> setString(String key, String value);
  String getString(String key);
  Future<bool> setBool(String key, bool value);
  bool getBool(String key);
  Future<bool> clearStorage();
  Future<bool> remove(String key);
}

class OfflineClientImpl implements OfflineClient {
  static OfflineClientImpl? _instance;
  static SharedPreferences? _preferences;

  static Future<OfflineClientImpl> getInstance() async {
    _instance ??= OfflineClientImpl();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  @override
  String getString(String key) => _preferences?.getString(key) ?? '';

  @override
  Future<bool> setString(String key, String value) async =>
      await _preferences?.setString(key, value) ?? false;

  @override
  bool getBool(String key) => _preferences?.getBool(key) ?? false;

  @override
  Future<bool> setBool(String key, bool value) async =>
      await _preferences?.setBool(key, value) ?? false;

  @override
  Future<bool> clearStorage() async => await _preferences?.clear() ?? false;

  @override
  Future<bool> remove(String key) async => await _preferences?.remove(key) ?? false;

  // Static getters for quick access
  static String get userFirstName =>
      _preferences?.getString('USER_FIRST_NAME') ?? '';
      
  static String get userToken =>
      _preferences?.getString('USER_TOKEN') ?? '';
      
  static bool get isLoggedIn =>
      _preferences?.getBool('IS_LOGGED_IN') ?? false;
}