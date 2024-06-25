import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogLoading extends StatelessWidget {
  final String title;
  DialogLoading({required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {},
      child: Dialog(
        child: Container(
          constraints: BoxConstraints(maxWidth: 150.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
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
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
