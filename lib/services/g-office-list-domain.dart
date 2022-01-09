import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laokyc_button/constant/api_path.dart';
import 'dart:convert';
import 'package:laokyc_button/model/list_domain_model.dart';
import 'package:laokyc_button/widgets/dialog_loading.dart';

Future<String> listDomain(BuildContext context, String domain) async {
  String myDomain = '';
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
      ListDomainModel data = ListDomainModel.fromJson(json.decode(response.body));
      for(var e in data.content!){
        List<String> splitText = e.domain!.split('.');
        if(domain == splitText[0]){
          myDomain = e.domain.toString();
        }
      }
    } else {
      throw ('fail');
    }
  } catch (e) {
    Navigator.pop(context);
    throw (e);
  }
  return myDomain;
}
