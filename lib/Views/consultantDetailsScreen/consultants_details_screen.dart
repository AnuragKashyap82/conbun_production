import 'package:conbun_production/Controllers/consultants_details_controller.dart';
import 'package:conbun_production/Controllers/follower_controller.dart';
import 'package:conbun_production/Controllers/portfolio_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/consultants_details_model.dart';
import 'package:conbun_production/Views/bottomNavScreens/bottomNavScreen.dart';
import 'package:conbun_production/Views/consultantDetailsScreen/consultant_details_apis.dart';
import 'package:conbun_production/Views/editProfileScreen/edit_profile_screen.dart';
import 'package:conbun_production/Views/portfolio_screen.dart';
import 'package:conbun_production/Views/reviewScreen/write_review_screen.dart';
import 'package:conbun_production/Views/reviews_screen.dart';
import 'package:conbun_production/Views/video_player_screen.dart';
import 'package:conbun_production/Widgets/spam_filter_sheet.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../Widgets/live_filter_bottom_sheet.dart';
import '../rescheduleAppointmentScreen/reschedule_screen_two.dart';

class ConsultantsDetailsScreen extends StatefulWidget {
  final String consultantId;
  final String code;

  const ConsultantsDetailsScreen(
      {super.key, required this.consultantId, required this.code});

  @override
  State<ConsultantsDetailsScreen> createState() =>
      _ConsultantsDetailsScreenState();
}

class _ConsultantsDetailsScreenState extends State<ConsultantsDetailsScreen> {
  ConsultantDetailsController consultantDetailsController =
      Get.put(ConsultantDetailsController());
  PortfolioController portfolioController = Get.put(PortfolioController());
  FollowerController followerController = Get.put(FollowerController());
  ConsultantDetailsApis consultantDetailsApis =
      Get.put(ConsultantDetailsApis());
  UserController userController = Get.find();

