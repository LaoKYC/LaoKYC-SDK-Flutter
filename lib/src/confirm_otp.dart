import 'dart:core';
import 'package:flutter/material.dart';
import 'package:laokyc_button/utils/confirm_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/prefUserInfo.dart';
import '../utils/req_otp.dart';
import '../widgets/error_dialog.dart';
import '../widgets/goffice_number_textfield.dart';

class ConfirmOTP extends StatefulWidget {
  String phoneNumber;
  String clientID;
  String secret;
  String scope;
  var route;
  String? fromApp;

  ConfirmOTP(
      {required this.secret,
      required this.clientID,
      required this.scope,
      required this.phoneNumber,
      required this.route,
      required this.fromApp});

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  TextEditingController otp = TextEditingController();
  String? locale;
  Future getLocale() async {
    locale = await PreferenceInfo().getLocaleLanguage();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'G-Office OTP',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF334046),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/logo.png',
                package: 'laokyc_button',
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'ໃຫ້ປ້ອນລະຫັດຜ່ານ OTP ລ່າສຸດຂອງແອັບ LaoKYC',
                style: TextStyle(fontSize: 15, color: Colors.blueGrey),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //       onTap: () async {
              //         if ((!phoneNumber.startsWith('10') &&
              //                 phoneNumber.length != 8) ||
              //             phoneNumber != '2077710008') {
              //           await requestOTPLogin(context, phoneNumber, clientID,
              //               secret, scope, route, true);
              //         }
              //       },
              //       child: Text(
              //         'ຂໍລະຫັດຜ່ານອີກຄັ້ງ',
              //         style: TextStyle(
              //             decoration: TextDecoration.underline,
              //             color: Colors.blue),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
              GOfficeNumberTextField(
                obscureText: true,
                controller: otp,
                maxLength: 6,
                hintText: 'ກະລຸນາປ້ອນລະຫັດ OTP 6 ໂຕເລກ',
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Color(0xFF1CCAB7), padding: EdgeInsets.symmetric(vertical: 8)),
                  onPressed: () async {
                    if ((widget.phoneNumber.startsWith('10') && widget.phoneNumber.length == 8) ||
                        widget.phoneNumber == '2077710008') {
                      if (otp.text == '123456') {
                        String firstName = 'ອະໂນລົດ';
                        String familyName = 'ພັນວົງສາ';
                        String preferredUserName = '2077710008';
                        String sub = '';
                        String accessToken = '';
                        await PreferenceInfo()
                            .saveUserInfo(firstName, familyName, preferredUserName, accessToken)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context) => widget.route), (route) => false);
                        });
                      } else {
                        errorDialog(context, 'Warning', 'You enter wrong number', 'Close', 'Phetsarath');
                      }
                    } else {
                      if (widget.fromApp == 'G-OFFICE') {
                        const String owner_id = 'owner_id';
                        const first_name = 'name';
                        const family_name = 'family_name';
                        const String isAllowBiometrics = 'isAllowBiometrics';
                        const String showDialogBioLogin = 'showDialogBioLogin';
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        String? phoneNumberPref = await PreferenceInfo().getPhoneNumber();
                        String? domainPref = await PreferenceInfo().getDomain();
                        String? ownerID = await pref.getString(owner_id);
                        String? firstName = await pref.getString(first_name);
                        String? familyName = await pref.getString(family_name);
                        bool? isAllowBio = await pref.getBool(isAllowBiometrics);
                        bool? showDialogBio = await pref.getBool(showDialogBioLogin);
                        await pref.clear();
                        if (phoneNumberPref != null) {
                          await PreferenceInfo().setPhoneNumber(phoneNumberPref);
                        }
                        if (domainPref != null) {
                          await PreferenceInfo().setDomain(domainPref);
                        }
                        // if (ownerID != null) {
                        //   await pref.setString(owner_id, ownerID);
                        // }
                        // if (firstName != null) {
                        //   await pref.setString(first_name, firstName);
                        // }
                        // if (familyName != null) {
                        //   await pref.setString(family_name, familyName);
                        // }
                        if (isAllowBio != null) {
                          await pref.setBool(isAllowBiometrics, isAllowBio);
                        }
                        if (showDialogBio != null) {
                          await pref.setBool(showDialogBioLogin, showDialogBio);
                        }
                      }
                      await confirmOTPToken(context, widget.clientID, widget.secret, widget.scope, widget.phoneNumber,
                          otp.text, widget.route);
                    }
                  },
                  child: Text(
                    locale == 'en' ? 'Next' : 'ຖັດໄປ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () async {
                        if ((!widget.phoneNumber.startsWith('10') && widget.phoneNumber.length != 8) ||
                            widget.phoneNumber != '2077710008') {
                          await requestOTPLogin(context, widget.phoneNumber, widget.clientID, widget.secret,
                              widget.scope, widget.route, true, widget.fromApp);
                        }
                      },
                      child: Text(
                        'ຂໍລະຫັດຜ່ານອີກຄັ້ງ',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
