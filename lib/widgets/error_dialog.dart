import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String errorTexthead, String errorText,
    String errorbtn, String fontText) {
  Size size = MediaQuery.of(context).size;

  // String getDeviceType() {
  //   final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  //   return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  // }

  double screenWidth = MediaQuery.of(context).size.width;
  var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width / 24, vertical: size.height / 55.33),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Image.asset(
                  'assets/warning-sign.png',
                  package: 'laokyc_button',
                  width: screenWidth < 600 ? size.width / 7.2 : size.width / 12,
                  height:
                      screenWidth < 600 ? size.width / 7.2 : size.width / 12,
                ),
                SizedBox(
                  height: size.height / 29.6,
                ),
                Text(
                  errorTexthead,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth < 600
                          ? size.width / 25
                          : size.width / 36),
                ),
                SizedBox(
                  height: size.height / 29.6,
                ),
                Text(
                  errorText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: isLandscape == false
                          ? screenWidth < 600
                              ? size.width / 25.71
                              : size.width / 39
                          : screenWidth < 600
                              ? size.width / 25.71
                              : size.width / 42),
                ),
                SizedBox(
                  height: size.height / 49.33,
                ),
                SizedBox(
                  width: double.infinity,
                  height: isLandscape == false
                      ? screenWidth < 600
                          ? size.height / 20
                          : size.height / 25
                      : screenWidth < 600
                          ? size.height / 20
                          : size.height / 20,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        errorbtn,
                        style: TextStyle(
                            fontSize: isLandscape == false
                                ? screenWidth < 600
                                    ? size.width / 25.71
                                    : size.width / 39
                                : screenWidth < 600
                                    ? size.width / 25.71
                                    : size.width / 35),
                      )),
                )
              ],
            ),
          ),
        );
      });
}
