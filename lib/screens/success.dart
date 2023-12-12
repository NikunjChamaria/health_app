import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_app/screens/home.dart';
import 'package:health_app/utils/textstyle.dart';
import 'package:intl/intl.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  String formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('dd MMM yyyy | h a');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Success",
          style: inter(Colors.black, 22.sp, FontWeight.bold, null),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 130.h, horizontal: 30.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.h),
                border: Border.all(color: Colors.grey)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icon.svg",
                  height: 150.h,
                  width: 150.h,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  'Lab tests have been scheduled successfully, You will receive a mail of the same. ',
                  style: inter(Colors.black, 18.sp, FontWeight.normal, null),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  formatDateTime(DateTime.now()),
                  style: inter(Colors.grey, 16.sp, FontWeight.normal, null),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: GestureDetector(
          onTap: () {
            for (int i = 0; i < cartController.length; i++) {
              cartController[i].changeselected(i, false);
              cartController[i].inittotal();
            }
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          },
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                color: blue, borderRadius: BorderRadius.circular(10.h)),
            child: Center(
              child: Text(
                "Back to Home",
                textAlign: TextAlign.center,
                style: inter(Colors.white, 14.sp, FontWeight.bold, null),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
