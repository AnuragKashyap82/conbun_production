import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Widgets/upcoming_widget.dart';
import 'package:conbun_production/Widgets/waiting_appointment_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class WaitingAppointmentScreen extends StatefulWidget {
  final VoidCallback changeScreenFunction;
  final VoidCallback goToScreenConsultantName;

  const WaitingAppointmentScreen(
      {super.key,
      required this.changeScreenFunction,
      required this.goToScreenConsultantName});

  @override
  State<WaitingAppointmentScreen> createState() =>
      _WaitingAppointmentScreenState();
}

class _WaitingAppointmentScreenState extends State<WaitingAppointmentScreen> {
  AppointmentsController appointmentsController = Get.find();
  Future<void> refreshData() async {
    await appointmentsController.fetchWaitingAppointments();
    await appointmentsController.fetchUpcomingAppointments();
    await appointmentsController.fetchCompletedAppointments();
    await appointmentsController.fetchCancelledAppointments();
    await appointmentsController.fetchRescheduledAppointments();

  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        await refreshData();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.8
            ),
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
                  if (appointmentsController.waitingAppointments.isEmpty) {
                    return Center(child: Text("No Waiting Appointments"));
                  }
                  return ListView.builder(
                    itemCount: appointmentsController.waitingAppointments.length,
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final appointments =
                          appointmentsController.waitingAppointments[index];
                      return WaitingAppointentWidget(
                          isDivider: index != appointmentsController.waitingAppointments.length - 1,
                          changeScreenFunction: widget.changeScreenFunction,
                          goToScreenConsultantName: widget.goToScreenConsultantName,
                          call: 'call',
                        appointmentModel: appointments, isMoreButton: false,

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