import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../Controllers/notification_controller.dart';
import '../Models/notification_model.dart';
import '../utils/colors.dart';

class SecondBalanceScreen extends StatefulWidget {
  const SecondBalanceScreen({super.key});

  @override
  State<SecondBalanceScreen> createState() => _SecondBalanceScreenState();
}

class _SecondBalanceScreenState extends State<SecondBalanceScreen> {
  NotificationController notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            title: Text(
              "Notification",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "MontserratBold",
                color: colorViolet,
              ),
            ),
            centerTitle: false,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: colorViolet,
                  size: 16,
                )),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 8,
          ),
          Obx(() {
            if (notificationController.isLoading.value) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                        )),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            }
            if (notificationController.allNotification.isEmpty) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(child: Text("No Notification")));
            }
            return ListView.builder(
              itemCount: notificationController.allNotification.length,
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final notification = notificationController.allNotification[index];
                return BalanceWidget(notificationModel: notification,);
              },
            );
          }),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: colorWhite,
          //         borderRadius: BorderRadius.circular(8)
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: 40,
          //                 width: 40,
          //                 decoration: BoxDecoration(
          //                     color: Color(0xffAEFFBA).withOpacity(0.3),
          //                     shape: BoxShape.circle
          //                 ),
          //                 child: Center(
          //                   child: Container(
          //                       height: 22,
          //                       width: 22,
          //                       decoration: BoxDecoration(
          //                           color: Color(0xffAEFFBA).withOpacity(0.3),
          //                           shape: BoxShape.circle
          //                       ),
          //                       child: Center(child: Icon(Icons.card_giftcard, color: Colors.green, size: 18,))),
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 8,
          //               ),
          //               Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Schedule Changed",
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w800,
          //                       fontFamily: "Bold",
          //                       color: colorBlack,
          //                     ),
          //                   ),
          //
          //                   Text(
          //                     "Today | 15 : 36 PM",
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w400,
          //                       fontFamily: "SemiBold",
          //                       color: Color(0xff898989),
          //                     ),
          //                   ),
          //
          //                 ],
          //               )
          //             ],
          //           ),
          //           SizedBox(
          //             height: 6,
          //           ),
          //           Text(
          //             "You have Successfully changed your Schedule an appointment with Mr. Navneet Kumawat on December 24, 2024, 13:00 p.m. 80% Don’t forget.",
          //             style: TextStyle(
          //               fontSize: 12,
          //               fontWeight: FontWeight.w400,
          //               fontFamily: "SemiBold",
          //               color: Color(0xff677294),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: colorWhite,
          //         borderRadius: BorderRadius.circular(8)
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: 40,
          //                 width: 40,
          //                 decoration: BoxDecoration(
          //                     color: Color(0xff3F7EFF).withOpacity(0.3),
          //                     shape: BoxShape.circle
          //                 ),
          //                 child: Center(
          //                   child: Container(
          //                       height: 22,
          //                       width: 22,
          //                       decoration: BoxDecoration(
          //                           color: Color(0xffAEFFBA).withOpacity(0.3),
          //                           shape: BoxShape.circle
          //                       ),
          //                       child: Center(child: Icon(Icons.card_giftcard, color: Colors.blueAccent, size: 18,))),
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 8,
          //               ),
          //               Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Appointment Success",
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w800,
          //                       fontFamily: "Bold",
          //                       color: colorBlack,
          //                     ),
          //                   ),
          //
          //                   Text(
          //                     "Today | 15 : 36 PM",
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w400,
          //                       fontFamily: "SemiBold",
          //                       color: Color(0xff898989),
          //                     ),
          //                   ),
          //
          //                 ],
          //               )
          //             ],
          //           ),
          //           SizedBox(
          //             height: 6,
          //           ),
          //           Text(
          //             "You have Successfully Booked an appointment with Mr. Navneet Kumawat on December 24, 2024, 13:00 p.m. Don’t forget to active your reminder",
          //             style: TextStyle(
          //               fontSize: 12,
          //               fontWeight: FontWeight.w400,
          //               fontFamily: "SemiBold",
          //               color: Color(0xff677294),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: colorWhite,
          //         borderRadius: BorderRadius.circular(8)
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: 40,
          //                 width: 40,
          //                 decoration: BoxDecoration(
          //                     color: Color(0xffFD9C12).withOpacity(0.3),
          //                     shape: BoxShape.circle
          //                 ),
          //                 child: Center(
          //                   child: Container(
          //                       height: 22,
          //                       width: 22,
          //                       decoration: BoxDecoration(
          //                           color: Color(0xffFD9C12).withOpacity(0.3),
          //                           shape: BoxShape.circle
          //                       ),
          //                       child: Center(child: Icon(Icons.card_giftcard, color: Color(0xffFD9C12), size: 18,))),
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 8,
          //               ),
          //               Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "New Service Available!",
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w800,
          //                       fontFamily: "Bold",
          //                       color: colorBlack,
          //                     ),
          //                   ),
          //
          //                   Text(
          //                     "Today | 15 : 36 PM",
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w400,
          //                       fontFamily: "SemiBold",
          //                       color: Color(0xff898989),
          //                     ),
          //                   ),
          //
          //                 ],
          //               )
          //             ],
          //           ),
          //           SizedBox(
          //             height: 6,
          //           ),
          //           Text(
          //             "You can now make multiple Consultant appointment at once. you can also cancel your appointment",
          //             style: TextStyle(
          //               fontSize: 12,
          //               fontWeight: FontWeight.w400,
          //               fontFamily: "SemiBold",
          //               color: Color(0xff677294),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }
}

String getFormattedDate(String date) {
  try {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (aDate == today) {
      return "Today | ${DateFormat('hh : mm a').format(dateTime)}";
    } else {
      return DateFormat('EEE MMM dd, yyyy hh:mm a').format(dateTime);
    }
  } catch (e) {
    return 'Invalid date';
  }
}
class BalanceWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  const BalanceWidget({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            color: colorWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset:
                const Offset(0, 0), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Color(0xffE32727).withOpacity(0.3),
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                              color: Color(0xffE32727),
                              shape: BoxShape.circle
                          ),
                          child: Center(child: Icon(Icons.close, color: colorWhite, size: 18,))),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationModel.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Bold",
                          color: colorBlack,
                        ),
                      ),

                      Text(
                        getFormattedDate(notificationModel.date),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "SemiBold",
                          color: Color(0xff898989),
                        ),
                      ),

                    ],
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                notificationModel.description,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SemiBold",
                  color: Color(0xff677294),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
