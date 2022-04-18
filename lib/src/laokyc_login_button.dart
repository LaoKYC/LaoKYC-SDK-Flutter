import 'dart:async';
import 'dart:convert';
import 'package:laokyc_button/model/list_domain_model.dart';
import 'package:laokyc_button/services/g-office-list-domain.dart';
import 'package:laokyc_button/utils/CheckValid.dart';
import 'package:laokyc_button/utils/prefUserInfo.dart';
import 'package:laokyc_button/widgets/dialog_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:laokyc_button/widgets/error_dialog.dart';
import 'package:platform_device_id/platform_device_id.dart';

class LaoKYCButton extends StatefulWidget {
  String clientId;
  String redirectUrl;
  String clientSecret;
  List<String> scope;
  var route;
  String lang;
  String? fromApp;
  String? gDomain;

  LaoKYCButton(
      {required this.clientId,
      required this.clientSecret,
      required this.redirectUrl,
      required this.scope,
      required this.route,
      required this.lang,
      this.fromApp,
      this.gDomain});

  //: this.scope = scope ?? [];

  @override
  _LaoKYCButtonState createState() => _LaoKYCButtonState();
}

class _LaoKYCButtonState extends State<LaoKYCButton> {
  //late Buttslog data;
  late String errorTexthead;
  late String errorText;
  late String errorbtn;
  late String autText;
  late String DialogLoadingText;
  late String numberphoneText;
  late String loginbtn;
  late String autbtn;
  late String fontText;
  late Timer _timer;
  late String deviceId;
  final tfDialogLoginPhoneNumber = TextEditingController();
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  late String _clientId;
  late String _redirectUrl;
  final List<String> _scope = <String>[];
  late String _idToken;
  late String _accessToken;
  late String _first_name;
  late String _family_name;
  late String _preferred_username;
  late String _phone;
  late String _sub;
  bool _isBusy = false;
  final TextEditingController _authorizationCodeTextController =
      TextEditingController();
  final TextEditingController _accessTokenTextController =
      TextEditingController();

  final TextEditingController _accessTokenExpirationTextController =
      TextEditingController();

  final AuthorizationServiceConfiguration _serviceConfiguration =
      AuthorizationServiceConfiguration(
          authorizationEndpoint: 'https://login.oneid.sbg.la/connect/authorize',
          tokenEndpoint: 'https://login.oneid.sbg.la/connect/token');

  get http => null;

  Future<void> _requestOTP(
      String urlPath, String phonenumber, BuildContext context) async {
    // Clear cache Image circle
    imageCache!.clear();
    final Dio dio = Dio();

    try {
      try {
        deviceId = (await PlatformDeviceId.getDeviceId)!;
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
      print('Login response ==> ${response.data}');
      if (response.statusCode == 200) {
        Navigator.pop(context);
        _signInWithAutoCodeExchange(phonenumber, 'Android');
      } else {
        Navigator.pop(context);
        print(response.statusCode);
      }
    } catch (e) {
      Navigator.pop(context);
      throw (e);
    }
  }

  Future<void> _signInWithAutoCodeExchange(String phonenumber, String platform,
      {bool preferEphemeralSession = false}) async {
    try {
      _setBusyState();

      final AuthorizationTokenResponse? result =
      await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          widget.clientId,
          widget.redirectUrl,
          clientSecret: widget.clientSecret,
          additionalParameters: {'phone': phonenumber, 'platform': platform},
          promptValues: ['login'],
          scopes: widget.scope,
          serviceConfiguration: _serviceConfiguration,
          preferEphemeralSession: preferEphemeralSession,
        ),
      );
      showDialog(context: context, builder: (_){
        return DialogLoading(title: 'ກຳລັງໂຫຼດ');
      });
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
    setState(() {
      _isBusy = false;
    });
  }

