import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Controllers/consultants_controller.dart';
import 'package:conbun_production/Controllers/service_category_controller.dart';
import 'package:conbun_production/Controllers/slider_controller.dart';
import 'package:conbun_production/Controllers/transaction_account_controller.dart';
import 'package:conbun_production/Controllers/transaction_recharge_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/service_category_model.dart';
import 'package:conbun_production/NotificationServices/push_notification.dart';
import 'package:conbun_production/Views/balance_screen.dart';
import 'package:conbun_production/Views/bottomNavScreens/bottomNavScreen.dart';
import 'package:conbun_production/Views/bottomNavScreens/dashboardScreen/dashboard_apis.dart';
import 'package:conbun_production/Views/profile_screen.dart';
import 'package:conbun_production/Views/searchConsultantScreen/search_consultants_screen.dart';
import 'package:conbun_production/Views/second_balance_screen.dart';
import 'package:conbun_production/Widgets/appointment_skeleton_widget.dart';
import 'package:conbun_production/Widgets/featured_consultant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../../Agora/controllers/individual_chat_controller.dart';
import '../../../Controllers/notification_controller.dart';
import '../../../NotificationServices/notification_services.dart';
import '../../../Widgets/appointment_widget.dart';
import '../../../Widgets/consultant_skeleton_widget.dart';
import '../../../Widgets/consultants_widget.dart';
import '../../../utils/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils/constant.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardApis dashboardApis = Get.put(DashboardApis());
  AppointmentsController appointmentsController =
      Get.put(AppointmentsController());
  ConsultantsController consultantsController =
      Get.put(ConsultantsController());
  TransactionAccountController transactionAccountController =
      Get.put(TransactionAccountController());
  TransactionRechargeController transactionRechargeController =
      Get.put(TransactionRechargeController());
  NotificationController notificationController =
      Get.put(NotificationController());
  UserController userController = Get.find();

  int _current = 0;
  final CarouselController _controller = CarouselController();
  late bool _isLoading = false;

  final List<Widget> widgetListTestimonial = [
    Container(
      height: 95,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0x3654A8C7),
          border: Border.all(color: const Color(0xffEDEDED), width: 1),
          borderRadius: BorderRadius.circular(10)),
    ),
    Container(
      height: 95,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0x3654A8C7),
          border: Border.all(color: const Color(0xffEDEDED), width: 1),
          borderRadius: BorderRadius.circular(10)),
    ),
  ];

  Future<bool> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.microphone,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);
    return allGranted;
  }

  Future<void> getGalleryPermission() async {
    final bool isGranted = await _requestPermissions();
    if (!isGranted) {
      await _requestPermissions();
    }
  }

  Future<void> checkNotificationPermissionStatus() async {
    PermissionStatus status = await Permission.notification.status;
    // Only navigate if the widget is still mounted
    if (status.isGranted) {
      print('Notification permission is granted');
    } else {
      // openAppSettings();
      print('Notification permission is denied or restricted');
    }
  }

  @override
  void initState() {
    super.initState();
    dashboardApis.initController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeApp();
      _requestPermissions();
    });
  }

  Future<void> initializeApp() async {
    await checkNotificationPermissionStatus();
    _subscribeToTopic();
    // updateToken();
    getGalleryPermission();
  }

  void _subscribeToTopic() async {
    await PushNotificationServices().subscribeToTopic();
  }
  // void updateToken() async {
  //   NotificationServices().requestPermission();
  //   NotificationServices().initNotification();
  //   String newToken = await NotificationServices().getDeviceToken();
  // }

  // var controller = Get.put(IndividualChatController());

  Future<void> refreshData() async {
    await appointmentsController.fetchUpcomingAppointments();
    await consultantsController.fetchFeaturedConsultants();
    await consultantsController.fetchTopConsultants();
    await userController.fetchUserWalletBalance();
  }

  Future updateTokennn(String mobileNo, String deviceToken) async {
    final requestBody = {
      'mobile': mobileNo,
      'devicetoken': deviceToken,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/auth/updateDeviceToken'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      print('object!!!!!!!QQQQQQQQQ $responseBody');
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      print('object!!!!!!!QQQQQQQQQ $e');
      return "An error occurred: $e";
    }
  }

  // else if(!isPermissionGranted){
  // return Scaffold(
  // backgroundColor: colorBackground,
  // body: Center(child: TextButton(onPressed: (){
  //
  // },child: Container(
  // height: 52,
  // width: MediaQuery.of(context).size.width * 0.6,
  // decoration: BoxDecoration(
  // color: colorOrange,
  // borderRadius: BorderRadius.circular(12)
  // ),
  // child: Center(
  // child: Text("Allow Notification Permission",style: TextStyle(
  // fontSize: 14,
  // fontFamily: "Bold",
  // color: colorWhite),),
  // )),)),
  // );
  // }
  @override
  Widget build(BuildContext context) {
    if (dashboardApis.isLoading.value) {
      return Scaffold(
          backgroundColor: const Color(0xffF4F4F4),
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.black.withOpacity(0.1),
            elevation: 8,
            leading: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ProfileScreen(
                                code: 'dashboard',
                              )));
                },
                child: SvgPicture.asset(
                  'assets/svg/mobile menu.svg',
                  width: 16,
                  height: 16,
                  color: colorViolet,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const BalanceScreen()));
                },
                child: SvgPicture.asset(
                  'assets/svg/wallet.svg',
                  width: 20,
                  height: 20,
                  color: colorViolet,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SecondBalanceScreen()));
                },
                child: SvgPicture.asset(
                  'assets/svg/notification.svg',
                  width: 20,
                  height: 20,
                  color: colorViolet,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          drawer: const ProfileScreen(
            code: 'dashboard',
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SearchConsultantsScreen(
                                      searchKeyWord: '',
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: TextField(
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  hintText: "Search Consultant....",
                                  enabled: false,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffB2B7C0),
                                    fontFamily: "SemiBold",
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: VerticalDivider(
                                color: Color(0xffE4E4E4),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.search,
                              color: Color(0xffB2B7C0),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/nine.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      'Anurag',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                    ),
                                  ],
                                ),
                              ))),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/nine.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      'Anurag',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                    ),
                                  ],
                                ),
                              ))),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/nine.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      'Anurag',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                    ),
                                  ],
                                ),
                              ))),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/nine.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      'Anurag',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                    ),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/nine.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      'Anurag',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                    ),
                                  ],
                                ),
                              ))),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/nine.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      'Anurag',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                    ),
                                  ],
                                ),
                              ))),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/nine.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      'Anurag',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                    ),
                                  ],
                                ),
                              ))),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/nine.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      'Anurag',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                    ),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 100.0,
                    autoPlay: true,
                  ),
                  items: [
                    'assets/images/sliderOne.png',
                    'assets/images/slide.png',
                    'assets/images/sliderTwo.png',
                  ].map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ShimmerEffect(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 36,
                ),

                ///
                CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                      height: 100.0,
                      autoPlay: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: widgetListTestimonial.map((widget) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ShimmerEffect(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                color: const Color(0xffE5E5E5),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 8,
                ),

                ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        widgetListTestimonial.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == entry.key
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        AppointmentSkeletonWidget(),
                        const SizedBox(
                          width: 24,
                        ),
                        AppointmentSkeletonWidget(),
                        const SizedBox(
                          width: 24,
                        ),
                        AppointmentSkeletonWidget(),
                        const SizedBox(
                          width: 24,
                        ),
                        AppointmentSkeletonWidget(),
                        const SizedBox(
                          width: 24,
                        ),
                        AppointmentSkeletonWidget(),
                        const SizedBox(
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: dashboardApis.currentFilter.value == "All"
                                  ? colorOrange
                                  : colorWhite,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xffED802D), width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6),
                            child: Text(
                              "All",
                              style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      dashboardApis.currentFilter.value == "All"
                                          ? colorWhite
                                          : colorOrange,
                                  fontFamily: "SemiBold"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: dashboardApis.currentFilter.value == "All"
                                  ? colorOrange
                                  : colorWhite,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xffED802D), width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6),
                            child: Text(
                              "All",
                              style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      dashboardApis.currentFilter.value == "All"
                                          ? colorWhite
                                          : colorOrange,
                                  fontFamily: "SemiBold"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: dashboardApis.currentFilter.value == "All"
                                  ? colorOrange
                                  : colorWhite,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xffED802D), width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6),
                            child: Text(
                              "All",
                              style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      dashboardApis.currentFilter.value == "All"
                                          ? colorWhite
                                          : colorOrange,
                                  fontFamily: "SemiBold"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: dashboardApis.currentFilter.value == "All"
                                  ? colorOrange
                                  : colorWhite,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xffED802D),
                                width: 1,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6),
                            child: Text(
                              "All",
                              style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      dashboardApis.currentFilter.value == "All"
                                          ? colorWhite
                                          : colorOrange,
                                  fontFamily: "SemiBold"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ConsultantSkeleton(),
                SizedBox(
                  height: 26,
                ),
                ConsultantSkeleton(),
                SizedBox(
                  height: 26,
                ),
                ConsultantSkeleton(),
              ],
            ),
          ));
    } else {
      SliderController sliderController = Get.find();
      ServiceCategoryController serviceCategoryController = Get.find();
      ConsultantsController consultantsController = Get.find();
      return Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.1),
          elevation: 8,
          leading: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ProfileScreen(
                              code: 'dashboard',
                            )));
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.transparent,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svg/mobile menu.svg',
                    width: 16,
                    height: 16,
                    color: colorViolet,
                  ),
                ),
              ),
            ),
          ),
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (_) => const BalanceScreen()));
          //     },
          //     child: Container(
          //       height: 52,
          //       width: 52,
          //       color: Colors.transparent,
          //       child: Center(
          //         child: SvgPicture.asset(
          //           'assets/svg/wallet.svg',
          //           width: 20,
          //           height: 20,
          //           color: colorViolet,
          //         ),
          //       ),
          //     ),
          //   ),
          //   GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (_) => const SecondBalanceScreen()));
          //       DateTime time = DateTime.now();
          //       var channelid = '${time.millisecondsSinceEpoch}';
          //       // controller.makeCall(
          //       //     "1",
          //       //     "anurag",
          //       //     "widget.appointmentModel.profileImage",
          //       //     channelid,
          //       //     "anyra",
          //       //     "jn",
          //       //     "widget.appointmentModel.consultantId",
          //       //     " widget.appointmentModel.appointmentDate",
          //       //     "widget.appointmentModel.startTime");
          //     },
          //     child: Container(
          //       height: 52,
          //       width: 52,
          //       color: Colors.transparent,
          //       child: Center(
          //         child: SvgPicture.asset(
          //           'assets/svg/notification.svg',
          //           width: 20,
          //           height: 20,
          //           color: colorViolet,
          //         ),
          //       ),
          //     ),
          //   ),
          //   const SizedBox(
          //     width: 16,
          //   ),
          // ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await refreshData();
          },
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SearchConsultantsScreen(
                              searchKeyWord: '',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: TextField(
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  hintText: "Search Consultant....",
                                  enabled: false,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffB2B7C0),
                                    fontFamily: "SemiBold",
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: VerticalDivider(
                                color: Color(0xffE4E4E4),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.search,
                              color: Color(0xffB2B7C0),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),

                  Obx(() {
                    if (serviceCategoryController.isLoading.value) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    if (sliderController.allSlider.isEmpty) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE5E5E5),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/nine.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                'Anurag',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: "Bold"),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    final itemCount = serviceCategoryController.isExpanded.value
                        ? serviceCategoryController.allServiceCategory.length + 1
                        : (serviceCategoryController.allServiceCategory.length > 7
                            ? 8
                            : serviceCategoryController
                                .allServiceCategory.length);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: GridView.builder(
                        itemCount: itemCount,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 26,
                                crossAxisSpacing: 12,
                                mainAxisExtent: 64),
                        itemBuilder: (BuildContext context, int index) {
                          if (!serviceCategoryController.isExpanded.value &&
                              index == 7) {
                            return GestureDetector(
                              onTap: () {
                                serviceCategoryController.isExpanded.value = true;
                              },
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: colorBlack, width: 2),
                                          shape: BoxShape.circle),
                                      child: const Center(
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }

                          if (serviceCategoryController.isExpanded.value &&
                              index == itemCount - 1) {
                            return GestureDetector(
                              onTap: () {
                                serviceCategoryController.isExpanded.value =
                                    false;
                              },
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: colorBlack, width: 2),
                                          shape: BoxShape.circle),
                                      child: const Center(
                                        child: Icon(
                                          Icons.keyboard_arrow_up,
                                          size: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          final serviceCategory =
                              serviceCategoryController.allServiceCategory[index];
                          return MenuItem(serviceCategoryModel: serviceCategory);
                        },
                      ),
                    );
                  }),

                  const SizedBox(
                    height: 26,
                  ),

                  Obx(() {
                    if (sliderController.isLoading.value) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 100.0,
                          autoPlay: true,
                        ),
                        items: [
                          'assets/images/sliderOne.png',
                          'assets/images/slide.png',
                          'assets/images/sliderTwo.png',
                        ].map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                    if (sliderController.allSlider.isEmpty) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 100.0,
                          autoPlay: true,
                        ),
                        items: [
                          'assets/images/sliderOne.png',
                          'assets/images/slide.png',
                          'assets/images/sliderTwo.png',
                        ].map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 100.0,
                        autoPlay: true,
                      ),
                      items: sliderController.allSlider.map((slider) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  slider.image,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return ShimmerEffect(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              'assets/images/nine.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(() {
                    if (appointmentsController.isLoading.value) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Appointments",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff343F52),
                                      fontFamily: "Bold"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                BottomNavScreen(currentTab: 2)));
                                  },
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffED802D),
                                        fontFamily: "Bold"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    } else if (appointmentsController
                        .dashboardUpcomingAppointments.isEmpty) {
                      return SizedBox();
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Appointments",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff343F52),
                                      fontFamily: "Bold"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                BottomNavScreen(currentTab: 2)));
                                  },
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffED802D),
                                        fontFamily: "Bold"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    }
                  }),

                  ///
                  Obx(() {
                    if (appointmentsController.isLoading.value) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            AppointmentSkeletonWidget(),
                            SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                      );
                    } else if (appointmentsController
                        .dashboardUpcomingAppointments.isEmpty) {
                      return SizedBox();
                    } else {
                      final List<Widget> widgetList = appointmentsController
                          .dashboardUpcomingAppointments
                          .map((appointment) {
                        return AppointmentWidget(appointmentModel: appointment);
                      }).toList();
                      return Column(
                        children: [
                          CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                                height: 100.0,
                                autoPlay: false,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                            items: widgetList.map((widget) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: widget,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widgetList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _controller.animateToPage(entry.key),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == entry.key
                                            ? Colors.black
                                            : Colors.grey),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    }
                  }),

                  ///
                  Obx(() {
                    return consultantsController.featuredConsultants.isEmpty
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Featured Consultants",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff343F52),
                                      fontFamily: "Bold"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const ReviewsScreen()));
                                  },
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffED802D),
                                        fontFamily: "Bold"),
                                  ),
                                ),
                              ],
                            ),
                          );
                  }),

                  Obx(() {
                    return consultantsController.featuredConsultants.isEmpty
                        ? SizedBox()
                        : const SizedBox(
                            height: 16,
                          );
                  }),
                  Obx(() {
                    if (consultantsController.isLoading.value) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              ShimmerEffect(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 90,
                                    width:
                                        MediaQuery.of(context).size.width * 0.78,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  )),
                              const SizedBox(
                                width: 24,
                              ),
                              ShimmerEffect(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 90,
                                    width:
                                        MediaQuery.of(context).size.width * 0.78,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  )),
                              const SizedBox(
                                width: 24,
                              ),
                              ShimmerEffect(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 90,
                                    width:
                                        MediaQuery.of(context).size.width * 0.78,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  )),
                              const SizedBox(
                                width: 24,
                              ),
                              ShimmerEffect(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 90,
                                    width:
                                        MediaQuery.of(context).size.width * 0.78,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  )),
                              const SizedBox(
                                width: 24,
                              ),
                              ShimmerEffect(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 90,
                                    width:
                                        MediaQuery.of(context).size.width * 0.78,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }
                    if (consultantsController.featuredConsultants.isEmpty) {
                      return SizedBox();
                    }
                    return SizedBox(
                      height: 90,
                      child: ListView.builder(
                        itemCount:
                            consultantsController.featuredConsultants.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final consultant =
                              consultantsController.featuredConsultants[index];
                          return FeaturedConsultantWidget(
                              consultantsModel: consultant);
                        },
                      ),
                    );
                  }),

                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Top Consultants",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color(0xff343F52),
                              fontFamily: "Bold"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BottomNavScreen(
                                          currentTab: 1,
                                        ),
                                    maintainState: false));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffED802D),
                                fontFamily: "Bold"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  SizedBox(
                    height: 32,
                    child: Obx(() {
                      if (serviceCategoryController.isLoading.value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        dashboardApis.currentFilter.value == "All"
                                            ? colorOrange
                                            : colorWhite,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 6),
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              dashboardApis.currentFilter.value ==
                                                      "All"
                                                  ? colorWhite
                                                  : colorOrange,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        dashboardApis.currentFilter.value == "All"
                                            ? colorOrange
                                            : colorWhite,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 6),
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              dashboardApis.currentFilter.value ==
                                                      "All"
                                                  ? colorWhite
                                                  : colorOrange,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        dashboardApis.currentFilter.value == "All"
                                            ? colorOrange
                                            : colorWhite,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 6),
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              dashboardApis.currentFilter.value ==
                                                      "All"
                                                  ? colorWhite
                                                  : colorOrange,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        dashboardApis.currentFilter.value == "All"
                                            ? colorOrange
                                            : colorWhite,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 6),
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              dashboardApis.currentFilter.value ==
                                                      "All"
                                                  ? colorWhite
                                                  : colorOrange,
                                          fontFamily: "SemiBold"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (serviceCategoryController.allServiceCategory.isEmpty) {
                        return Center(
                          child: Text(
                            "No Service Category",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorViolet,
                                fontFamily: "SemiBold"),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount:
                            serviceCategoryController.allServiceCategory.length +
                                1, // Increase item count by 1
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            // Return "All" category at index 0
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0)
                                  .copyWith(left: 12),
                              child: GestureDetector(
                                onTap: () async {
                                  await dashboardApis.changeFilter('All');
                                },
                                child: Obx(() {
                                  return Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: dashboardApis.currentFilter.value ==
                                              "All"
                                          ? colorOrange
                                          : colorWhite,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: const Color(0xffED802D),
                                          width: 1),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22.0),
                                        child: Text(
                                          "All",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: dashboardApis
                                                        .currentFilter.value ==
                                                    "All"
                                                ? colorWhite
                                                : colorOrange,
                                            fontFamily: "SemiBold",
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          }

                          final serviceCategory = serviceCategoryController
                              .allServiceCategory[index - 1];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(onTap: () async {
                              await dashboardApis
                                  .changeFilter(serviceCategory.name);
                              await consultantsController
                                  .getConsultantsByCategory(serviceCategory.name);
                              setState(() {
                                _isLoading = true;
                              });
                              await Future.delayed(Duration(seconds: 1));
                              setState(() {
                                _isLoading = false;
                              });
                            }, child: Obx(() {
                              return Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  color: dashboardApis.currentFilter.value ==
                                          serviceCategory.name
                                      ? colorOrange
                                      : colorWhite,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color(0xffED802D), width: 1),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0),
                                    child: Text(
                                      serviceCategory.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            dashboardApis.currentFilter.value ==
                                                    serviceCategory.name
                                                ? colorWhite
                                                : colorOrange,
                                        fontFamily: "SemiBold",
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _isLoading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: [
                              ConsultantSkeleton(),
                              SizedBox(
                                height: 16,
                              ),
                              ConsultantSkeleton(),
                              SizedBox(
                                height: 16,
                              ),
                              ConsultantSkeleton(),
                              SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        )
                      : Obx(() {
                          if (consultantsController.isLoading.value) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                children: [
                                  ConsultantSkeleton(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  ConsultantSkeleton(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  ConsultantSkeleton(),
                                  SizedBox(
                                    height: 16,
                                  )
                                ],
                              ),
                            );
                          }
                          if (consultantsController.topConsultants.isEmpty) {
                            return Center(
                              child: Text(
                                "No Top Consultant",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: colorViolet,
                                    fontFamily: "SemiBold"),
                              ),
                            );
                          }
                          if (dashboardApis.currentFilter.value != 'All' &&
                              consultantsController
                                  .filteredTopConsultants.isEmpty) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                children: [
                                  ShimmerEffect(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 120,
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
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 120,
                                      )),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: dashboardApis.currentFilter.value == 'All'
                                ? consultantsController.topConsultants.length
                                : consultantsController
                                    .filteredTopConsultants.length,
                            shrinkWrap: true,
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final consultant =
                                  dashboardApis.currentFilter.value == 'All'
                                      ? consultantsController
                                          .topConsultants[index]
                                      : consultantsController
                                          .filteredTopConsultants[index];
                              return ConsultantsWidget(
                                consultantModel: consultant,
                                save: false,
                                searchQuery: '',
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
}

class MenuItem extends StatelessWidget {
  final ServiceCategoryModel serviceCategoryModel;

  const MenuItem({super.key, required this.serviceCategoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SearchConsultantsScreen(
                      searchKeyWord: serviceCategoryModel.name,
                    )));
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
            color: const Color(0xffE5E5E5),
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              serviceCategoryModel.thumbnail,
              height: 30,
              width: 30,
            ),
            Text(
              serviceCategoryModel.name,
              style: const TextStyle(
                  fontSize: 10, color: Colors.black, fontFamily: "Bold"),
            ),
          ],
        ),
      ),
    );
  }
}
