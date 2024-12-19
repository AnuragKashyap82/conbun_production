import 'package:conbun_production/Controllers/consultants_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Views/bottomNavScreens/consultantScreen/consultants_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/dashboardScreen/dashboard_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/liveScreen/live_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/appointmentsScreen/my_appointments_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/setting_screen.dart';
import 'package:conbun_production/Views/rescheduleAppointmentScreen/reschedule_appointment_apis.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Controllers/follower_controller.dart';
import '../profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  late int currentTab;

  BottomNavScreen({super.key, required this.currentTab});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  late Widget currentScreen;

  Future<void> initControllers() async {
    await Get.put(UserController());
    await Get.put(ConsultantsController());
    await Get.put(RescheduleAppointmentApis());
    await  Get.put(FollowerController());
  }
  Future<bool> checkNotificationPermissionStatus() async {
    PermissionStatus status = await Permission.notification.status;
    // Only navigate if the widget is still mounted
    if (status.isGranted) {

      print('Notification permission is granted');
      return true;
    } else {

      print('Notification permission is denied or restricted');
      return false;

    }
  }

  // Future<void> permission() async{
  //   final bool isPermission =  await checkNotificationPermissionStatus();
  //
  //   if(isPermission){
  //
  //   }else{
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: colorBackground,
  //         content: Text("Notification permission is required", style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //           color: colorBlack,
  //           fontFamily: "SemiBold",
  //         ),),
  //         action: SnackBarAction(
  //           label: "Settings",
  //           textColor: colorBlack,
  //           backgroundColor: colorOrange,
  //           onPressed: () => openAppSettings(),
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.currentTab == 0) {
      currentScreen = DashboardScreen();
    } else if (widget.currentTab == 1) {
      currentScreen = ConsultantsScreen();
    } else if (widget.currentTab == 2) {
      currentScreen = DashboardScreen();
    } else if (widget.currentTab == 3) {
      currentScreen = SettingScreen();
    } else if (widget.currentTab == 5) {
      currentScreen = DashboardScreen();
    }
    initControllers();
    // permission();
  }

  @override
  Widget build(BuildContext context) {
    double navBarHeight;

    // Check the platform
    if (Platform.isAndroid) {
      navBarHeight = 64.0;
    } else if (Platform.isIOS) {
      navBarHeight = 72.0;
    } else {
      navBarHeight = 31.0;
    }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: ProfileScreen(code: 'dashboard'),
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: Container(
          height: navBarHeight,
          child: BottomAppBar(
            color: Colors.white,
            elevation: 7,
            padding: EdgeInsets.zero,
            surfaceTintColor: Colors.white,
            notchMargin: 0,
            shadowColor: const Color(0xffE67E21),
            child: Row(
              //children inside bottom appbar
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentScreen = const DashboardScreen();
                      widget.currentTab = 0;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 6,
                    color: Colors.transparent,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.currentTab == 0
                              ? SvgPicture.asset(
                            'assets/svg/home 2.svg',
                            width: 18,
                            height: 18,
                            color: colorOrange,
                          )
                              : SvgPicture.asset(
                            'assets/svg/home 2.svg',
                            width: 18,
                            height: 18,
                            color: colorViolet,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Bold",
                                color: widget.currentTab == 0
                                    ? const Color(0xffE67E21)
                                    : const Color(0xff677294)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentScreen = const ConsultantsScreen();
                      widget.currentTab = 1;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.currentTab == 1
                            ? SvgPicture.asset(
                          'assets/svg/consultant.svg',
                          width: 18,
                          height: 18,
                          color: colorOrange,
                        )
                            : SvgPicture.asset(
                          'assets/svg/consultant.svg',
                          width: 18,
                          height: 18,
                          color: colorViolet,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Consultants",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Bold",
                              color: widget.currentTab == 1
                                  ? const Color(0xffE67E21)
                                  : const Color(0xff677294)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       currentScreen = const LiveScreen();
                //       widget.currentTab = 5;
                //     });
                //   },
                //   child: Container(
                //     width: MediaQuery.of(context).size.width / 6,
                //     color: Colors.transparent,
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         widget.currentTab == 5
                //             ? Column(
                //           children: [
                //             SvgPicture.asset(
                //               'assets/svg/live.svg',
                //               width: 20,
                //               height: 20,
                //               color: colorOrange,
                //             ),
                //             const SizedBox(
                //               height: 4,
                //             ),
                //             Text(
                //               "Live",
                //               style: TextStyle(
                //                   fontSize: 10,
                //                   fontWeight: FontWeight.w800,
                //                   fontFamily: "Bold",
                //                   color: widget.currentTab == 5
                //                       ? const Color(0xffE67E21)
                //                       : const Color(0xff677294)),
                //               overflow: TextOverflow.ellipsis,
                //               maxLines: 1,
                //             )
                //           ],
                //         )
                //             : Column(
                //           children: [
                //             SvgPicture.asset(
                //               'assets/svg/live.svg',
                //               width: 20,
                //               height: 20,
                //               color: colorViolet,
                //             ),
                //             const SizedBox(
                //               height: 4,
                //             ),
                //             Text(
                //               "Live",
                //               style: TextStyle(
                //                   fontSize: 10,
                //                   fontWeight: FontWeight.w800,
                //                   fontFamily: "Bold",
                //                   color: widget.currentTab == 5
                //                       ? const Color(0xffE67E21)
                //                       : const Color(0xff677294)),
                //               overflow: TextOverflow.ellipsis,
                //               maxLines: 1,
                //             )
                //           ],
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       currentScreen = const MyAppointmentScreen();
                //       widget.currentTab = 2;
                //     });
                //   },
                //   child: Container(
                //     width: MediaQuery.of(context).size.width / 5,
                //     color: Colors.transparent,
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         widget.currentTab == 2
                //             ? SvgPicture.asset(
                //           'assets/svg/Appointments.svg',
                //           width: 20,
                //           height: 20,
                //           color: colorOrange,
                //         )
                //             : SvgPicture.asset(
                //           'assets/svg/Appointments.svg',
                //           width: 20,
                //           height: 20,
                //           color: colorViolet,
                //         ),
                //         const SizedBox(
                //           height: 4,
                //         ),
                //         Text(
                //           "Appointment",
                //           style: TextStyle(
                //               fontSize: 10,
                //               fontWeight: FontWeight.w800,
                //               fontFamily: "Bold",
                //               color: widget.currentTab == 2
                //                   ? const Color(0xffE67E21)
                //                   : const Color(0xff677294)),
                //           overflow: TextOverflow.ellipsis,
                //           maxLines: 1,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentScreen = const SettingScreen();
                      widget.currentTab = 3;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 6,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.currentTab == 3
                            ? SvgPicture.asset(
                          'assets/svg/setting.svg',
                          width: 20,
                          height: 20,
                          color: colorOrange,
                        )
                            : SvgPicture.asset(
                          'assets/svg/setting.svg',
                          width: 20,
                          height: 20,
                          color: colorViolet,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Setting",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Bold",
                              color: widget.currentTab == 3
                                  ? const Color(0xffE67E21)
                                  : const Color(0xff677294)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (widget.currentTab != 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavScreen(
              currentTab: 0,
            ),
            maintainState: false,
          ));
      return false;
    } else{
      SystemNavigator.pop(); // Closes the app.
      return true;
    }

     // Returning true allows the default back button behavior.
  }
}
