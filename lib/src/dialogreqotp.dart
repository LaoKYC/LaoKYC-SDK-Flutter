import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogReqOTP extends StatelessWidget {
  final text;
  DialogReqOTP({this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 20,
          height: 155,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(25),
                child: SpinKitFadingCircle(
                  size: 40.0,
                  color: Colors.teal,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
                child: Text("$text",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Phetsarath', fontSize: 13)),
              )
            ],
          ),
        ));
  }
}
