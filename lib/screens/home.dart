import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_app/controllers/cart_controller.dart';
import 'package:health_app/models/labtestsmodel.dart';
import 'package:health_app/screens/cart_page.dart';
import 'package:health_app/utils/textstyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Color blue = const Color(0xCC10217D);
Color lightBlue = const Color(0xFF16C2D5);
List<LabTestsModel> cartitemadded = [];
List<TextEditingController> times = [];
List<CartController> cartController = [];

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> data1;
  @override
  void initState() {
    data1 =
        FirebaseFirestore.instance.collection("popular_lab_tests").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          GetBuilder<CartController>(
              id: "total",
              builder: (cart) {
                return Row(
                  children: [
                    cart.total == 0
                        ? CircleAvatar(
                            radius: 10.h,
                            backgroundColor: Colors.white,
                          )
                        : CircleAvatar(
                            radius: 10.h,
                            backgroundColor: lightBlue,
                            child: Text(
                              cart.total.toString(),
                              style: inter(
                                  Colors.black, 12.sp, FontWeight.bold, null),
                            ),
                          ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPage()));
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: blue,
                        )),
                  ],
                );
              })
        ],
        title: Center(
            child: Text(
          "Health+",
          style: inter(Colors.black, 20.sp, FontWeight.bold, null),
        )),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.h),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Lab tests",
                  style: inter(blue, 22.sp, FontWeight.bold, null),
                ),
                Row(
                  children: [
                    Text(
                      "View More",
                      style: inter(blue, 16.sp, FontWeight.normal,
                          TextDecoration.underline),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: blue,
                      size: 20.sp,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            StreamBuilder(
                stream: data1,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No data available.'));
                  }
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  List<LabTestsModel> labdata = List.from(documents.map((e) =>
                      LabTestsModel.fromJson(
                          e.data() as Map<String, dynamic>)));

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 9 / 12),
                    itemCount: labdata.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      times.addAll(List.generate(
                          labdata.length, (index) => TextEditingController()));
                      cartController.add(Get.find());

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.h)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    labdata[index].name!,
                                    textAlign: TextAlign.center,
                                    style: inter(Colors.white, 13.sp,
                                        FontWeight.bold, null),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.h),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Includes ${labdata[index].tests!} tests",
                                          style: inter(Colors.black, 13.sp,
                                              FontWeight.normal, null),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10.h),
                                          decoration: BoxDecoration(
                                              color: lightBlue,
                                              borderRadius:
                                                  BorderRadius.circular(10.h)),
                                          child: SvgPicture.asset(
                                            "assets/home_tick.svg",
                                            height: 15.h,
                                            width: 15.h,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Get reports in 24 hours",
                                      style: inter(Colors.black, 10.sp,
                                          FontWeight.normal, null),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "₹ ${labdata[index].discountedPrice!}",
                                          style: inter(blue, 16.sp,
                                              FontWeight.bold, null),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          labdata[index].price!.toString(),
                                          style: inter(
                                              Colors.grey,
                                              12.sp,
                                              FontWeight.normal,
                                              TextDecoration.lineThrough),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 17.h,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (cartitemadded
                                              .contains(labdata[index])) {
                                            cartitemadded
                                                .remove(labdata[index]);
                                            cartController[index].reomvetotal();
                                            cartController[index]
                                                .changeselected(index, false);
                                          } else {
                                            cartitemadded.add(labdata[index]);
                                            cartController[index].addtotal();
                                            cartController[index]
                                                .changeselected(index, true);
                                          }
                                        },
                                        child: GetBuilder<CartController>(
                                            id: index,
                                            builder: (cart) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                    horizontal: cart.selected
                                                        ? 27.w
                                                        : 33.w),
                                                decoration: ShapeDecoration(
                                                  color: cart.selected
                                                      ? lightBlue
                                                      : blue,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.h)),
                                                ),
                                                child: Text(
                                                  cart.selected
                                                      ? "Added to cart"
                                                      : "Add to Cart",
                                                  style: inter(
                                                      Colors.white,
                                                      12.sp,
                                                      FontWeight.bold,
                                                      null),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h, horizontal: 30.w),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(color: blue),
                                              borderRadius:
                                                  BorderRadius.circular(5.h)),
                                        ),
                                        child: Text(
                                          "View Details",
                                          style: inter(blue, 12.sp,
                                              FontWeight.bold, null),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Popular Packages",
              style: inter(blue, 22.sp, FontWeight.bold, null),
            ),
            ListView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Container(
                    padding: EdgeInsets.all(20.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30.h,
                              backgroundColor:
                                  const Color(0xFF2F80ED).withOpacity(0.10),
                              child: SvgPicture.asset("assets/medicine.svg"),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                  color: lightBlue,
                                  borderRadius: BorderRadius.circular(10.h)),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/home_tick.svg"),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "Safe",
                                    style: inter(Colors.white, 12.sp,
                                        FontWeight.bold, null),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Full Body Checkup",
                          style:
                              inter(Colors.black, 22.sp, FontWeight.bold, null),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Include 92 tests",
                          style: inter(
                              Colors.grey, 12.sp, FontWeight.normal, null),
                        ),
                        ListView.builder(
                          itemCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              "\u2022 Blood glucose Fasting",
                              style: inter(
                                  Colors.grey, 12.sp, FontWeight.normal, null),
                            );
                          },
                        ),
                        Text(
                          "View More",
                          style: inter(Colors.grey, 12.sp, FontWeight.normal,
                              TextDecoration.underline),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹2000/-",
                              style: inter(
                                  lightBlue, 22.sp, FontWeight.bold, null),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 30.w),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: blue),
                                    borderRadius: BorderRadius.circular(5.h)),
                              ),
                              child: Text(
                                "Add to Cart",
                                style:
                                    inter(blue, 12.sp, FontWeight.bold, null),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
