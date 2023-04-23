import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:laokyc_button/constant/data.dart';
import 'package:laokyc_button/model/one_id_reset_model.dart';
import 'package:laokyc_button/src/confirm_otp.dart';
import '../model/connect_refresh_token_model.dart';
import '../services/connect_refresh_token.dart';
import '../services/one_id_reset.dart';
import '../widgets/dialog_loading.dart';

Future<void> requestOTPLogin(
    BuildContext context,
    Locale? locale,
    String phoneNumber,
    String clientID,
    String secret,
    String scope,
    var route,
    bool isFromConfirm, String? fromApp) async {
  showDialog(
      context: context,
      builder: (_) {
        return DialogLoading(title: locale == const Locale('en') ? 'Loading' : 'ກຳລັງໂຫຼດ');
      });
  String grantTypeCredentials = ConstData.grantTypeCredentials;
  String payload = jsonEncode({
    "clientID": clientID,
    "secret": secret,
    "grantType": grantTypeCredentials,
    "scope": scope,
    "username": '',
    "password": ''
  });
  ConnectRefreshTokenModel? connectTokenData =
      await connectTokenLogin(payload, context, 0);
  if (connectTokenData != null) {
    String accessToken = connectTokenData.accessToken!;
    OneIDResetOTP? oneIDResetOTP =
        await oneIDReset(context, phoneNumber, accessToken, 0);
    if (oneIDResetOTP != null) {
      if (isFromConfirm) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return ConfirmOTP(
            clientID: clientID,
            secret: secret,
            scope: scope,
            phoneNumber: phoneNumber,
            route: route,
            fromApp: fromApp,
          );
        }));
      }
    }
  }
}
