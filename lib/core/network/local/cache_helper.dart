import 'package:nemoventrt/core/di/injections.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class CacheHelper {
  static dynamic getData({required String key}) => sl<SharedPreferences>().get(
    key,
  );

  static Future<bool> saveData({
    required String key,
    required Object value,
  }) async {
    final preferences = sl<SharedPreferences>();
    if (value is String) return preferences.setString(key, value);
    if (value is int) return preferences.setInt(key, value);
    if (value is bool) return preferences.setBool(key, value);
    if (value is double) return preferences.setDouble(key, value);
    if (value is List<String>) return preferences.setStringList(key, value);
    return false;
  }
}