  Future<void> fetchData() async {
    await consultantDetailsController.fetchUserData(
      widget.consultantId,
      userController.userData().id,
    );
    await portfolioController.fetchPortfolio(widget.consultantId);
    // permission();
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

  // Future<void> permission() async {
  //   final bool isPermission = await checkNotificationPermissionStatus();
  //
  //   if (isPermission) {
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content:
  //             Text("Notification permission is required to fetch messages."),
  //         action: SnackBarAction(
  //           label: "Settings",
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
    print(widget.consultantId);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: colorBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: GestureDetector(
            onTap: () {
              if (widget.code == 'live') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BottomNavScreen(currentTab: 5),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: AppBar(
              backgroundColor: colorWhite,
              elevation: 7,
              shadowColor: Colors.black.withOpacity(0.1),
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                  onTap: () {
                    if (widget.code == 'live') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BottomNavScreen(currentTab: 5)));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: colorViolet,
                    size: 20,
                  )),
              title: Obx(
                () {
                  return Text(
                    consultantDetailsController.userData().name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorViolet,
                      fontFamily: "SemiBold",
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(vertical: 16.0).copyWith(top: 0),
                              constraints: BoxConstraints(
                                  minHeight:
                                  MediaQuery.of(context).size.height * 0.9),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: SpamFilterSheet(
                                consultantsDetailsModel: consultantDetailsController.userData(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Image.asset(
                      'assets/images/feedback.png',
                      height: 24,
                      width: 24,
                      color: colorSecondaryViolet,
                    ))
              ],
            ),
          ),
        ),
        body: Obx(() {
          if (consultantDetailsController.isLoading.value) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerEffect(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 126,
                            width: 114,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 26,
                                  width: 120,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 26,
                                  width: 180,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 60,
                                  width: 160,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 26,
                                  width: 180,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 40,
                                  width: 180,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShimmerEffect(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 38,
                              width: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.transparent),
                              child: const SizedBox(),
                            ),
                          ),
                          ShimmerEffect(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 38,
                              width: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: colorBlack),
                              child: const Center(
                                child: Text(
                                  "shdhwfdj",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                      color: colorWhite,
                                      fontFamily: "Bold"),
                                ),
                              ),
                            ),
                          ),
                          ShimmerEffect(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                                height: 38,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.red),
                                child: SizedBox()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    ShimmerEffect(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 72,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: colorWhite),
                        child: SizedBox(),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: const Color(0xff0D0D0D).withOpacity(0.3),
                          size: 12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.82),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: const Color(0xff0D0D0D).withOpacity(0.3),
                          size: 12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ShimmerEffect(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ShimmerEffect(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 58,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShimmerEffect(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 180,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              consultantDetailsController
                                  .userData()
                                  .profileImage,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.2,
                              fit: BoxFit.cover,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  consultantDetailsController.userData().name,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: colorSecondaryViolet,
                                      fontFamily: "Bold"),
                                ),
                                Text(
                                    "${consultantDetailsController.userData().serviceArea}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xff60697B),
                                      fontFamily: "SemiBold",
                                    )),
                                const Divider(
                                  height: 8,
                                  color: Color(0xffEDEDED),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.5),
                                  child: Text(
                                    consultantDetailsController
                                        .userData()
                                        .categories,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff60697B),
                                      fontFamily: "SemiBold",
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                const Divider(
                                  height: 8,
                                  color: Color(0xffEDEDED),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: 10,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      consultantDetailsController
                                          .userData()
                                          .avgRating,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: colorSecondaryViolet,
                                          fontFamily: "Bold"),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 3,
                                      decoration: const BoxDecoration(
                                          color: colorSecondaryViolet,
                                          shape: BoxShape.circle),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "${consultantDetailsController.userData().reviews.length} Reviews",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff60697B),
                                        fontFamily: "SemiBold",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          final message =
                                              await consultantDetailsApis
                                                  .followConsultant(
                                                      userController
                                                          .userData()
                                                          .id,
                                                      consultantDetailsController
                                                          .userData()
                                                          .id);
                                          String msg = message['message'];
                                          await followerController
                                              .fetchAllFollowers();
                                          showSnackBar(msg, context);
                                          setState(() {
                                            consultantDetailsController
                                                    .userData()
                                                    .isFollow =
                                                !consultantDetailsController
                                                    .userData()
                                                    .isFollow;
                                          });
                                        },
                                        child: Container(
                                          height: 38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border:
                                                  Border.all(color: colorBlack),
                                              color: consultantDetailsController
                                                      .userData()
                                                      .isFollow
                                                  ? colorBlack
                                                  : Colors.transparent),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // isFollowing?SizedBox():
                                                Icon(
                                                  Icons.person_add,
                                                  color:
                                                      consultantDetailsController
                                                              .userData()
                                                              .isFollow
                                                          ? colorWhite
                                                          : colorBlack,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  consultantDetailsController
                                                          .userData()
                                                          .isFollow
                                                      ? "Following"
                                                      : 'Follow',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color:
                                                          consultantDetailsController
                                                                  .userData()
                                                                  .isFollow
                                                              ? colorWhite
                                                              : colorBlack,
                                                      fontFamily: "Bold"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    // Expanded(
                                    //   child: GestureDetector(
                                    //     onTap: () async {
                                    //       final bool isPermission =
                                    //           await checkNotificationPermissionStatus();
                                    //       if (isPermission) {
                                    //         if (userController.userData().name == '' ||
                                    //             userController
                                    //                     .userData()
                                    //                     .state ==
                                    //                 '' ||
                                    //             userController
                                    //                     .userData()
                                    //                     .country ==
                                    //                 '' ||
                                    //             userController
                                    //                     .userData()
                                    //                     .city ==
                                    //                 '' ||
                                    //             userController
                                    //                     .userData()
                                    //                     .profileImage ==
                                    //                 '') {
                                    //           showSnackBar(
                                    //               'Complete Your Profile',
                                    //               context);
                                    //           Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                   builder: (_) =>
                                    //                       EditProfileScreen(
                                    //                           code:
                                    //                               'appointment')));
                                    //         } else {
                                    //           Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                   builder: (_) =>
                                    //                       RescheduleScreenTwo(
                                    //                         isReschedule: false,
                                    //                         consultantId:
                                    //                             consultantDetailsController
                                    //                                 .userData()
                                    //                                 .id,
                                    //                         consultantsDetailsModel:
                                    //                             consultantDetailsController
                                    //                                 .userData(),
                                    //                       )));
                                    //         }
                                    //       } else {
                                    //         ScaffoldMessenger.of(context)
                                    //             .showSnackBar(
                                    //           SnackBar(
                                    //             content: Text(
                                    //                 "Notification permission is required to fetch messages."),
                                    //             action: SnackBarAction(
                                    //               label: "Settings",
                                    //               onPressed: () =>
                                    //                   openAppSettings(),
                                    //             ),
                                    //           ),
                                    //         );
                                    //       }
                                    //     },
                                    //     child: Container(
                                    //       height: 38,
                                    //       decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(4),
                                    //           color: colorBlack),
                                    //       child: const Center(
                                    //         child: Text(
                                    //           "Let's Talk",
                                    //           style: TextStyle(
                                    //               fontSize: 12,
                                    //               fontWeight: FontWeight.w200,
                                    //               color: colorWhite,
                                    //               fontFamily: "Bold"),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Container(
                      height: 72,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: colorWhite),
                      child: DottedBorder(
                        color: const Color(0xffE7E7E7),
                        strokeWidth: 0.5,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(6),
                        dashPattern: const [6],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Experience",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: onBoardingTextColor,
                                        fontFamily: "SemiBold"),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "${consultantDetailsController.userData().experience} years",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: colorOrange,
                                        fontFamily: "Bold"),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: VerticalDivider(
                                  color: Color(0xffE7E7E7),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Appointments",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: onBoardingTextColor,
                                        fontFamily: "SemiBold"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    consultantDetailsController
                                        .userData()
                                        .totalAppointments
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: colorOrange,
                                        fontFamily: "Bold"),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: VerticalDivider(
                                  color: Color(0xffE7E7E7),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: onBoardingTextColor,
                                        fontFamily: "SemiBold"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    consultantDetailsController
                                        .userData()
                                        .totalFollowers
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: colorOrange,
                                        fontFamily: "Bold"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Obx(() {
                      if (portfolioController.allPortfolio.isEmpty) {
                        return SizedBox();
                      } else {
                        return const SizedBox(
                          height: 26,
                        );
                      }
                    }),
                    Obx(() {
                      if (portfolioController.allPortfolio.isEmpty) {
                        return SizedBox();
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Portfolio",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: colorSecondaryViolet,
                                  fontFamily: "Bold"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const PortfolioScreen()));
                              },
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: colorOrange,
                                    fontFamily: "SemiBold"),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                    Obx(() {
                      if (portfolioController.allPortfolio.isEmpty) {
                        return SizedBox();
                      } else {
                        return const SizedBox(
                          height: 8,
                        );
                      }
                    }),

                    ///Portfolio
                    Obx(() {
                      if (portfolioController.allPortfolio.isEmpty) {
                        return SizedBox();
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() {
                              if (portfolioController.allPortfolio.isEmpty) {
                                return SizedBox();
                              } else {
                                return Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color:
                                      const Color(0xff0D0D0D).withOpacity(0.3),
                                  size: 12,
                                );
                              }
                            }),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.82),
                              child: SizedBox(
                                height: 72,
                                child: Obx(() {
                                  if (portfolioController.isLoading.value) {
                                    return Container(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ShimmerEffect(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ShimmerEffect(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ShimmerEffect(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ShimmerEffect(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ShimmerEffect(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ShimmerEffect(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ShimmerEffect(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ShimmerEffect(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                    height: 56,
                                                    width: 56,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  if (portfolioController
                                      .allPortfolio.isEmpty) {
                                    return SizedBox();
                                  }
                                  return Container(
                                    height: 72,
                                    decoration: BoxDecoration(
                                        color: colorWhite,
                                        borderRadius: BorderRadius.circular(8)),
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: ListView.builder(
                                          itemCount: portfolioController
                                              .allPortfolio.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final portfolio =
                                                portfolioController
                                                    .allPortfolio[index];
                                            return GestureDetector(
                                              // onTap: () {
                                              //   // if (portfolio.filetype
                                              //   //     .contains("image")) {
                                              //   //   Navigator.push(
                                              //   //       context,
                                              //   //       MaterialPageRoute(
                                              //   //           builder: (_) =>
                                              //   //               PortfolioFullScreen(
                                              //   //                 imageUrl:
                                              //   //                     portfolio
                                              //   //                         .fileUrl,
                                              //   //               ),),);
                                              //   // } else {
                                              //   //   showSnackBar(
                                              //   //       "Video view to be integrated",
                                              //   //       context);
                                              //   // }
                                              // },
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      insetPadding:
                                                          EdgeInsets.all(10),
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.6,
                                                        // You can adjust the height based on your design
                                                        child: Column(
                                                          children: [
                                                            // Header or Close button (optional)
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: IconButton(
                                                                color:
                                                                    colorViolet,
                                                                icon: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ),
                                                            // Scrollable image viewer
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Expanded(
                                                              child: PageView
                                                                  .builder(
                                                                controller:
                                                                    PageController(
                                                                        initialPage:
                                                                            index),
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemCount:
                                                                    portfolioController
                                                                        .allPortfolio
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        pageIndex) {
                                                                  final portfolio =
                                                                      portfolioController
                                                                              .allPortfolio[
                                                                          pageIndex];
                                                                  return portfolio
                                                                          .filetype
                                                                          .contains(
                                                                              "image")
                                                                      ? ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              PhotoView(
                                                                            backgroundDecoration:
                                                                                BoxDecoration(color: Colors.transparent),
                                                                            imageProvider:
                                                                                NetworkImage(
                                                                              portfolio.fileUrl,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : VideoPlayerScreen(
                                                                          videoUrl:
                                                                              portfolio.fileUrl,
                                                                          isAppBar:
                                                                              false,
                                                                        );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },

                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 2.0)
                                                        .copyWith(right: 3),
                                                child: Container(
                                                    height: 72,
                                                    width: 64,
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Stack(
                                                      children: [
                                                        portfolio.filetype
                                                                .contains(
                                                                    "image")
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: Image
                                                                    .network(
                                                                  portfolio
                                                                      .fileUrl,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  loadingBuilder:
                                                                      (context,
                                                                          child,
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) {
                                                                      return child;
                                                                    } else {
                                                                      return Container(
                                                                        height:
                                                                            72,
                                                                        width:
                                                                            64,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.grey.shade200,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child: Center(
                                                                            child: Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            strokeWidth:
                                                                                2,
                                                                            color:
                                                                                colorOrange,
                                                                          ),
                                                                        )),
                                                                      );
                                                                    }
                                                                  },
                                                                  height: 72,
                                                                  width: 64,
                                                                ))
                                                            : SizedBox(),
                                                        portfolio.filetype
                                                                .contains(
                                                                    "image")
                                                            ? SizedBox()
                                                            : Center(
                                                                child: Container(
                                                                    height: 24,
                                                                    width: 24,
                                                                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: colorWhite)),
                                                                    child: Center(
                                                                        child: Icon(
                                                                      Icons
                                                                          .play_arrow,
                                                                      color:
                                                                          colorWhite,
                                                                    ))),
                                                              )
                                                      ],
                                                    )),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Obx(() {
                              if (portfolioController.allPortfolio.isEmpty) {
                                return SizedBox();
                              } else {
                                return Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      const Color(0xff0D0D0D).withOpacity(0.3),
                                  size: 12,
                                );
                              }
                            }),
                          ],
                        );
                      }
                    }),

                    Obx(() {
                      if (portfolioController.allPortfolio.isEmpty) {
                        return SizedBox();
                      } else {
                        return const SizedBox(
                          height: 16,
                        );
                      }
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "About",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: colorSecondaryViolet,
                          fontFamily: "Bold"),
                    ),
                    ReadMoreText(
                      consultantDetailsController.userData().about,
                      trimMode: TrimMode.Line,
                      trimLines: 5,
                      colorClickableText: colorOrange,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xff60697B),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Regular",
                        height: 1.8,
                      ),
                      trimCollapsedText: 'Read more',
                      trimExpandedText: ' Read less',
                      lessStyle: const TextStyle(
                          fontSize: 11,
                          color: colorOrange,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Regular",
                          height: 1.8),
                      moreStyle: const TextStyle(
                          fontSize: 11,
                          color: colorOrange,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Regular",
                          height: 1.8),
                    ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // Container(
                    //   height: 58,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(2),
                    //       color: Colors.transparent),
                    //   child: DottedBorder(
                    //     color: const Color(0xffE7E7E7),
                    //     strokeWidth: 1,
                    //     borderType: BorderType.RRect,
                    //     radius: const Radius.circular(6),
                    //     dashPattern: [4],
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const Text(
                    //             "Working Time",
                    //             style: TextStyle(
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.w800,
                    //                 color: colorSecondaryViolet,
                    //                 fontFamily: "Bold"),
                    //           ),
                    //           Text(
                    //             "${consultantDetailsController.userData().workingDayFrom}-${consultantDetailsController.userData().workingDayTo}, ${consultantDetailsController.userData().workingHoursFrom}-${consultantDetailsController.userData().workingHoursTo}",
                    //             style: const TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w700,
                    //                 color: colorOrange,
                    //                 fontFamily: "Bold"),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Reviews",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: colorSecondaryViolet,
                              fontFamily: "Bold"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ReviewsScreen(
                                        snap: consultantDetailsController
                                            .userData()
                                            .reviews)));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: colorOrange,
                                fontFamily: "SemiBold"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() {
                      if (consultantDetailsController.isLoading.value) {
                        return const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorOrange,
                        );
                      }
                      if (consultantDetailsController
                          .userData()
                          .reviews
                          .isEmpty) {
                        return const Center(
                          child: Text(
                            "No Reviews",
                            style: TextStyle(
                              fontSize: 14,
                              color: colorBlack,
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 110,
                        child: ListView.builder(
                          itemCount: consultantDetailsController
                              .userData()
                              .reviews
                              .length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final consultantReviews =
                                consultantDetailsController
                                    .userData()
                                    .reviews[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: ReviewsWidgetConsultantDetails(
                                  consultantReviewModel: consultantReviews),
                            );
                          },
                        ),
                      );
                    }),

                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (widget.code == 'live') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavScreen(
              currentTab: 5,
            ),
            maintainState: false,
          ));
      return false;
    } else {
      Navigator.pop(context);
      return true;
    }

    // Returning true allows the default back button behavior.
  }
}

class ReviewsWidgetConsultantDetails extends StatelessWidget {
  final ConsultantReviewModel consultantReviewModel;

  const ReviewsWidgetConsultantDetails(
      {super.key, required this.consultantReviewModel});

  String _stripHtmlTags(String input) {
    final document = parse(input); // Parse the HTML string
    return document.body?.text ?? ""; // Extract plain text
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.77,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: colorWhite),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                        color: colorWhite, shape: BoxShape.circle),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/person.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          consultantReviewModel.name,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                        Text(
                          consultantReviewModel.dateCreated,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                      ],
                    ),
                  ),
                  PannableRatingBar(
                    rate: double.parse(consultantReviewModel.rating),
                    spacing: 0,
                    maxRating: 5.0,
                    minRating: 0.0,
                    items: List.generate(
                        5,
                        (index) => const RatingWidget(
                              selectedColor: colorOrange,
                              unSelectedColor: Colors.grey,
                              child: Icon(
                                Icons.star,
                                size: 14,
                              ),
                            )),
                    onChanged: (value) {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: Text(
                  _stripHtmlTags(consultantReviewModel.review),
                  style: const TextStyle(
                      fontSize: 10,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff60697B),
                      wordSpacing: 2,
                      fontFamily: "SemiBold"),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ));
  }
}
