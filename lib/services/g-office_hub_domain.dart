import 'dart:convert';

import 'package:flutter/material.dart';
import '../constant/api_path.dart';
import 'package:http/http.dart' as http;
import '../model/hub_domain_model.dart';
import '../utils/prefUserInfo.dart';

Future<HubDomainModel?> hubDomain(
  BuildContext context,
  String? domain,
  int tryCatch,
) async {
  String apiPath = APIPath.hubDomain;
  String url = '$apiPath/$domain';

  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      await PreferenceInfo().setListDomainData(response.body);
      return HubDomainModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      return null;
    }
  } catch (e) {
    if (tryCatch < 3) {
      return await hubDomain(
        context,
        domain,
        tryCatch + 1,
      );
    } else {
      Navigator.pop(context);
      return null;
    }
  }
}
