/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laokyc_button/model/model_profile.dart';

class GetProfile {
  late ModelProfile _result;
  Future<ModelProfile> getProfile(String accessToken) async {
    var url = 'https://api.laokyc.la/api/v1/UserProfile/getprofile';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "bearer " + accessToken,
      },
    );

    if (response.statusCode == 200) {
      var map = Map<String, dynamic>.from(jsonDecode(response.body));
      _result = ModelProfile.fromJson(map);
      print('Response success');
    } else {
      //print(response.statusCode);
      throw Exception('Failed to load album');
    }
    return _result;
  }
}*/

import 'dart:convert';
import 'package:laokyc_button/model/model_profile.dart';
import 'package:laokyc_button/model/model_profile_fail.dart';
import 'package:http/http.dart' as http;
import 'package:laokyc_button/model/model_profile.dart';
import 'package:laokyc_button/model/model_profile_fail.dart';

class GetProfile {
  Future<dynamic> getProfile(String accessToken) async {
    var result;
    var url = 'https://api.laokyc.la/api/v1/UserProfile/getprofile';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "bearer " + accessToken,
      },
    );

    if (response.statusCode == 200) {
      result = ModelProfile.fromJson(jsonDecode(response.body));
    } else {
      result = ModelProfileFail.fromJson(jsonDecode(response.body));
    }
    return result;
  }
}
