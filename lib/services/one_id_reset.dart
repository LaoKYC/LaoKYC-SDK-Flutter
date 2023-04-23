import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laokyc_button/constant/api_path.dart';
import 'package:laokyc_button/utils/prefUserInfo.dart';
import '../model/bad_request_model.dart';
import '../model/one_id_reset_model.dart';
import '../widgets/error_dialog.dart';

Future<OneIDResetOTP?> oneIDReset(
    BuildContext context, String phoneNumber, String accessToken, int n) async {
  int retry = n + 1;
  if(retry > 3){
    return null;
  }
  String url = APIPath.ONE_ID_RESET+phoneNumber;
  String? locale = await PreferenceInfo().getLocaleLanguage();
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return oneIDResetModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      BadRequestModel data = badRequestModelFromJson(response.body);
      errorDialog(
          context,
          locale == 'en' ? 'Warning' : 'ແຈ້ງເຕືອນ',
          'OneID reset\n${data.code} ${data.detail}',
          locale == 'en' ? 'Close' : 'ປິດ',
          'Phetsarath');
      return null;
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          locale == 'en' ? 'Warning' : 'ແຈ້ງເຕືອນ',
          'OneID Reset\n${response.statusCode} ${response.body}',
          locale == 'en' ? 'Close' : 'ປິດ',
          'Phetsarath');
      return null;
    }
  } catch (e) {
    return await oneIDReset(context, phoneNumber, accessToken, retry);
  }
}

Future<OneIDResetOTP?> oneIDResetExceptionOne(
    BuildContext context, String phoneNumber, String accessToken) async {
  String url = APIPath.ONE_ID_RESET+phoneNumber;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return oneIDResetModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      BadRequestModel data = badRequestModelFromJson(response.body);
      errorDialog(
          context,
          'ແຈ້ງເຕືອນ',
          'OneID reset\n${data.code} ${data.detail}',
          'ປິດ',
          'Phetsarath');
      return null;
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          'ແຈ້ງເຕືອນ',
          'OneID Reset\n${response.statusCode} ${response.body}',
          'ປິດ',
          'Phetsarath');
      return null;
    }
  } catch (e) {
    return await oneIDResetExceptionTwo(context, phoneNumber, accessToken);
  }
}

Future<OneIDResetOTP?> oneIDResetExceptionTwo(
    BuildContext context, String phoneNumber, String accessToken) async {
  String url = APIPath.ONE_ID_RESET+phoneNumber;
  try {
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
    if (response.statusCode == 200) {
      return oneIDResetModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      BadRequestModel data = badRequestModelFromJson(response.body);
      errorDialog(
          context,
          'ແຈ້ງເຕືອນ',
          'OneID reset\n${data.code} ${data.detail}',
          'ປິດ',
          'Phetsarath');
      return null;
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          'ແຈ້ງເຕືອນ',
          'OneID Reset\n${response.statusCode} ${response.body}',
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
