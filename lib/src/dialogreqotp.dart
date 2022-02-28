import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogReqOTP extends StatelessWidget {
  final text;
  DialogReqOTP({this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: size.width/18,
          height: size.height/5.45,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(size.width/14.4),
                child: SpinKitFadingCircle(
                  size: 40.0,
                  color: Colors.teal,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width/72, right: size.width/72, bottom:  size.height/37),
                child: Text("$text",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Phetsarath', fontSize: size.width/27.69)),
              )
            ],
          ),
        ));
  }
}
