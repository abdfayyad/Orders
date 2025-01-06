import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static   SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (sharedPreferences == null) {
      throw Exception("SharedPreferences not initialized. Call SharedPref.init() first.");
    }
    if (value == null) {
      throw Exception("The value for '$key' cannot be null.");
    }
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    }
    throw Exception("Unsupported value type for SharedPreferences.");
  }

  static dynamic getData({
    required String key,
  }) =>
      sharedPreferences!.get(key);

  static Future<bool> removeData({required String key})async
  {
    return await sharedPreferences!.remove(key);
  }
}