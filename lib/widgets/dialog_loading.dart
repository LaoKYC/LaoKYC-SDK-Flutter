import 'package:flutter/material.dart';

class DialogLoading extends StatelessWidget {
  String title;
  DialogLoading({required this.title});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
