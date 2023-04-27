import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPref;

  static Future<void> init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<void> setData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      await sharedPref.setInt(key, value);
    } else if (value is double) {
      await sharedPref.setDouble(key, value);
    } else if (value is String) {
      await sharedPref.setString(key, value);
    } else {
      await sharedPref.setBool(key, value);
    }
  }

  static Future<dynamic> getData({required String key}) async {
    return sharedPref.get(key);
  }

  static Future<bool> remove(String key) async {
    return await sharedPref.remove(key);
  }
}
