import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:laokyc_button/utils/CheckValid.dart';
import 'package:laokyc_button/utils/prefUserInfo.dart';
import 'package:laokyc_button/widgets/dialog_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:laokyc_button/constant/route.dart' as custom_route;
import 'package:dio/dio.dart';
import 'package:laokyc_button/utils/CheckValid.dart';
import 'package:laokyc_button/utils/prefUserInfo.dart';
import 'package:laokyc_button/widgets/dialog_loading.dart';
import 'package:laokyc_button/widgets/error_dialog.dart';
import 'package:platform_device_id/platform_device_id.dart';

class LaoKYCButton extends StatefulWidget {
  String clientId;
  String redirectUrl;
  String clientSecret;
  List<String> scope;
  var route;
  String lang;

  LaoKYCButton({
    this.clientId,
    this.clientSecret,
    this.redirectUrl,
    this.scope,
    this.route,
    this.lang,
  });

  //: this.scope = scope ?? [];

  @override
  _LaoKYCButtonState createState() => _LaoKYCButtonState();
}

class _LaoKYCButtonState extends State<LaoKYCButton> {
  //late Buttslog data;
  String btnText;
  Timer _timer;
  String deviceId;
  final tfDialogLoginPhoneNumber = TextEditingController();
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  String _clientId;
  String _redirectUrl;
  final List<String> _scope = <String>[];
  String _idToken;
  String _accessToken;
  String _first_name;
  String _family_name;
  String _preferred_username;
  String _phone;
  String _sub;
  final TextEditingController _authorizationCodeTextController =
      TextEditingController();
  final TextEditingController _accessTokenTextController =
      TextEditingController();

  final TextEditingController _accessTokenExpirationTextController =
      TextEditingController();

  final TextEditingController _idTokenTextController = TextEditingController();
  final TextEditingController _refreshTokenTextController =
      TextEditingController();

  final AuthorizationServiceConfiguration _serviceConfiguration =
      AuthorizationServiceConfiguration(
          'https://login.oneid.sbg.la/connect/authorize',
          'https://login.oneid.sbg.la/connect/token');

  get http => null;

  Future<void> _requestOTP(
      String urlPath, String phonenumber, BuildContext context) async {
    // Clear cache Image circle
    imageCache.clear();
    final Dio dio = Dio();

    try {
      try {
        deviceId = (await PlatformDeviceId.getDeviceId);
      } on PlatformException {
        deviceId = 'Failed to get deviceId.';
      }

      var _body = {
        'phone': phonenumber,
        'Device': deviceId,
      };

      var resBody = {};
      resBody['phone'] = phonenumber;
      resBody['Device'] = deviceId;
      var user = {};
      user = resBody;

      String jsonBody = json.encode(user);
      final encoding = Encoding.getByName('utf-8');

      print('Json body ===> $jsonBody');

      var response = await dio.post(
        urlPath,
        options: Options(
          headers: {
            "content-type": "application/json",
          },
        ),
        data: jsonBody,
      );

      // var response = await http.post(
      //   Uri.parse(urlPath),
      //   headers: {
      //     "content-type": "application/json",
      //   },
      //   body: jsonBody,
      //   encoding: encoding,
      // );
      print('Login response ==> ${response.data}');
      if (response.statusCode == 200) {
        Navigator.pop(context);
        _signInWithAutoCodeExchange(phonenumber, 'Android');
      }
    } on SocketException catch (e) {
      print('Request otp err ==> ${e.message}');
      _requestOTP(urlPath, phonenumber, context);
    }
  }

  Future<void> _signInWithAutoCodeExchange(String phonenumber, String platform,
      {bool preferEphemeralSession = false}) async {
    try {
      _setBusyState();

      final AuthorizationTokenResponse result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId = widget.clientId.toString(),
          _redirectUrl = '${widget.redirectUrl}',
          clientSecret: '${widget.clientSecret}',
          additionalParameters: {'phone': phonenumber, 'platform': platform},
          promptValues: ['login'],
          scopes: widget.scope,
          serviceConfiguration: _serviceConfiguration,
          preferEphemeralSession: preferEphemeralSession,
        ),
      );

      if (result != null) {
        _processAuthTokenResponse(result);
        //await _testApi(result);
      }
    } catch (e) {
      print('Error: $e');
      _clearBusyState();
    }
  }

  void _clearBusyState() {
    setState(() {});
  }

  void _setBusyState() {
    setState(() {});
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    setState(() async {
      try {
        _accessToken = (_accessTokenTextController.text = response.accessToken);
        _idToken = response.idToken; // <======
        //_idTokenTextController.text = response.idToken!;
        // _refreshToken =
        //    (_refreshTokenTextController.text = response.refreshToken!);
        _accessTokenExpirationTextController.text =
            response.accessTokenExpirationDateTime.toIso8601String();
        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(_idToken); // <======= id Token JWT
        _first_name = decodedToken["name"];
        _family_name = decodedToken["family_name"];
        _preferred_username = decodedToken["preferred_username"]; // 205xxxxxxx
        _phone = decodedToken["phone"]; // +856205xxxxxx
        _sub = decodedToken["sub"];
      } on Exception catch (_) {
        print('Error Profile !!!');
      }
      PreferenceInfo().saveUserInfo(
          _first_name, _family_name, _preferred_username, _accessToken);

      //StoreDetailUser()
      // .sharePrefName(_first_name, _family_name, _preferred_username);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.route),
      );
      // _storeToken(response.accessToken);
    });
  }

  void checkLang() {
    if (widget.lang.toUpperCase() == "LA") {
      btnText = "ລ໋ອກອິນ LaoKYC";
    } else if (widget.lang.toUpperCase() == 'EN') {
      btnText = "Login with LaoKYC";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      checkLang();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shadowColor: Colors.teal,
        onPrimary: Colors.white60,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        primary: Colors.teal,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              'https://i.ibb.co/3pkZ3WP/playstore-icon.png',
              width: 30,
              height: 30,
            ),
          ),
          Expanded(
            child: Text(
              btnText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFFffffff),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 350,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              radius: 14.0,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Image.network(
                          'https://i.ibb.co/mB2MHzH/logo-lao-kyc-gateway-250.jpg',
                          width: 110,
                          height: 120,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          'Authentication with LaoKYC',
                          style: TextStyle(
                              fontFamily: 'Phetsarath',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLength: 10,
                        textAlign: TextAlign.center,
                        controller: tfDialogLoginPhoneNumber,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'ປ້ອນເບີໂທລະສັບ (20xxxxxxxx)',
                            contentPadding: EdgeInsets.all(10),
                            counterText: "",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        child: MaterialButton(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            onPressed: () {
                              if (CheckValid().checkValidPhonenumber(
                                      tfDialogLoginPhoneNumber.text) ==
                                  false) {
                                errorDialog(context);
                              } else if (tfDialogLoginPhoneNumber
                                  .text.isEmpty) {
                                errorDialog(context);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => DialogLoading(
                                        title:
                                            'ກຳລັງສົ່ງ OTP ໄປຫາ\nເບີຂອງທ່ານ'));
                                _requestOTP("https://gateway.sbg.la/api/login",
                                    tfDialogLoginPhoneNumber.text, context);
                              }
                            },
                            color: Color(0xFF70CBBD),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'ຂໍລະຫັດຜ່ານ OTP',
                              style: TextStyle(
                                color: Color(0xFFffffff),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
