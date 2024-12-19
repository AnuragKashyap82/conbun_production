import 'package:conbun_production/Models/appointment_model.dart';
import 'package:conbun_production/Views/appointmentDetailsScreen/appointment_details_apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Views/appointmentDetailsScreen/appointment_details_screen.dart';
import '../utils/colors.dart';

class AppointmentWidget extends StatefulWidget {
  final AppointmentModel appointmentModel;

  const AppointmentWidget({super.key, required this.appointmentModel});

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  AppointmentDetailsApis appointmentDetailsApis =
      Get.put(AppointmentDetailsApis());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        appointmentDetailsApis.appointmentDetailsModel.value =
            AppointmentModel.empty();
        appointmentDetailsApis.appointmentDetailsModel.value =
            widget.appointmentModel;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AppointmentDetailsScreen(),
          ),
        );
      },
      child:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: const Color(0x3654A8C7),
              border: Border.all(color: const Color(0xffEDEDED), width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 8,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    widget.appointmentModel.appointmentDate,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontFamily: "Regular"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 26,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 3),
                              child: Row(
                                children: [
                                  widget.appointmentModel.type == "Messaging"
                                      ? SvgPicture.asset(
                                          'assets/svg/message.svg',
                                          width: 16,
                                          height: 16,
                                          color: Colors.green,
                                        )
                                      : widget.appointmentModel.type == "Video"
                                          ? SvgPicture.asset(
                                              'assets/svg/video-solid.svg',
                                              width: 16,
                                              height: 16,
                                              color: Colors.green,
                                            )
                                          : SvgPicture.asset(
                                              'assets/svg/call.svg',
                                              width: 16,
                                              height: 16,
                                              color: Colors.green,
                                            )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            widget.appointmentModel.startTime,
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontFamily: "SemiBold"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.appointmentModel.consultantName,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: colorSecondaryViolet,
                                fontFamily: "Bold"),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.verified,
                            size: 12,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.appointmentModel.categories,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff969696),
                            fontFamily: "SemiBold"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:  widget.appointmentModel.profileImage != null?Image.network(
                          widget.appointmentModel.profileImage != null
                              ? widget.appointmentModel.profileImage!
                              : ''):Icon(Icons.person),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