  void _setBusyState() {
    setState(() {
      _isBusy = true;
    });
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    setState(()  {
      try {
        _accessToken =
            (_accessTokenTextController.text = response.accessToken!);
        _idToken = response.idToken!; // <======
        //_idTokenTextController.text = response.idToken!;
        // _refreshToken =
        //    (_refreshTokenTextController.text = response.refreshToken!);
        _accessTokenExpirationTextController.text =
            response.accessTokenExpirationDateTime!.toIso8601String();
        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(_idToken); // <======= id Token JWT
        _first_name = decodedToken["name"];
        _family_name = decodedToken["family_name"];
        _preferred_username = decodedToken["preferred_username"]; // 205xxxxxxx
        _phone = decodedToken["phone"]; // +856205xxxxxx
        _sub = decodedToken["sub"];
      } on Exception catch (_) {}
       PreferenceInfo().saveUserInfo(
          _first_name, _family_name, _preferred_username, _accessToken, _sub).then((value) {
         Navigator.pop(context);
         Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (context) => widget.route),
                 (route) => false);
       });

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => widget.route),
      // );
    });
  }

  void checkLang() {
    if (widget.lang.toUpperCase() == "LA") {
      loginbtn = "ລ໋ອກອິນ LaoKYC";
      fontText = "Phetsarath";
      autText = "ຢືນຢັນຕົວຕົນຜ່ານ LaoKYC";
      numberphoneText = "ປ້ອນເບີໂທລະສັບ (20xxxxxxxx)";
      DialogLoadingText = "ກຳລັງສົ່ງ OTP ໄປຫາ\nເບີຂອງທ່ານ";
      widget.fromApp == 'G-OFFICE'
          ? autbtn = "ເຂົ້າສູ່ລະບົບ"
          : autbtn = "ຂໍລະຫັດຜ່ານ OTP";
      errorTexthead = "ເເຈ້ງເຕືອນ";
      errorText =
          "ກະລຸນາປ້ອນໝາຍເລກໂທລະສັບຂອງທ່ານ\nຂຶ້ນຕົ້ນດ້ວຍ(20xxxxxxxx) ຫຼື (30xxxxxxx)";
      errorbtn = "ຕົກລົງ";
    } else if (widget.lang.toUpperCase() == 'EN') {
      loginbtn = "Login with LaoKYC";
      fontText = "Phetsarath";
      autText = "Authentication with LaoKYC";
      numberphoneText = "Enter phone number (20xxxxxxxx)";
      DialogLoadingText = "Sending OTP to\nyour number";
      widget.fromApp == 'G-OFFICE' ? autbtn = "Login" : autbtn = "Request OTP";
      errorTexthead = "Warning!";
      errorText =
          "Please enter your phone number\nstarting with (20xxxxxxxx) or (30xxxxxxx)";
      errorbtn = "OK";
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
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: size.height / 75.6, horizontal: size.width / 10),
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
            child: Image(
              image: AssetImage('assets/logo.png', package: 'laokyc_button'),
              width: size.width / 12,
              height: size.width / 12,
            ),
          ),
          Expanded(
            child: Text(
              loginbtn,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width / 21.17,
                fontFamily: fontText,
                fontWeight: FontWeight.bold,
                color: Color(0xFFffffff),
              ),
            ),
          ),
        ],
      ),
      onPressed: () async {
        if (widget.fromApp == 'G-OFFICE') {
          if (widget.gDomain!.isEmpty) {
            errorDialog(
                context,
                'ແຈ້ງເຕືອນ',
                'ກະລຸນາປ້ອນໂດເມນ\nກະຊວງ ຫຼື ບໍລິສັດທີ່ທ່ານສັງກັດ',
                'ປິດ',
                fontText);
          } else {
            ListDomainModel getDomain = await listDomain(context);
            for (var i = 0; i < getDomain.content!.length; i++) {
              List<String> splitText = getDomain.content![i].domain!.split('.');
              if (widget.gDomain == splitText[0]) {
                await PreferenceInfo().setDomain(getDomain.content![i].domain!);
                buildDialogPhoneNumber(context);
                i = getDomain.content!.length;
              } else {
                if (i == getDomain.content!.length - 1) {
                  errorDialog(
                      context,
                      'ແຈ້ງເຕືອນ',
                      'ຂໍອະໄພບໍ່ພົບໂດເມນນີ້ໃນລະບົບ\nຕົວຢ່າງໂດເມນ: mtc, mofa...',
                      'ປິດ',
                      fontText);
                }
              }
            }
          }
        } else {
          buildDialogPhoneNumber(context);
        }
      },
    );
  }

  Future<dynamic> buildDialogPhoneNumber(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width / 18, right: size.width / 18),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: size.height / 50.4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Image.asset(
                        'assets/LaoKYCgateway.png',
                        package: 'laokyc_button',
                        width: 110,
                        height: 120,
                      ),
                    ),
                    // Center(
                    //   child: Image(
                    //     image: AssetImage('assets/LaoKYCgateway.png',
                    //         package: 'laokyc_button'),
                    //     width: 110,
                    //     height: 120,
                    //   ),
                    // ),
                    SizedBox(
                      height: size.height / 25.2,
                    ),
                    Center(
                      child: Text(
                        autText,
                        style: TextStyle(
                            fontFamily: fontText,
                            fontSize: size.width / 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800]),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 37.8,
                    ),
                    TextField(
                      style: TextStyle(fontSize: size.width / 25.71),
                      maxLength: 10,
                      textAlign: TextAlign.center,
                      controller: tfDialogLoginPhoneNumber,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: numberphoneText,
                          contentPadding: EdgeInsets.all(10),
                          counterText: "",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontFamily: fontText)),
                    ),
                    SizedBox(
                      height: size.height / 61.66,
                    ),
                    Container(
                      width: double.infinity,
                      child: MaterialButton(
                          padding: EdgeInsets.only(
                              top: size.height / 61.66,
                              bottom: size.height / 61.66),
                          onPressed: () {
                            if (tfDialogLoginPhoneNumber.text == '2077710008') {
                              _signInWithAutoCodeExchange(
                                  tfDialogLoginPhoneNumber.text, 'Android');
                            } else if (tfDialogLoginPhoneNumber.text
                                .startsWith('10')) {
                              if (tfDialogLoginPhoneNumber.text.length == 8) {
                                _signInWithAutoCodeExchange(
                                    tfDialogLoginPhoneNumber.text, 'Android');
                              } else {
                                errorDialog(
                                    context,
                                    "Warning",
                                    "Your phone number was wrong",
                                    errorbtn,
                                    fontText);
                              }
                            } else if (CheckValid().checkValidPhonenumber(
                                    tfDialogLoginPhoneNumber.text) ==
                                false) {
                              errorDialog(context, errorTexthead, errorText,
                                  errorbtn, fontText);
                            } else if (tfDialogLoginPhoneNumber.text.isEmpty) {
                              errorDialog(context, errorTexthead, errorText,
                                  errorbtn, fontText);
                            } else {
                              if (widget.fromApp == 'G-OFFICE') {
                                _signInWithAutoCodeExchange(
                                    tfDialogLoginPhoneNumber.text, 'Android');
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => DialogLoading(
                                          title: DialogLoadingText,
                                        ));
                                _requestOTP("https://gateway.sbg.la/api/login",
                                    tfDialogLoginPhoneNumber.text, context);
                              }
                            }
                          },
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            autbtn,
                            style: TextStyle(
                                color: Color(0xFFffffff),
                                fontFamily: fontText,
                                fontSize: size.width / 25.71),
                          )),
                    ),
                    SizedBox(
                      height: size.height / 61.66,
                    ),
                  ],
                ),
              ));
        });
  }
}
