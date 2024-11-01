import 'package:my_crypto_asset/models/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static const String _userInfoKey = "user_info";

  // Save Userinfo to SharedPreferences
  static Future<void> saveUserInfo(UserInfoData userInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userInfoJson = userInfo.toRawJson();
    await prefs.setString(_userInfoKey, userInfoJson);
  }

  // Retrieve Userinfo from SharedPreferences
  static Future<UserInfoData?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfoJson = prefs.getString(_userInfoKey);
    if (userInfoJson == null) return null;
    return UserInfoData.fromRawJson(userInfoJson);
  }

  // Clear Userinfo from SharedPreferences
  static Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userInfoKey);
  }

  static Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
