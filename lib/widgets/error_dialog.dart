import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String errorTexthead, String errorText,
    String errorbtn, String fontText) {
  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset(
                  'assets/warning-sign.png',
                  package: 'laokyc_button',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  errorTexthead,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  errorText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
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
                      child:  Text(errorbtn)),
                )
              ],
            ),
          ),
        );
      });
}
