import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laokyc_button/constant/api_path.dart';
import 'dart:convert';
import 'package:laokyc_button/model/list_domain_model.dart';
import 'package:laokyc_button/utils/prefUserInfo.dart';
import 'package:laokyc_button/widgets/dialog_loading.dart';
import 'package:laokyc_button/widgets/error_dialog.dart';

Future<ListDomainModel?> listDomain(BuildContext context) async {
  String url = APIPath.listDomain;
  showDialog(
      context: context,
      builder: (_) {
        return DialogLoading(title: 'ກຳລັງກວດສອບໂດເມນ');
      });
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      await PreferenceInfo().setListDomainData(response.body);
      Navigator.pop(context);
      return ListDomainModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          'ຂໍອະໄພ',
          'List domain: ${response.statusCode} ${response.body}',
          'ປິດ',
          'Phetsarath');
      return null;
    }
  } catch (e) {
    return await listDomainExceptionOne(context);
  }
}

Future<ListDomainModel?> listDomainExceptionOne(BuildContext context) async {
  String url = APIPath.listDomain;
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      await PreferenceInfo().setListDomainData(response.body);
      Navigator.pop(context);
      return ListDomainModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          'ຂໍອະໄພ',
          'List domain: ${response.statusCode} ${response.body}',
          'ປິດ',
          'Phetsarath');
      return null;
    }
  } catch (e) {
    return await listDomainExceptionTow(context);
  }
}

Future<ListDomainModel?> listDomainExceptionTow(BuildContext context) async {
  String url = APIPath.listDomain;
  try {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      await PreferenceInfo().setListDomainData(response.body);
      Navigator.pop(context);
      return ListDomainModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      errorDialog(
          context,
          'ຂໍອະໄພ',
          'List domain: ${response.statusCode} ${response.body}',
          'ປິດ',
          'Phetsarath');
      return null;
    }
  } catch (e) {
    Navigator.pop(context);
    throw (e);
  }
}
