import 'package:conbun_production/Controllers/consultants_details_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Views/appointmentDetailsScreen/appointment_details_apis.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../utils/colors.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  AppointmentDetailsApis appointmentDetailsApis = Get.find();
  // var controller = Get.put(IndividualChatController());
  ConsultantDetailsController consultantDetailsController = Get.put(ConsultantDetailsController());
  UserController userController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appointmentDetailsApis.getEndTime(appointmentDetailsApis.appointmentDetailsModel().startTime, Duration(minutes: int.parse(appointmentDetailsApis.appointmentDetailsModel().duration)));
    appointmentDetailsApis.formatDateForDisplay(appointmentDetailsApis.appointmentDetailsModel().appointmentDate);
    print(appointmentDetailsApis.appointmentDetailsModel().consultantId);
  }

  @override
  Widget build(BuildContext context) {
    print(appointmentDetailsApis.appointmentDetailsModel().appointmentDate);
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.1),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: colorViolet,
              size: 20,
            )),
        title: Text(
          appointmentDetailsApis.appointmentDetailsModel().consultantName,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            FutureBuilder(
          future: consultantDetailsController.fetchUserData(
            appointmentDetailsApis.appointmentDetailsModel().consultantId,
            userController.userData().id,
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.16,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        consultantDetailsController.userData().profileImage,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.16,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.height * 0.16,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6)
                                ),
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            consultantDetailsController.userData().name,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: colorSecondaryViolet,
                                fontFamily: "Bold"),
                          ),
                           Text('${consultantDetailsController.userData().serviceArea}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff60697B),
                                fontFamily: "Bold",
                              )),
                          Text(
                              "${consultantDetailsController.userData().city} | ${consultantDetailsController.userData().state}",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xff60697B),
                                fontFamily: "SemiBold",
                              )),
                          const Divider(
                            height: 8,
                            color: Color(0xffEDEDED),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                MediaQuery.of(context).size.width *
                                    0.5),
                            child: Text(
                              consultantDetailsController
                                  .userData()
                                  .categories,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff60697B),
                                fontFamily: "SemiBold",
                              ),
                              maxLines: 2,
                            ),
                          ),
                          const Divider(
                            height: 8,
                            color: Color(0xffEDEDED),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade700,
                                size: 10,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                consultantDetailsController
                                    .userData()
                                    .avgRating,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: colorSecondaryViolet,
                                    fontFamily: "Bold"),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Container(
                                height: 3,
                                width: 3,
                                decoration: const BoxDecoration(
                                    color: colorSecondaryViolet,
                                    shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 6,
                              ),

                              Text(
                                "${consultantDetailsController.userData().reviews.length} Reviews",
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff60697B),
                                  fontFamily: "SemiBold",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
            SizedBox(
              height: 26,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DottedBorder(
                  color: const Color(0xffE7E7E7),
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(6),
                  dashPattern: [6],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Scheduled Appointment",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Obx(() {
                          return Text(
                            "${appointmentDetailsApis.daysLeft.value} | ${appointmentDetailsApis.appointmentDetailsModel().appointmentDate}\n${appointmentDetailsApis.appointmentDetailsModel().startTime}-${appointmentDetailsApis.endTime.value} (${appointmentDetailsApis.appointmentDetailsModel().duration} Min)",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: colorOrange,
                                fontFamily: "SemiBold"),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: colorWhite, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    appointmentDetailsApis.appointmentDetailsModel().type ==
                            "Messaging"
                        ? SvgPicture.asset(
                            'assets/svg/message.svg',
                            width: 28,
                            height: 28,
                            color: colorSecondaryViolet,
                          )
                        : appointmentDetailsApis.appointmentDetailsModel().type == "Video"
                            ? SvgPicture.asset(
                                'assets/svg/video-solid.svg',
                                width: 28,
                                height: 28,
                                color: colorSecondaryViolet,
                              )
                            : SvgPicture.asset(
                                'assets/svg/call.svg',
                                width: 28,
                                height: 28,
                                color: colorSecondaryViolet,
                              ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointmentDetailsApis.appointmentDetailsModel().name,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                        Text(
                          '${appointmentDetailsApis.appointmentDetailsModel().name} with Consultant',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${appointmentDetailsApis.appointmentDetailsModel().amount}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                        Text(
                          'per ${appointmentDetailsApis.appointmentDetailsModel().duration} min',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Events",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: colorSecondaryViolet,
                        fontFamily: "Bold"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    appointmentDetailsApis.appointmentDetailsModel().sessionDetails,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: colorSecondaryViolet,
                        fontFamily: "SemiBold"),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       if(appointmentDetailsApis
                  //           .appointmentDetailsModel()
                  //           .name ==
                  //           'Audio Call'){
                  //         DateTime time = DateTime.now();
                  //         var channelid = '${time.millisecondsSinceEpoch}';
                  //         controller.makeAudioCall(
                  //             channelid,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().id,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().consultantName,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().profileImage != null ?appointmentDetailsApis
                  //               .appointmentDetailsModel().profileImage: "",
                  //           channelid,
                  //           context,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().consultantName,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().consultantDeviceToken,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().consultantId,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().appointmentDate,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().startTime
                  //         );
                  //       }else if(appointmentDetailsApis
                  //           .appointmentDetailsModel()
                  //           .name ==
                  //           'Video Call'){
                  //         DateTime time = DateTime.now();
                  //         var channelid = '${time.millisecondsSinceEpoch}';
                  //         controller.makeCall(
                  //             channelid,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().consultantId,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().name,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().profileImage != null ?appointmentDetailsApis
                  //               .appointmentDetailsModel().profileImage: "",
                  //           channelid,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().consultantName,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().consultantDeviceToken,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().consultantId,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().appointmentDate
                  //
                  //         );
                  //       } else{
                  //         DateTime time = DateTime.now();
                  //         var channelid = '${time.millisecondsSinceEpoch}';
                  //         controller.makeTextCall(
                  //
                  //           channelid,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().id,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().consultantName,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().profileImage != null ?appointmentDetailsApis
                  //               .appointmentDetailsModel().profileImage: "",
                  //           channelid,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().consultantName,
                  //           appointmentDetailsApis
                  //               .appointmentDetailsModel().consultantDeviceToken,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().consultantId,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().appointmentDate,
                  //             appointmentDetailsApis
                  //                 .appointmentDetailsModel().startTime
                  //         );
                  //       }
                  //
                  //     },
                  //     child: Container(
                  //       height: 48,
                  //       decoration: BoxDecoration(
                  //           color: colorBlack,
                  //           border: Border.all(color: Color(0xff636363)),
                  //           borderRadius: BorderRadius.circular(4)),
                  //       child: Center(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             (appointmentDetailsApis
                  //                         .appointmentDetailsModel()
                  //                         .name ==
                  //                     'Audio Call')
                  //                 ? SvgPicture.asset(
                  //                     'assets/svg/call.svg',
                  //                     width: 24,
                  //                     height: 24,
                  //                     color: colorWhite,
                  //                   ):  (appointmentDetailsApis
                  //                 .appointmentDetailsModel()
                  //                 .name ==
                  //                 'Video Call')
                  //                 ?
                  //             SvgPicture.asset(
                  //                     'assets/svg/video.svg',
                  //                     width: 24,
                  //                     height: 24,
                  //                     color: colorWhite,
                  //                   ):SvgPicture.asset(
                  //               'assets/svg/message.svg',
                  //               width: 24,
                  //               height: 24,
                  //               color: colorWhite,
                  //             ),
                  //             SizedBox(
                  //               width: 16,
                  //             ),
                  //             Text(
                  //               "${appointmentDetailsApis.appointmentDetailsModel().name} (Start at ${appointmentDetailsApis.appointmentDetailsModel().startTime})",
                  //               style: TextStyle(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: colorWhite,
                  //                   fontFamily: "SemiBold"),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 16,
                  // ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
