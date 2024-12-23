import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Controllers/consultants_details_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/appointment_model.dart';
import 'package:conbun_production/Views/bottomNavScreens/dashboardScreen/dashboard_apis.dart';
import 'package:conbun_production/Views/rescheduleAppointmentScreen/reschedule_appointment_apis.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Views/appointmentDetailsScreen/appointment_details_apis.dart';
import '../Views/rescheduleAppointmentScreen/reschedule_screen_two.dart';

class UpcomingWidget extends StatefulWidget {
  final bool isDivider;
  final VoidCallback changeScreenFunction;
  final VoidCallback goToScreenConsultantName;
  final String call;
  final AppointmentModel appointmentModel;
  final bool isMoreButton;
  const UpcomingWidget({super.key, required this.isDivider, required this.changeScreenFunction, required this.goToScreenConsultantName, required this.call, required this.appointmentModel, required this.isMoreButton});

  @override
  State<UpcomingWidget> createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  AppointmentDetailsApis appointmentDetailsApis = Get.put(AppointmentDetailsApis());
  ConsultantDetailsController consultantDetailsController = Get.put(ConsultantDetailsController());
  DashboardApis dashboardApis = Get.find();
  AppointmentsController appointmentsController = Get.find();
  UserController userController = Get.find();
  RescheduleAppointmentApis rescheduleAppointmentApis = Get.find();
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: (){
        appointmentDetailsApis.appointmentDetailsModel.value = AppointmentModel.empty();
        appointmentDetailsApis.appointmentDetailsModel.value = widget.appointmentModel;
        widget.goToScreenConsultantName();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            color: colorBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: widget.appointmentModel.profileImage != null? Image.network(
                    widget.appointmentModel.profileImage != null ?widget.appointmentModel.profileImage! : '',
                    height: 52,
                    width: 52,
                    fit: BoxFit.cover,
                  ):Icon(Icons.person),
                ),
                SizedBox(
                  width: 32,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.appointmentModel.appointmentDate} | ${widget.appointmentModel.startTime}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          fontFamily: "SemiBold",
                          color: Color(0xff767676),
                        ),
                      ),
                      Text(
                        widget.appointmentModel.consultantName,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          fontFamily: "SemiBold",
                          color: colorViolet,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.appointmentModel.type == "Messaging"?
                            SvgPicture.asset(
                              'assets/svg/message.svg',
                              width: 12,
                              height: 12,
                              color: Color(0xff767676),
                            ):widget.appointmentModel.type == "Video"?SvgPicture.asset(
                              'assets/svg/video-solid.svg',
                              width: 12,
                              height: 12,
                              color: Color(0xff767676),
                            ):SvgPicture.asset(
                              'assets/svg/call.svg',
                              width: 12,
                              height: 12,
                              color: Color(0xff767676),
                            ),

                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.appointmentModel.type,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                fontFamily: "SemiBold",
                                color: Color(0xff767676),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              height: 8,
                              width: 1.5,
                              color: Color(0xff767676),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.access_time,
                              color: Color(0xff767676),
                              size: 12,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                "${widget.appointmentModel.duration} Minutes",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SemiBold",
                                  color: Color(0xff767676),
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "₹ ${widget.appointmentModel.amount}",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        fontWeight: FontWeight.w800,
                        fontFamily: "SemiBold",
                        color: colorViolet,
                      ),
                    ),
                    Text(
                      "------",
                      style: TextStyle(
                        fontSize: 13,
                        height: 0.6,
                        fontWeight: FontWeight.w100,
                        fontFamily: "Regular",
                        color: Color(0xffE1E1E1),
                      ),
                    ),
                    SizedBox(
                      height: 0.8,
                    ),
                    widget.appointmentModel.type == "Messaging"?
                    SvgPicture.asset(
                      'assets/svg/message.svg',
                      width: 18,
                      height: 18,
                      color: Color(0xff45C4A0),
                    ):widget.appointmentModel.type == "Video"?SvgPicture.asset(
                      'assets/svg/video-solid.svg',
                      width: 18,
                      height: 18,
                      color: Color(0xff45C4A0),
                    ):SvgPicture.asset(
                      'assets/svg/call.svg',
                      width: 18,
                      height: 18,
                      color: Color(0xff45C4A0),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                widget.isMoreButton?
                PopupMenuButton<int>(
                    padding: EdgeInsets.zero,
                    shadowColor: colorWhite,
                    surfaceTintColor: colorWhite,
                    color: colorWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    itemBuilder: (context) => [
                          PopupMenuItem<int>(
                              padding: EdgeInsets.zero,
                              onTap: () {
                                Future.delayed(
                                    Duration.zero,
                                () =>
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight: Radius.circular(25.0),
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                  ),
                                                  Text(
                                                    "Cancel Appointment",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800,
                                                      fontFamily: "Bold",
                                                      color: colorViolet,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Are you sure you want to cancel your appointment",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "Regular",
                                                      color: colorBlack,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 26,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.37,
                                                          decoration: BoxDecoration(
                                                              color: colorWhite,
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xff636363)),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  4)),
                                                          child: Center(
                                                            child: Text(
                                                              "Back",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  color: colorBlack,
                                                                  fontFamily:
                                                                  "SemiBold"),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async{
                                                          final response = await dashboardApis.cancelAppointment(userController.userData().id, widget.appointmentModel.id);
                                                          Navigator.pop(context);
                                                          await appointmentsController
                                                              .fetchUpcomingAppointments();
                                                          showSnackBar(userController.userData().id, context);
                                                          showSnackBar(widget.appointmentModel.id, context);
                                                          showSnackBar(response['message'], context);

                                                          },
                                                        child: Container(
                                                          height: 40,
                                                          width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.37,
                                                          decoration: BoxDecoration(
                                                              color: colorBlack,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                          child: Center(
                                                            child: Text(
                                                              "Yes Cancel",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  color: colorWhite,
                                                                  fontFamily:
                                                                  "SemiBold"),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 26,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                );

                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Cancel Event",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "Bold",
                                    fontSize: 12,
                                    color: Color(0xff737B8B),
                                  ),
                                ),
                              )),
                          PopupMenuItem<int>(
                              padding: EdgeInsets.zero,
                              onTap: () async{
                                rescheduleAppointmentApis.rescheduleAppointModel.value = widget.appointmentModel;
                                widget.changeScreenFunction();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Rescheduled Event",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "Bold",
                                    fontSize: 12,
                                    color: Color(0xff737B8B),
                                  ),
                                ),
                              )),
                        ],
                    child: Icon(
                      Icons.more_vert,
                      color: Color(0xffCDCDCD),
                    )):
                PopupMenuButton<int>(
                    padding: EdgeInsets.zero,
                    shadowColor: colorWhite,
                    surfaceTintColor: colorWhite,
                    color: colorWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                          padding: EdgeInsets.zero,
                          onTap: () async{
                            await consultantDetailsController.fetchUserData(widget.appointmentModel.consultantId, userController.userData().id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        RescheduleScreenTwo(
                                          isReschedule: false,
                                          consultantId:
                                          widget.appointmentModel.consultantId,
                                          consultantsDetailsModel: consultantDetailsController.userData(),
                                        )));
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Book Again",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: "Bold",
                                fontSize: 12,
                                color: Color(0xff737B8B),
                              ),
                            ),
                          )),
                    ],
                    child: Icon(
                      Icons.more_vert,
                      color: Color(0xffCDCDCD),
                    ))
              ],
            ),
          ),
          widget.isDivider?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Divider(
              color: Color(0xffEBEBEB),
            ),
          ):SizedBox(),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
