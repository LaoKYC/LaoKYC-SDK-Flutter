import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return TextField(
        style: TextStyle(fontSize: 16),
        obscureText: obscureText ?? false,
        textAlign: textAlign ?? TextAlign.center,
        autofocus: autoFocus ?? false,
        maxLength: maxLength,
        onChanged: (value) {},
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: hintText ?? '',
            contentPadding:
            padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            counterText: "",
            hintStyle: TextStyle(color: Color(0xFFA1A1A1))));
  }
}
