// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_app/screens/home.dart';
import 'package:health_app/utils/textstyle.dart';
import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final List<String> timeSlots = generateTimeSlots();
  int selectedIndex = -1;
  DateTime selectedDate = DateTime.now();

  static List<String> generateTimeSlots() {
    List<String> slots = [];
    for (int hour = 8; hour <= 19; hour++) {
      int displayHour = hour > 12 ? hour - 12 : hour;
      String period = hour >= 12 ? 'PM' : 'AM';

      slots.add('${displayHour.toString().padLeft(2, '0')}:00 $period');
    }
    return slots;
  }

  String formmatedDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Book Appointment",
          style: inter(Colors.black, 22.sp, FontWeight.bold, null),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.h),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Date",
              style: inter(Colors.black, 16.sp, FontWeight.bold, null),
            ),
            CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                ),
                lastDate: DateTime(DateTime.now().year + 1),
                onDateChanged: (date) {
                  selectedDate = date;
                }),
            Text(
              "Select Time",
              style: inter(Colors.black, 16.sp, FontWeight.bold, null),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 16 / 8),
              itemCount: 12,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == index ? blue : Colors.white,
                          border: Border.all(color: blue, width: 2),
                          borderRadius: BorderRadius.circular(10.h)),
                      child: Center(
                        child: Text(
                          timeSlots[index],
                          style: inter(
                              selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              14.sp,
                              FontWeight.bold,
                              null),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: GestureDetector(
          onTap: () {
            if (selectedIndex != -1) {
              Navigator.pop(context,
                  formmatedDate(selectedDate) + " " + timeSlots[selectedIndex]);
            }
          },
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                color: selectedIndex == -1 ? Colors.grey : blue,
                borderRadius: BorderRadius.circular(10.h)),
            child: Center(
              child: Text(
                "Confirm",
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
