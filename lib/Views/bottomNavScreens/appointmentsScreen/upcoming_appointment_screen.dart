import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Widgets/upcoming_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class UpcomingAppointmentScreen extends StatefulWidget {
  final VoidCallback changeScreenFunction;
  final VoidCallback goToScreenConsultantName;

  const UpcomingAppointmentScreen(
      {super.key,
      required this.changeScreenFunction,
      required this.goToScreenConsultantName});

  @override
  State<UpcomingAppointmentScreen> createState() =>
      _UpcomingAppointmentScreenState();
}

class _UpcomingAppointmentScreenState extends State<UpcomingAppointmentScreen> {
  AppointmentsController appointmentsController = Get.find();
  Future<void> refreshData() async {
    await appointmentsController.fetchWaitingAppointments();
    await appointmentsController.fetchUpcomingAppointments();
    await appointmentsController.fetchCompletedAppointments();
    await appointmentsController.fetchCancelledAppointments();
    await appointmentsController.fetchRescheduledAppointments();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appointmentsController.fetchUpcomingAppointments();
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
              minHeight: MediaQuery.of(context).size.height * 0.8
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
                  if (appointmentsController.upcomingAppointments.isEmpty) {
                    return Center(child: Text("No Upcoming Appointments"));
                  }
                  return ListView.builder(
                    itemCount: appointmentsController.upcomingAppointments.length,
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final appointments =
                          appointmentsController.upcomingAppointments[index];
                      return UpcomingWidget(
                          isDivider: index != appointmentsController.upcomingAppointments.length - 1,
                          changeScreenFunction: widget.changeScreenFunction,
                          goToScreenConsultantName: widget.goToScreenConsultantName,
                          call: 'call',
                          appointmentModel: appointments,isMoreButton: true,);
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