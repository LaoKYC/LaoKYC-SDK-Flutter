import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void errorDialog(BuildContext context, String errorTexthead, String errorText, String errorbtn, String fontText) {
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width / 25, vertical: size.height / 55.33),
            constraints: BoxConstraints(maxWidth: 200.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Image.asset(
                  'assets/warning-sign.png',
                  package: 'laokyc_button',
                  width: screenWidth < 600 ? size.width / 7.2 : size.width / 12,
                  height: screenWidth < 600 ? size.width / 7.2 : size.width / 12,
                ),
                SizedBox(
                  height: size.height / 29.6,
                ),
                Text(
                  errorTexthead,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isLandscape == false
                        ? screenWidth < 600
                            ? 14.sp
                            : 8.sp
                        : screenWidth < 600
                            ? 12.sp
                            : 6.sp,
                  ),
                ),
                SizedBox(
                  height: size.height / 40.33,
                ),
                Text(
                  errorText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isLandscape == false
                        ? screenWidth < 600
                            ? 14.sp
                            : 8.sp
                        : screenWidth < 600
                            ? 12.sp
                            : 6.sp,
                  ),
                ),
                SizedBox(
                  height: size.height / 29.6,
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
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        errorbtn,
                        style: TextStyle(
                          fontSize: isLandscape == false
                              ? screenWidth < 600
                                  ? 14.sp
                                  : 8.sp
                              : screenWidth < 600
                                  ? 12.sp
                                  : 6.sp,
                        ),
                      )),
                )
              ],
            ),
          ),
        );
      });
}
