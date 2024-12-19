import 'package:conbun_production/Models/consultants_details_model.dart';
import 'package:conbun_production/Views/rescheduleAppointmentScreen/reschedule_appointment_apis.dart';
import 'package:conbun_production/Views/rescheduleAppointmentScreen/reschedule_screen_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';

class RescheduleAppointmentScreen extends StatefulWidget {
  const RescheduleAppointmentScreen({super.key});

  @override
  State<RescheduleAppointmentScreen> createState() =>
      _RescheduleAppointmentScreenState();
}

class _RescheduleAppointmentScreenState
    extends State<RescheduleAppointmentScreen> {
  late int _selectedReason = 3;
  late String _selectedReasonText = "I don’t want to tell";
  RescheduleAppointmentApis rescheduleAppointmentApis = Get.find();
  TextEditingController _reasonController = TextEditingController();


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
          ),
        ),
        title: Text(
          "Reschedule Appointment",
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
                height: 16,
              ),
              Text(
                "Reason For Rescheduled",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "Bold",
                  fontSize: 14,
                  color: colorBlack,
                ),
              ),
              SizedBox(
                height: 26,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 0;
                    _selectedReasonText = "I'm having a schedule clash";
                    rescheduleAppointmentApis.rescheduleReason.value = "I'm having a schedule clash";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "I'm having a schedule clash",
                  isBorder: _selectedReason == 0? true: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 1;
                    _selectedReasonText = "I’m not available on schedule";
                    rescheduleAppointmentApis.rescheduleReason.value = "I’m not available on schedule";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "I’m not available on schedule",
                  isBorder: _selectedReason == 1? true: false,

                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 2;
                    _selectedReasonText = "I have a activity that can’t be left behind";
                    rescheduleAppointmentApis.rescheduleReason.value = "I have a activity that can’t be left behind";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "I have a activity that can’t be left behind",
                  isBorder: _selectedReason == 2? true: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 3;
                    _selectedReasonText = "I don’t want to tell";
                    rescheduleAppointmentApis.rescheduleReason.value = "I don’t want to tell";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "I don’t want to tell",
                  isBorder: _selectedReason == 3? true: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 4;
                    _selectedReasonText = "Changes of plans";
                    rescheduleAppointmentApis.rescheduleReason.value = "Changes of plans";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "Changes of plans",
                  isBorder: _selectedReason == 4? true: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 5;
                    _selectedReasonText = "Others";
                    rescheduleAppointmentApis.rescheduleReason.value = "Others";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "Others",
                  isBorder: _selectedReason == 5? true: false,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Reason",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "Bold",
                  fontSize: 14,
                  color: colorBlack,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    TextFormField(
                      maxLines: 5,
                      style: TextStyle(
                        fontFamily: "Bold",
                        fontSize: 12,
                        color: Color(0xff60697B),
                      ),
                      controller: _reasonController,
                      onChanged: (value){
                        rescheduleAppointmentApis.rescheduleReasonComment.value = value;
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: 0, left: 8, right: 8, top: 0),
                          enabledBorder: InputBorder.none,
                          hintText: 'Reason for Reschedule',
                          hintStyle: TextStyle(
                            fontFamily: "Bold",
                            fontSize: 12,
                            color: Color(0xff60697B),
                          ),
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RescheduleScreenTwo(isReschedule: true, consultantId: rescheduleAppointmentApis.rescheduleAppointModel().consultantId, consultantsDetailsModel: ConsultantsDetailsModel.empty(),)));
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: colorBlack,
                        border: Border.all(color: Color(0xff636363)),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 14,
                            color: colorWhite,
                            fontFamily: "Regular"),
                      ),
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

class RescheduleItemsTwo extends StatelessWidget {
  final String title;
  final bool isBorder;

  const RescheduleItemsTwo(
      {super.key, required this.title, required this.isBorder});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
              color: colorWhite,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue,
                width: isBorder ? 4 : 1,
              )),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "Bold",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xff60697B),
          ),
        ),
      ],
    );
  }
}
