
import 'dart:convert';

import 'package:flutter/material.dart';
import '../constant/api_path.dart';
import 'package:http/http.dart' as http;

import '../model/hub_domain_model.dart';
import '../utils/prefUserInfo.dart';
import '../widgets/dialog_loading.dart';
import '../widgets/error_dialog.dart';

Future<HubDomainModel?> hubDomain(BuildContext context, Locale? locale, String? domain, int n) async{
  int retry = n + 1;
  if(retry > 3){
    return null;
  }
  String apiPath = APIPath.hubDomain;
  String url = '$apiPath/$domain';
  showDialog(
      context: context,
      builder: (_) {
        return DialogLoading(title: locale == const Locale('en') ? 'Checking domain' : 'ກຳລັງກວດສອບໂດເມນ');
      });
  try{
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      await PreferenceInfo().setListDomainData(response.body);
      Navigator.pop(context);
      return HubDomainModel.fromJson(json.decode(response.body));
    }else{
      Navigator.pop(context);
      // errorDialog(
      //     context,
      //     locale == const Locale('en') ? 'Sorry' : 'ຂໍອະໄພ',
      //     'List domain: ${response.statusCode} ${response.body}',
      //     locale == const Locale('en') ? 'Close' : 'ປິດ',
      //     'Phetsarath');
      return null;
    }

  }catch(e){
    return await hubDomain(context, locale, domain, retry);
  }

}