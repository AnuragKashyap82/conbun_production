import 'dart:typed_data';
import 'package:conbun_production/Controllers/appointments_controller.dart';
import 'package:conbun_production/Controllers/follower_controller.dart';
import 'package:conbun_production/Controllers/transaction_account_controller.dart';
import 'package:conbun_production/Controllers/transaction_recharge_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Views/PoliciesScreen/cancellation_refund_screen.dart';
import 'package:conbun_production/Views/editProfileScreen/edit_profile_apis.dart';
import 'package:conbun_production/Views/editProfileScreen/edit_profile_screen.dart';
import 'package:conbun_production/Views/help_center/help_center.dart';
import 'package:conbun_production/Views/loginScreen/login_screen.dart';
import 'package:conbun_production/Views/PoliciesScreen/term_condition_screen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'PoliciesScreen/privacy_policy_screen.dart';
import 'bottomNavScreens/bottomNavScreen.dart';

class ProfileScreen extends StatefulWidget {
  final String code;
  const ProfileScreen({super.key, required this.code});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  UserController userController = Get.find();
  AppointmentsController appointmentsController = Get.find();

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
  }

  // Future<bool> _requestPermissions() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.camera,
  //     Permission.storage,
  //   ].request();
  //
  //   bool allGranted = statuses.values.every((status) => status.isGranted);
  //   return allGranted;
  // }

  Future<void> pickImage(ImageSource source) async {
    // final bool isGranted = await _requestPermissions();
    // if (!isGranted) {
    //  await _requestPermissions();
    //   return;
    // }
    try {
      XFile? _file = await _picker.pickImage(source: source);

      if (_file != null) {
        _image = await _file.readAsBytes();
        setState(() {
          _imageFile = _file;
        });
        await EditProfileApis()
            .uploadImage(userController.userData().id, _imageFile!);
        await userController.fetchUserData();
      } else {
        print('No Image Selected!!');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void selectImage() async {
    await pickImage(ImageSource.gallery);
  }

  Future<void> refreshData() async {
    await userController.fetchUserWalletBalance();
  }

  Future<void> openUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            if(widget.code =='setting'){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BottomNavScreen(currentTab: 3),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0); // Starts from left
                    const end = Offset.zero;         // Ends at the current position
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            }else{
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BottomNavScreen(currentTab: 0),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0); // Starts from left
                    const end = Offset.zero;         // Ends at the current position
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            }
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            title: Text(
              "Profile",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorViolet,
                  fontFamily: "SemiBold"),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: colorViolet,
                size: 20,
              ),
              onPressed: () {
                if(widget.code =='setting'){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BottomNavScreen(currentTab: 3),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        // Fade animation
                        final fadeAnimation = animation.drive(Tween(begin: 0.0, end: 1.0));

                        // Scale animation
                        final scaleAnimation = animation.drive(Tween(begin: 1.5, end: 1.0)
                            .chain(CurveTween(curve: Curves.easeInOut)));

                        // Combine fade and scale transitions
                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );

                }else{
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BottomNavScreen(currentTab: 0),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        // Fade animation
                        final fadeAnimation = animation.drive(Tween(begin: 0.0, end: 1.0));

                        // Scale animation
                        final scaleAnimation = animation.drive(Tween(begin: 1.5, end: 1.0)
                            .chain(CurveTween(curve: Curves.easeInOut)));

                        // Combine fade and scale transitions
                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );

                }
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await refreshData();
            },
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() {
                      if (userController.isLoading.value) {
                        return Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: selectImage,
                            child: Container(
                              height: 145,
                              width: 145,
                              decoration: BoxDecoration(
                                  color: Color(0xffFEF9F6),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: ShimmerEffect(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 113,
                                    width: 113,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFEF9F6),
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: _imageFile != null
                                                ? Image.memory(
                                                    _image!,
                                                    height: 113,
                                                    width: 113,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    'assets/images/person.png',
                                                    height: 113,
                                                    width: 113,
                                                    fit: BoxFit.cover,
                                                  ))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: selectImage,
                            child: Container(
                              height: 145,
                              width: 145,
                              decoration: BoxDecoration(
                                  color: Color(0xffFEF9F6),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Container(
                                  height: 113,
                                  width: 113,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEF9F6),
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: ClipRRect(
                                          borderRadius:
                                             BorderRadius.circular(100),
                                          child: _imageFile != null
                                              ? Image.memory(
                                            _image!,
                                            height: 113,
                                            width: 113,
                                            fit: BoxFit.cover,
                                          )
                                              : Image.network(
                                            userController
                                                .userData()
                                                .profileImage,
                                            errorBuilder: (context, error,
                                                stackTrace) {
                                              return ShimmerEffect(
                                                baseColor:
                                                Colors.grey.shade300,
                                                highlightColor:
                                                Colors.grey.shade100,
                                                child: Container(
                                                  height: 113,
                                                  width: 113,
                                                  decoration:
                                                  BoxDecoration(
                                                      color:
                                                      Colors.grey,
                                                      shape: BoxShape
                                                          .circle),
                                                ),
                                              );
                                            },
                                            loadingBuilder: (context,
                                                child, loadingProgress) {
                                              if (loadingProgress ==
                                                  null) {
                                                return child;
                                              } else {
                                                return ShimmerEffect(
                                                  baseColor: Colors
                                                      .grey.shade300,
                                                  highlightColor: Colors
                                                      .grey.shade100,
                                                  child: Container(
                                                    height: 113,
                                                    width: 113,
                                                    decoration:
                                                    BoxDecoration(
                                                        color: Colors
                                                            .grey,
                                                        shape: BoxShape
                                                            .circle),
                                                  ),
                                                );
                                              }
                                            },
                                            height: 113,
                                            width: 113,
                                            fit: BoxFit.cover,
                                          ))),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                    SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        userController.userData().name == null
                            ? ""
                            : userController.userData().name!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: colorSecondaryViolet,
                            fontFamily: "Bold"),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width * 0.93,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(2),
                    //         color: colorWhite),
                    //     child: DottedBorder(
                    //       color: Color(0xffE7E7E7),
                    //       strokeWidth: 0.8,
                    //       borderType: BorderType.RRect,
                    //       radius: Radius.circular(0),
                    //       dashPattern: [2],
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 26.0, vertical: 12),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text(
                    //                   "Wallet Balance",
                    //                   style: TextStyle(
                    //                       fontSize: 13,
                    //                       fontWeight: FontWeight.w800,
                    //                       color: onBoardingTextColor,
                    //                       fontFamily: "SemiBold"),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 6,
                    //                 ),
                    //                 Text(
                    //                   "₹${userController.userWalletBalance.value}",
                    //                   style: TextStyle(
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.w800,
                    //                       color: colorOrange,
                    //                       fontFamily: "Bold"),
                    //                 ),
                    //               ],
                    //             ),
                    //             Container(
                    //               height: 48,
                    //               width: 0.8,
                    //               color: Color(0xffE7E7E7),
                    //             ),
                    //             Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text(
                    //                   "Appointments",
                    //                   style: TextStyle(
                    //                       fontSize: 13,
                    //                       fontWeight: FontWeight.w800,
                    //                       color: onBoardingTextColor,
                    //                       fontFamily: "SemiBold"),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 6,
                    //                 ),
                    //                 Obx(() {
                    //                   return Text(
                    //                     appointmentsController
                    //                         .completedAppointments.length
                    //                         .toString(),
                    //                     style: TextStyle(
                    //                         fontSize: 14,
                    //                         fontWeight: FontWeight.w800,
                    //                         color: colorOrange,
                    //                         fontFamily: "Bold"),
                    //                   );
                    //                 }),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditProfileScreen(code: 'dashboard',)));
                        },
                        child: ProfileItems(
                          title: 'Edit Profile',
                          svgName: 'user-regular',
                        )),
                    // GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (_) => const BalanceScreen()));
                    //     },
                    //     child: ProfileItems(
                    //       title: 'Wallet',
                    //       svgName: 'wallet',
                    //     )),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => const TermConditionScreen()));
                    //   },
                    //   child: ProfileItems(
                    //     title: 'Term & Conditions',
                    //     svgName: 'term',
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PrivacyPolicy()));
                      },
                      child: ProfileItems(
                        title: 'Privacy & Policy',
                        svgName: 'privacy',
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => CancellationRefundScreen()));
                    //   },
                    //   child: ProfileItems(
                    //     title: 'Cancellation & Refund',
                    //     svgName: 'refund',
                    //   ),
                    // ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HelpCenter(selectedTab: 0,)));
                        },
                        child: ProfileItems(
                          title: 'Help',
                          svgName: 'help',
                        )),
                    GestureDetector(
                      onTap: () {
                        openUrl("https://www.conbun.com/contact");
                      },
                      child: ProfileItems(
                        title: 'Delete Account',
                        svgName: 'delete',
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width:
                                          MediaQuery.of(context).size.width,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Bold",
                                            color: colorViolet,
                                          ),
                                        ),
                                        Divider(
                                          color: Color(0xffE0DEDE),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Are you sure you want to log out",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Regular",
                                            color: colorBlack,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 26,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.37,
                                                decoration: BoxDecoration(
                                                    color: colorWhite,
                                                    border: Border.all(
                                                        color:
                                                        Color(0xff636363)),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        4)),
                                                child: Center(
                                                  child: Text(
                                                    "cancel",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: colorBlack,
                                                        fontFamily: "SemiBold"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await removeToken();
                                                await Get.delete<
                                                    UserController>();
                                                await Get.delete<
                                                    AppointmentsController>();
                                                await Get.delete<
                                                    TransactionRechargeController>();
                                                await Get.delete<
                                                    TransactionAccountController>();
                                                await Get.delete<
                                                    FollowerController>();
                                                Navigator.pop(context);
                                                Get.offAll(LoginScreen());
                                              },
                                              child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.37,
                                                decoration: BoxDecoration(
                                                    color: colorBlack,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        4)),
                                                child: Center(
                                                  child: Text(
                                                    "Yes Logout",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: colorWhite,
                                                        fontFamily: "SemiBold"),
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
                          );
                        },
                        child: ProfileItems(
                          title: 'Logout',
                          svgName: 'logout',
                        )),
                    SizedBox(
                      height: 180,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration:
              BoxDecoration(color: Color(0xffEAEAEA).withOpacity(0.7)),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow Us',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        fontFamily: "SemiBold",
                        color: Color(0xff60697B),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () =>
                                openUrl("https://www.facebook.com/profile.php?id=61569335541193"),
                            icon: Icon(
                              Icons.facebook,
                              color: Color(0xff60697B),
                            )),
                        IconButton(
                          onPressed: () => openUrl("https://x.com/conbunapp"),
                          icon: SvgPicture.asset(
                            'assets/svg/twitter.svg',
                            width: 24,
                            height: 24,
                            color: const Color(0xff60697B),
                          ),
                        ),
                        IconButton(
                            onPressed: () => openUrl("https://www.instagram.com/conbunapp/"),
                            icon: SvgPicture.asset(
                              'assets/svg/instagram.svg',
                              width: 24,
                              height: 24,
                              color: const Color(0xff60697B),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffD7D7D7),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Fiestro',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            fontFamily: "SemiBold",
                            color: Color(0xff60697B),
                          ),
                        ),
                        Text(
                          'Verison 1.0',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            fontFamily: "SemiBold",
                            color: Color(0xff60697B),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileItems extends StatelessWidget {
  final String title;
  final String svgName;

  const ProfileItems({super.key, required this.title, required this.svgName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/$svgName.svg',
                        width: 18,
                        height: 18,
                        color: colorViolet,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Bold",
                          color: Color(0xff464646),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: colorViolet,
                    size: 12,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}