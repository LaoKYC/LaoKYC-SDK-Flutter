import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GOfficeNumberTextField extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  EdgeInsetsGeometry? padding;
  int maxLength;
  bool? autoFocus;
  TextAlign? textAlign;
  bool? obscureText;

  GOfficeNumberTextField(
      {required this.controller,
      this.hintText,
      this.padding,
      required this.maxLength,
      this.autoFocus,
      this.textAlign,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return TextField(
        style: TextStyle(
          fontSize: isLandscape == false
              ? width < 600
                  ? 14.sp
                  : 8.sp
              : width < 600
                  ? 12.sp
                  : 6.sp,
        ),
        obscureText: obscureText ?? false,
        textAlign: textAlign ?? TextAlign.center,
        autofocus: autoFocus ?? false,
        maxLength: maxLength,
        onChanged: (value) {},
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            hintText: hintText ?? '',
            contentPadding: padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            counterText: "",
            hintStyle: TextStyle(color: Color(0xFFA1A1A1))));
  }
}
