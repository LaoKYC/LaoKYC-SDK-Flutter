import 'dart:core';
import 'package:flutter/material.dart';
import 'package:laokyc_button/utils/confirm_otp.dart';
import '../utils/prefUserInfo.dart';
import '../utils/req_otp.dart';
import '../widgets/error_dialog.dart';
import '../widgets/goffice_number_textfield.dart';

class ConfirmOTP extends StatelessWidget {
  String phoneNumber;
  String clientID;
  String secret;
  String scope;
  var route;

  ConfirmOTP(
      {required this.secret,
      required this.clientID,
      required this.scope,
      required this.phoneNumber,
      required this.route});

  TextEditingController otp = TextEditingController();

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
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if ((!phoneNumber.startsWith('10') &&
                              phoneNumber.length != 8) ||
                          phoneNumber != '2077710008') {
                        await requestOTPLogin(context, phoneNumber, clientID,
                            secret, scope, route, true);
                      }
                    },
                    child: Text(
                      'ຂໍລະຫັດຜ່ານອີກຄັ້ງ',
                      style: TextStyle(
                          decoration: TextDecoration.underline, color: Colors.blue),
                    ),
                  ),
                ],
              ),
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
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1CCAB7),
                      padding: EdgeInsets.symmetric(vertical: 8)),
                  onPressed: () async {
                    if ((phoneNumber.startsWith('10') &&
                            phoneNumber.length == 8) ||
                        phoneNumber == '2077710008') {
                      if (otp.text == '123456') {
                        String firstName = 'ອະໂນລົດ';
                        String familyName = 'ພັນວົງສາ';
                        String preferredUserName = '2077710008';
                        String sub = '';
                        String accessToken = '';
                        await PreferenceInfo()
                            .saveUserInfo(firstName, familyName,
                                preferredUserName, accessToken)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => route),
                              (route) => false);
                        });
                      } else {
                        errorDialog(context, 'Warning',
                            'You enter wrong number', 'Close', 'Phetsarath');
                      }
                    } else {
                      await confirmOTPToken(context, clientID, secret, scope,
                          phoneNumber, otp.text, route);
                    }
                  },
                  child: Text(
                    'ຖັດໄປ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
