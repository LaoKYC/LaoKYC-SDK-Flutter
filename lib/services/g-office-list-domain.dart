import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laokyc_button/constant/api_path.dart';
import 'dart:convert';
import 'package:laokyc_button/model/list_domain_model.dart';
import 'package:laokyc_button/widgets/dialog_loading.dart';

Future<ListDomainModel> listDomain(BuildContext context) async {
  ListDomainModel dataFromAPI = ListDomainModel();
  String url = APIPath.listDomain;
  showDialog(
      context: context,
      builder: (_) {
        return DialogLoading(title: 'ກຳລັງກວດສອບໂດເມນ');
      });
  try {
    var response = await http.get(Uri.parse(url));
    Navigator.pop(context);
    if (response.statusCode == 200) {
      dataFromAPI = ListDomainModel.fromJson(json.decode(response.body));
    } else {
      throw ('fail');
    }
  } catch (e) {
    Navigator.pop(context);
    throw (e);
  }
  return dataFromAPI;
}
