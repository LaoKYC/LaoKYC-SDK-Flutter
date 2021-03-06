import 'package:flutter/material.dart';

class DialogLoading extends StatelessWidget {
  String title;
  DialogLoading({required this.title});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(child: CircularProgressIndicator()),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize:
                      screenWidth < 600 ? size.width / 25.71 : size.width / 36),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
