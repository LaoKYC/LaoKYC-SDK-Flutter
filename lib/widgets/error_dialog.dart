import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String errorTexthead, String errorText,
    String errorbtn, String fontText) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 70,
                  child: Image(
                      image: AssetImage('assets/remove.png',
                          package: 'laokyc_button')),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  errorTexthead,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: fontText),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  (errorText),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: fontText),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      errorbtn,
                      style: TextStyle(fontFamily: fontText),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ));
}
