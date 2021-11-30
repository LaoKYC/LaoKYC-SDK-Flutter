import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PreferenceInfo {
  SharedPreferences _preferences;

  static const first_name = 'name';

  static const family_name = 'family_name';

  static const preferred_username = "preferred_username";

  static const access_Token = 'access_token';

  Future<void> init() async {}

  Future<void> saveUserInfo(String firstName, String familyName,
      String phonenumber, String accessToken) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString(first_name, firstName);
    _preferences.setString(family_name, familyName);
    _preferences.setString(preferred_username, phonenumber);
    _preferences.setString(access_Token, accessToken);
  }

  Future<List<String>> getUserInfo() async {
    List<String> arrUserInfo = [];
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String firstName = _preferences.getString(first_name);
    String familyName = _preferences.getString(family_name);
    String preferredUsername = _preferences.getString(preferred_username);
    String accessToken = _preferences.getString(access_Token);
    arrUserInfo.add(firstName);
    arrUserInfo.add(familyName);
    arrUserInfo.add(preferredUsername);
    arrUserInfo.add(accessToken);
    return arrUserInfo;
  }
}
