import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/NotificationServices/push_notification.dart';
import 'package:conbun_production/Views/bottomNavScreens/bottomNavScreen.dart';
import 'package:conbun_production/Views/rechargeScreen/recharge_screen.dart';
import 'package:conbun_production/Views/rescheduleAppointmentScreen/reschedule_appointment_apis.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import 'book_appointment_apis.dart';

class BookAppointmentTwoScreen extends StatefulWidget {
  final String consultantId;
  final String devicetoken;

  const BookAppointmentTwoScreen(
      {super.key, required this.consultantId, required this.devicetoken});

  @override
  State<BookAppointmentTwoScreen> createState() =>
      _BookAppointmentTwoScreenState();
}

class _BookAppointmentTwoScreenState extends State<BookAppointmentTwoScreen> {
  BookAppointmentApis bookAppointmentApis = Get.put(BookAppointmentApis());
  AppointmentsController appointmentsController = Get.find();
  UserController userController = Get.find();
  RescheduleAppointmentApis rescheduleAppointmentApis =
      Get.put(RescheduleAppointmentApis());
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          "Book Your Appointment",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 26,
              ),
              Text(
                "Event Name",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff343F52),
                    fontFamily: "Bold"),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 46,
                decoration: BoxDecoration(
                  color: colorWhite,
                  border: Border.all(color: Color(0xffE7E7E7), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  controller: _eventNameController,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 5, left: 8, right: 8),
                      enabledBorder: InputBorder.none,
                      hintText: 'Your Event Name',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffADACAC),
                          fontFamily: "SemiBold"),
                      focusedBorder: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Confirm Duration",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff343F52),
                    fontFamily: "Bold"),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 46,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: colorWhite,
                  border: Border.all(color: const Color(0xffE7E7E7), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        "${bookAppointmentApis.selectedDuration.value} Minutes",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff343F52),
                            fontFamily: "SemiBold"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Event Details",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff343F52),
                    fontFamily: "Bold"),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  color: colorWhite,
                  border: Border.all(color: Color(0xffE7E7E7), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  maxLines: 5,
                  controller: _eventDetailsController,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 5, left: 8, right: 8, top: 4),
                      enabledBorder: InputBorder.none,
                      hintText: 'Your Event Details',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffADACAC),
                          fontFamily: "SemiBold"),
                      focusedBorder: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              GestureDetector(
                onTap: () async {
                  if (_eventNameController.text.trim().isEmpty) {
                    showSnackBar("Enter Event Name", context);
                  } else if (_eventDetailsController.text.trim().isEmpty) {
                    showSnackBar("Enter Event Details", context);
                  }else {
                    String endTime = await bookAppointmentApis.getEndTime(
                        rescheduleAppointmentApis.selectedHour.value,
                        Duration(
                            minutes: int.parse(
                                bookAppointmentApis.selectedDuration.value)));

                    String startTime = await bookAppointmentApis.getStartTime(
                        rescheduleAppointmentApis.selectedHour.value,);
                    print(
                        "${widget.consultantId}\n${userController.userData().id}\n${bookAppointmentApis.packageId.value}\n${_eventNameController.text.trim()}\n${_eventDetailsController.text.trim()}\n${rescheduleAppointmentApis.selectedFormattedDate.value}\n${startTime}\n${endTime}");

                    ///uncomment this
                    final message = await bookAppointmentApis.bookAppointment(
                      widget.consultantId,
                      userController.userData().id,
                      bookAppointmentApis.packageId.value,
                      _eventNameController.text.trim(),
                      _eventDetailsController.text.trim(),
                      rescheduleAppointmentApis.selectedFormattedDate.value,
                     startTime,
                      endTime,
                    );
                    await appointmentsController.fetchWaitingAppointments();
                    // showSnackBar(message.toString(), context);
                    if (message['message'] == 'Insufficient funds in your wallet to create this appointment') {
                      showSnackBar(message['message'], context);
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: colorWhite,
                              surfaceTintColor: colorWhite,
                              alignment: Alignment(0.0, 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                top: 10.0,
                              ),
                              insetPadding:
                                  EdgeInsets.symmetric(horizontal: 21),
                              content: Container(
                                height: 420,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/images/done.png'),
                                    SizedBox(
                                      height: 16,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Text(
                                      "Insufficient Funds",
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff677294),
                                          fontFamily: "Bold"),
                                    ),
                                    Text(
                                      "dsvfdbvdfkn kfcn kvg\ndfkbofdbofjbogf",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9C9C9C),
                                          fontFamily: "SemiBold"),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 26,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => RechargeScreen(
                                                      code: "booking",
                                                    )));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        decoration: BoxDecoration(
                                            color: colorBlack,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Center(
                                          child: Text(
                                            "Go To Recharge",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: colorWhite,
                                                fontFamily: "SemiBold"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      // showSnackBar(message['message'], context);
                      if (message['Error'] == 1) {
                        showSnackBar(message['message'], context);
                      } else {
                        await appointmentsController.fetchUpcomingAppointments();
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: colorWhite,
                                surfaceTintColor: colorWhite,
                                alignment: Alignment(0.0, 0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      20.0,
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  top: 10.0,
                                ),
                                insetPadding:
                                    EdgeInsets.symmetric(horizontal: 21),
                                content: Container(
                                  height: 420,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/images/done.png'),
                                      SizedBox(
                                        height: 16,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      Text(
                                        "Appointment Book",
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xff677294),
                                            fontFamily: "Bold"),
                                      ),
                                      Text(
                                        "dsvfdbvdfkn kfcn kvg\ndfkbofdbofjbogf",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff9C9C9C),
                                            fontFamily: "SemiBold"),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 26,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      BottomNavScreen(
                                                          currentTab: 2)));
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          decoration: BoxDecoration(
                                              color: colorBlack,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Center(
                                            child: Text(
                                              "Go To Appointment",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: colorWhite,
                                                  fontFamily: "SemiBold"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        await PushNotificationServices
                            .sendNotificationToSelectedDriver(
                          widget.devicetoken,
                            context,
                                "Appointment",
                                "You have a new appointment request");
                      }
                    }
                  }
                },
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.65,
                    decoration: BoxDecoration(
                        color: onBoardingTextColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Obx(() {
                        return bookAppointmentApis.isLoading.value
                            ? CircularProgressIndicator(
                                strokeWidth: 2,
                                color: colorOrange,
                              )
                            : Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: colorWhite,
                                    fontFamily: "SemiBold"),
                              );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
