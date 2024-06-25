import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PreferenceInfo {
  static const first_name = 'name';

  static const family_name = 'family_name';

  static const preferred_username = "preferred_username";

  static const access_Token = 'access_token';

  static const owner_id = 'owner_id';

  static const main_domain = 'main_domain';

  static const list_domain_data = 'list_domain_data';

  static const connectTokenResponse = 'connectTokenResponse';

  static const localeLanguage = 'localeLanguage';

  static const password = 'password';

  static const isChecked = 'isChecked';

  static const loginPayload = 'loginPayload';
  
  static const refresh_token = 'refresh_token';

  Future<void> init() async {}

  Future<void> setConnectTokenResponse(String response) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(connectTokenResponse, response);
  }

  Future<String?> getConnectTokenResponse() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(connectTokenResponse);
  }

  Future<void> saveUserInfo(
    String firstName,
    String familyName,
    String phonenumber,
    String accessToken,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await Future.wait([
      preferences.setString(first_name, firstName),
      preferences.setString(family_name, familyName),
      preferences.setString(preferred_username, phonenumber),
      preferences.setString(access_Token, accessToken),
    ]);
  }

  Future<void> setDomain(String domain) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(main_domain, domain);
  }

  Future<void> setOwnerID(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(owner_id, value);
  }

  Future<void> setPhoneNumber(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(preferred_username, value);
  }

  Future<void> setListDomainData(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(list_domain_data, value);
  }

  Future<void> setIsChecked(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(isChecked, value);
  }

  Future<void> setPassword(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(password, value);
  }

  Future<void> setLoginPayload(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(loginPayload, value);
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

  Future<String?> getListDomainData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(list_domain_data);
  }

  Future<void> setLocaleLanguage(String langCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(localeLanguage, langCode);
  }

  Future<String?> getLocaleLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(localeLanguage);
  }

  Future<bool?> getIsChecked() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isChecked);
  }

  Future<String?> getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(password);
  }

  Future<String?> getLoginPayload() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(loginPayload);
  }

  Future<void> setRefreshToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(refresh_token, value);
  }

  Future<String?> getRefreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(refresh_token);
  }
}
