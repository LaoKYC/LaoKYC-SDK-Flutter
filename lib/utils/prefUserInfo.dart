import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PreferenceInfo {
  static const first_name = 'name';

  static const family_name = 'family_name';

  static const preferred_username = "preferred_username";

  static const access_Token = 'access_token';

  static const owner_id = 'owner_id';

  static const main_domain = 'main_domain';

  Future<void> init() async {}

  Future<void> saveUserInfo(String firstName, String familyName,
      String phonenumber, String accessToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(first_name, firstName);
    preferences.setString(family_name, familyName);
    preferences.setString(preferred_username, phonenumber);
    preferences.setString(access_Token, accessToken);
  }

  Future<void> setDomain(String domain) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(main_domain, domain);
  }

  Future<void> setOwnerID(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(owner_id, value);
  }

  Future<List<String>> getUserInfo() async {
    List<String> arrUserInfo = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? firstName = preferences.getString(first_name);
    String? familyName = preferences.getString(family_name);
    String? preferredUsername = preferences.getString(preferred_username);
    String? accessToken = preferences.getString(access_Token);
    arrUserInfo.add(firstName!);
    arrUserInfo.add(familyName!);
    arrUserInfo.add(preferredUsername!);
    arrUserInfo.add(accessToken!);
    return arrUserInfo;
  }

  Future<String?> getOwnerID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(owner_id);
  }

  Future<String?> getDomain() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(main_domain);
  }

  Future<String?> getPhoneNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(preferred_username);
  }
}
