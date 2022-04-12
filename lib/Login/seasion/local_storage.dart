import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static const _accessToken = 'access_token';

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessToken);
  }

  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_accessToken, token);
  }

  static Future<void> deleteAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_accessToken);
  }
}
