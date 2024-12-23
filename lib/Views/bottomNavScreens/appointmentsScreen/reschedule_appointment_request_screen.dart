import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Models/reschedule_request_appointment_model.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../../Controllers/consultants_details_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../utils/colors.dart';
import '../../appointmentDetailsScreen/appointment_details_apis.dart';
import '../../rescheduleAppointmentScreen/reschedule_appointment_apis.dart';
import '../dashboardScreen/dashboard_apis.dart';

class RescheduleAppointmentRequestScreen extends StatefulWidget {
  final VoidCallback changeScreenFunction;
  final VoidCallback goToScreenConsultantName;

  const RescheduleAppointmentRequestScreen(
      {super.key,
      required this.changeScreenFunction,
      required this.goToScreenConsultantName});

  @override
  State<RescheduleAppointmentRequestScreen> createState() =>
      _RescheduleAppointmentRequestScreenState();
}

class _RescheduleAppointmentRequestScreenState
    extends State<RescheduleAppointmentRequestScreen> {
  AppointmentsController appointmentsController = Get.find();
  Future<void> refreshData() async {
    await appointmentsController.fetchWaitingAppointments();
    await appointmentsController.fetchUpcomingAppointments();
    await appointmentsController.fetchCompletedAppointments();
    await appointmentsController.fetchCancelledAppointments();
    await appointmentsController.fetchRescheduledAppointments();
    await appointmentsController.fetchRejectedAppointments();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        await refreshData();
      },
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Obx(() {
                  if (appointmentsController.isLoading.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
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
                                height: 80,
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
                                height: 80,
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
                                height: 80,
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
                                height: 80,
                              )),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    );
                  }
                  if (appointmentsController.rescheduledAppointments.isEmpty) {
                    return Center(child: Text("No Reschedule Appointments"));
                  }
                  return ListView.builder(
                    itemCount:
                        appointmentsController.rescheduledAppointments.length,
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final appointments =
                          appointmentsController.rescheduledAppointments[index];
                      return UpcomingWidget(
                        isDivider: index !=
                            appointmentsController.rescheduledAppointments.length -
                                1,
                        changeScreenFunction: widget.changeScreenFunction,
                        goToScreenConsultantName: widget.goToScreenConsultantName,
                        call: 'call',
                        appointmentModel: appointments,
                        isMoreButton: true,
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpcomingWidget extends StatefulWidget {
  final bool isDivider;
  final VoidCallback changeScreenFunction;
  final VoidCallback goToScreenConsultantName;
  final String call;
  final RescheduleRequestAppointmentModel appointmentModel;
  final bool isMoreButton;

  const UpcomingWidget(
      {super.key,
      required this.isDivider,
      required this.changeScreenFunction,
      required this.goToScreenConsultantName,
      required this.call,
      required this.appointmentModel,
      required this.isMoreButton});

  @override
  State<UpcomingWidget> createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  AppointmentDetailsApis appointmentDetailsApis =
      Get.put(AppointmentDetailsApis());
  ConsultantDetailsController consultantDetailsController =
      Get.put(ConsultantDetailsController());
  DashboardApis dashboardApis = Get.find();
  AppointmentsController appointmentsController = Get.find();
  UserController userController = Get.find();
  RescheduleAppointmentApis rescheduleAppointmentApis = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: Image.network(
                  widget.appointmentModel.profileImage,
                  height: 52,
                  width: 52,
                  fit: BoxFit.cover,
                ),
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
                      "${widget.appointmentModel.rescheduleDate} | ${widget.appointmentModel.rescheduleStartTime}",
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
                          widget.appointmentModel.type == "Messaging"
                              ? SvgPicture.asset(
                                  'assets/svg/message.svg',
                                  width: 12,
                                  height: 12,
                                  color: Color(0xff767676),
                                )
                              : widget.appointmentModel.type == "Video"
                                  ? SvgPicture.asset(
                                      'assets/svg/video-solid.svg',
                                      width: 12,
                                      height: 12,
                                      color: Color(0xff767676),
                                    )
                                  : SvgPicture.asset(
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
                                  overflow: TextOverflow.ellipsis),
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
                  widget.appointmentModel.type == "Messaging"
                      ? SvgPicture.asset(
                          'assets/svg/message.svg',
                          width: 18,
                          height: 18,
                          color: Color(0xff45C4A0),
                        )
                      : widget.appointmentModel.type == "Video"
                          ? SvgPicture.asset(
                              'assets/svg/video-solid.svg',
                              width: 18,
                              height: 18,
                              color: Color(0xff45C4A0),
                            )
                          : SvgPicture.asset(
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
              widget.appointmentModel.userType == 'Consultant'?
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
                                  () => showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                      Radius.circular(25.0),
                                      topRight:
                                      Radius.circular(25.0),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.only(
                                          topLeft:
                                          Radius.circular(25.0),
                                          topRight:
                                          Radius.circular(25.0),
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .width,
                                            ),
                                            Text(
                                              "Cancel Appointment",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w800,
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
                                                fontWeight:
                                                FontWeight.w600,
                                                fontFamily:
                                                "Regular",
                                                color: colorBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 26,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.37,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        colorWhite,
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
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color:
                                                            colorBlack,
                                                            fontFamily:
                                                            "SemiBold"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  ///Cancel request
                                                  onTap: () async{
                                                    final response =
                                                    await rescheduleAppointmentApis
                                                        .approveRejectRescheduleRequest(
                                                        widget.appointmentModel.id,
                                                        widget.appointmentModel
                                                            .appointmentId,
                                                        "Reject");

                                                    Navigator.pop(context);
                                                    showSnackBar(response.toString(), context);

                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.37,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        colorBlack,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                    child: Center(
                                                      child: Text(
                                                        "Yes Cancel",
                                                        style: TextStyle(
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color:
                                                            colorWhite,
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
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: Text(
                            "Reject Request",
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
                        onTap: () async {
                          ///Accept the request
                          final response =
                          await rescheduleAppointmentApis
                              .approveRejectRescheduleRequest(
                              widget.appointmentModel.id,
                              widget.appointmentModel
                                  .appointmentId,
                              "Accept");

                          showSnackBar(response.toString(), context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: Text(
                            "Accept Request ",
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
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: Text(
                            widget.appointmentModel.rescheduleStatus,
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
        widget.isDivider
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Divider(
                  color: Color(0xffEBEBEB),
                ),
              )
            : SizedBox(),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
