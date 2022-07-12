import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:laokyc_button/constant/data.dart';
import 'package:laokyc_button/utils/prefUserInfo.dart';
import '../model/connect_refresh_token_model.dart';
import '../services/connect_refresh_token.dart';
import '../widgets/dialog_loading.dart';

/// ສຳລັບ ConfirmOTP
Future<void> confirmOTPToken(
    BuildContext context,
    String clientID,
    String secret,
    List<String> scope,
    String username,
    String password,
    var route) async {
  showDialog(
      context: context,
      builder: (_) {
        return DialogLoading(title: 'ກຳລັງໂຫຼດ');
      });
  String payload = jsonEncode({
    "clientID": clientID,
    "secret": secret,
    "grantType": ConstData.grantType,
    "scope": scope,
    "username": username,
    "password": password
  });
  ConnectRefreshTokenModel? connectTokenData =
      await connectTokenLogin(payload, context);
  if (connectTokenData != null) {
    String accessToken = connectTokenData.accessToken!;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    String firstName = decodedToken["name"];
    String familyName = decodedToken["family_name"];
    String preferredUserName = decodedToken["preferred_username"]; // 205xxxxxxx
    String phone = decodedToken["phone"]; // +856205xxxxxx
    String sub = decodedToken["sub"];
    await PreferenceInfo()
        .saveUserInfo(
            firstName, familyName, preferredUserName, accessToken, sub)
        .then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => route), (route) => false);
    });
  }
}
