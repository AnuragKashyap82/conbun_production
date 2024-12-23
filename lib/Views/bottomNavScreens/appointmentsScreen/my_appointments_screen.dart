import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Views/bottomNavScreens/appointmentsScreen/cancelled_appointment_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/appointmentsScreen/completed_appointment_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/appointmentsScreen/rejected_appointment_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/appointmentsScreen/reschedule_appointment_request_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/appointmentsScreen/upcoming_appointment_screen.dart';
import 'package:conbun_production/Views/appointmentDetailsScreen/appointment_details_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/appointmentsScreen/waiting_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../rescheduleAppointmentScreen/reschedule_appointment_screen.dart';
import '../bottomNavScreen.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }
  AppointmentsController appointmentsController = Get.find();
  Future<void> goToScreen() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (_) => RescheduleAppointmentScreen()));
  }
  Future<void> goToScreenConsultantName() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (_) => AppointmentDetailsScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavScreen(
                      currentTab: 0,
                    ),
                    maintainState: false,
                  ));
            },
            child: AppBar(
              backgroundColor: colorWhite,
              surfaceTintColor: colorWhite,
              shadowColor: Colors.black.withOpacity(0.1),
              leading: IconButton(icon: Icon(
                Icons.arrow_back,
                color: colorViolet,
                size: 20,
              ), onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavScreen(
                        currentTab: 0,
                      ),
                      maintainState: false,
                    ));
              },),
              title: Text(
                "My Appointments",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "MontserratBold",
                  color: colorViolet,
                ),
              ),
              centerTitle: false,
              elevation: 12,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,  // Ensure no extra space
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorColor: colorOrange,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: colorOrange,
                    unselectedLabelColor: colorViolet,
                    padding: EdgeInsets.zero,  // Ensure no padding around the TabBar itself
                    labelPadding: EdgeInsets.symmetric(horizontal: 8.0),  // Adjust padding between tabs
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0, color: colorOrange),
                      insets: EdgeInsets.symmetric(horizontal: 0.0),
                    ),
                    tabs: const [
                      Tab(text: 'Waiting'),
                      Tab(text: 'Upcoming'),
                      Tab(text: 'Completed'),
                      Tab(text: 'Cancelled'),
                      Tab(text: 'Rejected'),
                      Tab(text: 'Rescheduled'),
                    ],
                  ),
                ),
              ],
            ),


            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  WaitingAppointmentScreen(changeScreenFunction: goToScreen,goToScreenConsultantName: goToScreenConsultantName,),
                  UpcomingAppointmentScreen(changeScreenFunction: goToScreen,goToScreenConsultantName: goToScreenConsultantName,),
                  CompletedAppointmentScreen(changeScreenFunction: goToScreen, goToScreenConsultantName: goToScreenConsultantName),
                  CancelledAppointmentScreen(changeScreenFunction: goToScreen, goToScreenConsultantName: goToScreenConsultantName),
                  RejectedAppointmentScreen(changeScreenFunction: goToScreen, goToScreenConsultantName: goToScreenConsultantName),
                  RescheduleAppointmentRequestScreen(changeScreenFunction: goToScreen, goToScreenConsultantName: goToScreenConsultantName),
                ],
              ),
            ),
          ],
        ));
  }
}
