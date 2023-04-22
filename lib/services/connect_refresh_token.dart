import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laokyc_button/constant/api_path.dart';
import 'package:laokyc_button/widgets/error_dialog.dart';
import '../model/bad_request_model.dart';
import '../model/connect_refresh_token_model.dart';

Future<ConnectRefreshTokenModel?> connectTokenLogin(
    String payload, BuildContext context, String locale, int n) async {
  int retry = n + 1;
  if(retry > 3){
    return null;
  }
  String url = APIPath.CONNECT_TOKEN_LOGIN;
  try {
    var response = await http.post(Uri.parse(url), body: payload, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      ConnectRefreshTokenModel data =
          connectRefreshTokenModelFromJson(response.body);
      return data;
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      BadRequestModel data = badRequestModelFromJson(response.body);
      if (data.code == 'REQUEST_TOKEN_ERROR' &&
          data.message == 'invalid_grant') {
        errorDialog(context, locale == 'en' ? 'Warning' : 'ແຈ້ງເຕືອນ', locale == 'en' ? 'Sorry, Please Enter correct OTP' : 'ຂໍອະໄພ ກະລຸນາປ້ອນ OTP ໃຫ້ຖືກຕ້ອງ',
            locale == 'en' ? 'Close' : 'ປິດ', 'Phetsarath');
      } else {
        errorDialog(
            context,
            locale == 'en' ? 'Warning' :'ແຈ້ງເຕືອນ',
            'Connect Token login: ${data.code} ${data.detail}',
            locale == 'en' ? 'Close' : 'ປິດ',
            'Phetsarath');
      }
      return null;
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          locale == 'en' ? 'Warning' : 'ແຈ້ງເຕືອນ',
          'Connect Token login: ${response.statusCode} ${response.body}',
          locale == 'en' ? 'Close' : 'ປິດ',
          'Phetsarath');
      return null;
    }
  } catch (e) {
    return await connectTokenLogin(payload, context, locale, retry);
  }
}

Future<ConnectRefreshTokenModel?> connectTokenLoginExceptionOne(
    String payload, BuildContext context) async {
  String url = APIPath.CONNECT_TOKEN_LOGIN;
  try {
    var response = await http.post(Uri.parse(url), body: payload, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      ConnectRefreshTokenModel data =
          connectRefreshTokenModelFromJson(response.body);
      return data;
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      BadRequestModel data = badRequestModelFromJson(response.body);
      if (data.code == 'REQUEST_TOKEN_ERROR' &&
          data.message == 'invalid_grant') {
        errorDialog(context, 'ແຈ້ງເຕືອນ', 'ຂໍອະໄພ ກະລຸນາປ້ອນ OTP ໃຫ້ຖືກຕ້ອງ',
            'ປິດ', 'Phetsarath');
      } else {
        errorDialog(
            context,
            'ແຈ້ງເຕືອນ',
            'Connect Token login: ${data.code} ${data.detail}',
            'ປິດ',
            'Phetsarath');
      }
      return null;
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          'ແຈ້ງເຕືອນ',
          'Connect Token login: ${response.statusCode} ${response.body}',
          'ປິດ',
          'Phetsarath');
      return null;
    }
  } catch (e) {
    return await connectTokenLoginExceptionTwo(payload, context);
  }
}

Future<ConnectRefreshTokenModel?> connectTokenLoginExceptionTwo(
    String payload, BuildContext context) async {
  String url = APIPath.CONNECT_TOKEN_LOGIN;
  try {
    var response = await http.post(Uri.parse(url), body: payload, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      ConnectRefreshTokenModel data =
          connectRefreshTokenModelFromJson(response.body);
      return data;
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      BadRequestModel data = badRequestModelFromJson(response.body);
      if (data.code == 'REQUEST_TOKEN_ERROR' &&
          data.message == 'invalid_grant') {
        errorDialog(context, 'ແຈ້ງເຕືອນ', 'ຂໍອະໄພ ກະລຸນາປ້ອນ OTP ໃຫ້ຖືກຕ້ອງ',
            'ປິດ', 'Phetsarath');
      } else {
        errorDialog(
            context,
            'ແຈ້ງເຕືອນ',
            'Connect Token login: ${data.code} ${data.detail}',
            'ປິດ',
            'Phetsarath');
      }
      return null;
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          'ແຈ້ງເຕືອນ',
          'Connect Token login: ${response.statusCode} ${response.body}',
          'ປິດ',
          'Phetsarath');
      return null;
    }
  } on SocketException catch (e) {
    Navigator.pop(context);
    errorDialog(context, 'ແຈ້ງເຕືອນ', 'ກະລຸນາກວດສອບອິນເຕີເນັດຂອງທ່ານ', 'ປິດ',
        'Phetsarath');
  } catch (e) {
    Navigator.pop(context);
    errorDialog(context, 'ແຈ້ງເຕືອນ', 'ເກີດຂໍ້ຜິດພາດກະລຸນາລອງໃໝ່ອີກຄັ້ງ', 'ປິດ',
        'Phetsarath');
    return null;
  }
}
