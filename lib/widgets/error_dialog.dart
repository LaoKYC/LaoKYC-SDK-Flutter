import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String errorTexthead, String errorText,
    String errorbtn, String fontText) {
  Size size = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width/24, vertical: size.height/49.33),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Image.asset(
                  'assets/warning-sign.png',
                  package: 'laokyc_button',
                  width: size.width/7.2,
                  height: size.width/7.2,
                ),
                 SizedBox(
                  height: size.height/29.6,
                ),
                Text(
                  errorTexthead,
                  textAlign: TextAlign.center,
                  style:  TextStyle(fontWeight: FontWeight.w500, fontSize: size.width/18),
                ),
                 SizedBox(
                  height: size.height/29.6,
                ),
                Text(
                  errorText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size.width/25.71),
                ),
                 SizedBox(
                  height: size.height/49.33,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:  Text(errorbtn,style: TextStyle(fontSize: size.width/25.71),)),
                )
              ],
            ),
          ),
        );
      });
}
