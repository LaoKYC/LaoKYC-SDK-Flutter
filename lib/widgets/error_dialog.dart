import 'package:flutter/material.dart';

void errorDialog(BuildContext context) {
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
                  'ແຈ້ງເຕືອນ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Phetsarath'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ("ກະລຸນາປ້ອນໝາຍເລກໂທລະສັບຂອງທ່ານ\nຂຶ້ນຕົ້ນດ້ວຍ(20xxxxxxxx) ຫຼື (30xxxxxxx)"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Phetsarath'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'ຕົກລົງ',
                      style: TextStyle(fontFamily: 'Phetsarath'),
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
