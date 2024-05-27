import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laokyc_button/constant/api_path.dart';
import 'package:laokyc_button/utils/prefUserInfo.dart';
import 'package:laokyc_button/widgets/error_dialog.dart';
import '../model/bad_request_model.dart';
import '../model/connect_refresh_token_model.dart';

Future<ConnectRefreshTokenModel?> connectTokenLogin(
  String payload,
  BuildContext context,
  Locale? locale,
  int n,
) async {
  int retry = n + 1;
  if (retry == 3) return null;

  String url = APIPath.CONNECT_TOKEN_LOGIN;
  try {
    var response = await http.post(
      Uri.parse(url),
      body: payload,
      headers: {'Content-type': 'application/json', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      ConnectRefreshTokenModel data = connectRefreshTokenModelFromJson(response.body);
      await PreferenceInfo().setLoginPayload(payload);
      return data;
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      BadRequestModel data = badRequestModelFromJson(response.body);
      if (data.code == 'REQUEST_TOKEN_ERROR' && data.message == 'invalid_grant') {
        errorDialog(
          context,
          locale == const Locale('en') ? 'Warning' : 'ແຈ້ງເຕືອນ',
          locale == const Locale('en') ? 'Sorry, Please enter correct OTP' : 'ຂໍອະໄພ ກະລຸນາປ້ອນ OTP ໃຫ້ຖືກຕ້ອງ',
          locale == const Locale('en') ? 'Close' : 'ປິດ',
          'Phetsarath',
        );
      } else {
        errorDialog(
          context,
          locale == const Locale('en') ? 'Warning' : 'ແຈ້ງເຕືອນ',
          'Connect Token login: ${data.code} ${data.detail}',
          locale == const Locale('en') ? 'Close' : 'ປິດ',
          'Phetsarath',
        );
      }
      return null;
    } else {
      Navigator.pop(context);
      errorDialog(
        context,
        locale == const Locale('en') ? 'Warning' : 'ແຈ້ງເຕືອນ',
        'Connect Token login: ${response.statusCode} ${response.body}',
        locale == const Locale('en') ? 'Close' : 'ປິດ',
        'Phetsarath',
      );
      return null;
    }
  } catch (e) {
    return await connectTokenLogin(payload, context, locale, retry);
  }
}
