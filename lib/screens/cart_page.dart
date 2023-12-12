import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_app/screens/book_appointment.dart';
import 'package:health_app/screens/home.dart';
import 'package:health_app/screens/success.dart';
import 'package:health_app/utils/textstyle.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool ischeck = false;
  int totalPrice = 0;
  int totalDiscountedPrice = 0;
  bool canSchedule = false;

  void check() {
    int count = 0;
    for (var n in times) {
      if (n.text != "") {
        count++;
      }
    }
    canSchedule = ischeck && count == cartitemadded.length;
  }

  @override
  void initState() {
    for (var n in cartitemadded) {
      totalDiscountedPrice = totalDiscountedPrice + n.discountedPrice!;
      totalPrice = totalPrice + n.price!;
    }
    super.initState();
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
          "My Cart",
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
      body: cartitemadded.isEmpty
          ? Center(
              child: Container(
                height: 300.h,
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
                      "Nothing in Cart!!",
                      style: inter(Colors.black, 30.sp, FontWeight.bold, null),
                    )
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(20.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Review",
                    style: inter(blue, 22.sp, FontWeight.bold, null),
                  ),
                  ListView.builder(
                    itemCount: cartitemadded.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.h)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.h),
                                            topRight: Radius.circular(10.h))),
                                    child: Center(
                                      child: Text(
                                        "Pathology Tests",
                                        textAlign: TextAlign.center,
                                        style: inter(Colors.white, 16.sp,
                                            FontWeight.bold, null),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.h, horizontal: 20.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              cartitemadded[index].name!,
                                              style: inter(Colors.black, 20.sp,
                                                  FontWeight.bold, null),
                                            ),
                                            Text(
                                              "₹${cartitemadded[index].discountedPrice}/-",
                                              style: inter(lightBlue, 20.sp,
                                                  FontWeight.bold, null),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              cartitemadded[index]
                                                  .price
                                                  .toString(),
                                              style: inter(
                                                  Colors.grey,
                                                  14.sp,
                                                  FontWeight.normal,
                                                  TextDecoration.lineThrough),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              cartController[
                                                      cartitemadded[index].id!]
                                                  .changeselected(
                                                      cartitemadded[index].id!,
                                                      false);
                                              cartController[
                                                      cartitemadded[index].id!]
                                                  .reomvetotal();
                                              cartitemadded.removeAt(index);
                                              totalDiscountedPrice = 0;
                                              totalPrice = 0;
                                              for (var n in cartitemadded) {
                                                totalDiscountedPrice =
                                                    totalDiscountedPrice +
                                                        n.discountedPrice!;
                                                totalPrice =
                                                    totalPrice + n.price!;
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: 140.w,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 15.w),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: blue, width: 3),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.h)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete_forever,
                                                  color: blue,
                                                  size: 24.sp,
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  "Remove",
                                                  style: inter(blue, 16.sp,
                                                      FontWeight.bold, null),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h, horizontal: 15.w),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: blue, width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(20.h)),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.upload_rounded,
                                                color: blue,
                                                size: 24.sp,
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Text(
                                                "Upload prescription (optional)",
                                                style: inter(blue, 15.sp,
                                                    FontWeight.bold, null),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 25.h, horizontal: 15.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.h)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 35.sp,
                                    color: Colors.black,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      times[index].text = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BookAppointment()));
                                      setState(() {
                                        check();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.h),
                                      width: 255.w,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10.h)),
                                      child: Text(
                                        times[index].text == ""
                                            ? "Select Date"
                                            : times[index].text,
                                        style: inter(Colors.black, 16.sp,
                                            FontWeight.w300, null),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(25.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.h)),
                    height: 190.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "M.R.P Total",
                              style: inter(
                                  Colors.grey, 14.sp, FontWeight.normal, null),
                            ),
                            Text(
                              totalPrice.toString(),
                              style: inter(
                                  Colors.grey, 14.sp, FontWeight.normal, null),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount",
                              style: inter(
                                  Colors.grey, 14.sp, FontWeight.normal, null),
                            ),
                            Text(
                              (totalPrice - totalDiscountedPrice).toString(),
                              style: inter(
                                  Colors.grey, 14.sp, FontWeight.normal, null),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount to be Paid",
                              style: inter(blue, 20.sp, FontWeight.bold, null),
                            ),
                            Text(
                              "$totalDiscountedPrice/-",
                              style: inter(blue, 20.sp, FontWeight.bold, null),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Total Savings",
                              style: inter(
                                  Colors.black, 20.sp, FontWeight.normal, null),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              "${totalPrice - totalDiscountedPrice}/-",
                              style: inter(blue, 20.sp, FontWeight.bold, null),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 105.h,
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.h)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                            shape: const CircleBorder(),
                            fillColor: MaterialStatePropertyAll(
                                ischeck ? blue : Colors.white),
                            value: ischeck,
                            onChanged: (value) {
                              setState(() {
                                ischeck = value ?? false;
                                check();
                              });
                            }),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hard copy of reports",
                              style: inter(
                                  Colors.black, 14.sp, FontWeight.bold, null),
                            ),
                            Text(
                              'Reports will be delivered within 3-4 working\ndays. Hardcopy charges are non-refundable\nonce the reports have been dispatched.\n₹150 per person',
                              style: inter(
                                  Colors.black, 12.sp, FontWeight.normal, null),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: GestureDetector(
          onTap: () {
            if (canSchedule) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SuccessPage()));
            }
          },
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                color: canSchedule ? blue : Colors.grey,
                borderRadius: BorderRadius.circular(10.h)),
            child: Center(
              child: Text(
                "Schedule",
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
