import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:laokyc_button/constant/data.dart';
import 'package:laokyc_button/utils/prefUserInfo.dart';
import 'package:laokyc_button/widgets/error_dialog.dart';
import '../model/connect_refresh_token_model.dart';
import '../services/connect_refresh_token.dart';
import '../widgets/dialog_loading.dart';

/// ສຳລັບ ConfirmOTP
Future<void> confirmOTPToken(
    BuildContext context,
    Locale? locale,
    String clientID,
    String secret,
    String scope,
    String username,
    String password,
    var route) async {
  showDialog(
      context: context,
      builder: (_) {
        return DialogLoading(title: locale == const Locale('en') ? 'Loading' : 'ກຳລັງໂຫຼດ');
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
      await connectTokenLogin(payload, context, locale, 0);
  if (connectTokenData != null) {
    String accessToken = connectTokenData.accessToken!;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    String account = decodedToken["account"];

    /// ຖ້າມີເບີຢູ່ໃນລະບົບ
    if (account == 'exist') {
      String firstName = decodedToken["name"];
      String familyName = decodedToken["family_name"];
      String preferredUserName = decodedToken["preferred_username"];
      String ownerID = decodedToken["sub"];
      await PreferenceInfo().setOwnerID(ownerID);
      await PreferenceInfo()
          .saveUserInfo(firstName, familyName, preferredUserName, accessToken)
          .then((value) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => route), (route) => false);
      });
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          locale == const Locale('en') ? 'Sorry' : 'ຂໍອະໄພ',
          locale == const Locale('en') ? 'The number does not exist in LaoKYC\nPlease register your phone number' : 'ເບີຂອງທ່ານບໍ່ທັນມີໃນລະບົບ LaoKYC\nກະລຸນາລົງທະບຽນກ່ອນ',
          locale == const Locale('en') ? 'Close' : 'ປິດ',
          'Phetsarath OT');
    }
  }
}
