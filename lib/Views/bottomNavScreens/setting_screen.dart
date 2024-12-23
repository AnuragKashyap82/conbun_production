import 'dart:typed_data';
import 'package:conbun_production/Views/addFeedbackScreen/add_feedback_screen.dart';
import 'package:conbun_production/Views/editProfileScreen/edit_profile_screen.dart';
import 'package:conbun_production/Views/followers_screen.dart';
import 'package:conbun_production/Views/help_center/help_center.dart';
import 'package:conbun_production/Views/profile_screen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../Controllers/user_controller.dart';
import '../PoliciesScreen/privacy_policy_screen.dart';
import '../editProfileScreen/edit_profile_apis.dart';
import 'bottomNavScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserController userController = Get.find();

  Uint8List? _image;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> pickImage(ImageSource source) async {
    // final bool isGranted = await _requestPermissions();
    // if (!isGranted) {
    //  await _requestPermissions();
    //   return;
    // }
    try {
      XFile? _file = await _picker.pickImage(source: source);

      if (_file != null) {
        _image =  await _file.readAsBytes();
        setState(() {
          _imageFile = _file;
        });
        await  EditProfileApis().uploadImage(userController.userData().id, _imageFile!);
        await userController.fetchUserData();
        showDialog(
            context: context,
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
                        "Profile Updated",
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
                              "Done",
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
        print('No Image Selected!!');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void selectImage() async {
    await pickImage(ImageSource.gallery);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<void> refreshData() async {

    await userController.fetchUserData();
    await userController.fetchUserWalletBalance();

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
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
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
            titleSpacing: 0,
            title: Text(
              "Setting",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorViolet,
                  fontFamily: "SemiBold"),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await refreshData();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 22,
                color: Color(0xff7182BC).withOpacity(0.03),
              ),
              Container(
                color: Color(0xff7182BC).withOpacity(0.03),
                height: 200,
                child: Stack(
                  children: [
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   left: 0,
                    //   child: Container(
                    //     height: 72,
                    //     decoration:
                    //     BoxDecoration(color: colorViolet.withOpacity(0.2)),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         SizedBox(
                    //           width: 80,
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (_) => BalanceScreen()));
                    //           },
                    //           child: SvgPicture.asset(
                    //             'assets/svg/wallet.svg',
                    //             width: 18,
                    //             height: 18,
                    //             color: colorViolet,
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: 16,
                    //         ),
                    //         Obx((){
                    //           if(userController.isLoading.value){
                    //             return SizedBox();
                    //           }
                    //           return Text(
                    //             "₹${double.parse(userController.userWalletBalance.value ?? '0.0').toStringAsFixed(2)}",
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w800,
                    //                 color: Color(0xff676f81),
                    //                 fontFamily: "Bold"),
                    //           );
                    //         })
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx((){
                                if(userController.isLoading.value){
                                  return GestureDetector(
                                    onTap: selectImage,
                                    child: ShimmerEffect(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        height: 170,
                                        width: MediaQuery.of(context).size.width *
                                            0.35,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(
                                                  0, 0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child:Image.asset(
                                                'assets/images/person.png',
                                                height: 170,
                                                width: MediaQuery.of(context).size.width *
                                                    0.35,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    ),
                                  );
                                }else{
                                  return GestureDetector(
                                    onTap: selectImage,
                                    child: Container(
                                      height: 170,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(
                                                0, 0), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: _imageFile != null
                                                    ? Image.memory(
                                                  _image!,
                                                  height: 170,
                                                  width: MediaQuery.of(context).size.width *
                                                      0.35,
                                                  fit: BoxFit.cover,
                                                )
                                                    : Image.network(
                                                  userController.userData().profileImage,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return ShimmerEffect(
                                                      baseColor: Colors.grey.shade300,
                                                      highlightColor: Colors.grey.shade100,
                                                      child : Container(
                                                        height: 170,
                                                        width: MediaQuery.of(context).size.width *
                                                            0.35,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  loadingBuilder: (context, child,
                                                      loadingProgress) {
                                                    if(loadingProgress == null) {
                                                      return child;
                                                    }else{
                                                      return ShimmerEffect(
                                                        baseColor: Colors.grey.shade300,
                                                        highlightColor: Colors.grey.shade100,
                                                        child : Container(
                                                          height: 170,
                                                          width: MediaQuery.of(context).size.width *
                                                              0.35,
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey,
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  height: 170,
                                                  width: MediaQuery.of(context).size.width *
                                                      0.35,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          Positioned(
                                            bottom: 2,
                                            right: 2,
                                            child: Container(
                                                height: 36,
                                                width: 36,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    shape: BoxShape.circle
                                                ),
                                                child: Center(child: Icon(Icons.image_search,color: colorSecondaryViolet, size: 20,))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }),

                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                EditProfileScreen(code: 'setting',)));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            userController.userData().name == null ? "": userController.userData().name!,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900,
                                                color: colorSecondaryViolet,
                                                fontFamily: "Bold"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          EditProfileScreen(code: 'setting',)));
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              size: 14,
                                              color: Color(0xff3F3F3F),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.email_outlined,
                                            size: 12,
                                            color: colorSecondaryViolet,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              userController.userData().email == null ? "":  userController.userData().email!,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(0xff676f81),
                                                  fontFamily: "Bold"),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.call_outlined,
                                            size: 12,
                                            color: colorSecondaryViolet,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "+91 ${userController.userData().phoneNumber}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xff676f81),
                                                fontFamily: "Bold"),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Account",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8B8B8B),
                          fontFamily: "SemiBold"),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => FollowersScreen()));
                      },
                      child: SettingItems(
                        title: 'Followings',
                        svgName: 'heart-regular',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ProfileScreen(code: 'setting',)));
                      },
                      child: SettingItems(
                        title: 'Profile',
                        svgName: 'user-regular',
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => TransactionHistoryScreen()));
                    //   },
                    //   child: SettingItems(
                    //     title: 'Transaction History',
                    //     svgName: 'transaction',
                    //   ),
                    // ),
                    // Divider(
                    //   color: Color(0xffE3E3E3),
                    // ),
                    // Text(
                    //   "Push Notification",
                    //   style: TextStyle(
                    //       fontSize: 11,
                    //       fontWeight: FontWeight.w500,
                    //       color: Color(0xff8B8B8B),
                    //       fontFamily: "SemiBold"),
                    // ),
                    // SizedBox(
                    //   height: 6,
                    // ),
                    // NotificationItems(
                    //   title: 'Alert Notification',
                    //   svgName: 'notification',
                    //   values: true,
                    // ),
                    // NotificationItems(
                    //   title: 'Appointments',
                    //   svgName: 'Appointments',
                    //   values: true,
                    // ),

                    Divider(
                      color: Color(0xffE3E3E3),
                    ),
                    Text(
                      "More info & Support",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8B8B8B),
                          fontFamily: "SemiBold"),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PrivacyPolicy()));
                      },
                      child: SupportItems(
                        title: 'Privacy',
                        svgName: 'lock-alt-svgrepo-com',
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (_) => SecurityScreen()));
                    //   },
                    //   child: SupportItems(
                    //     title: 'Security',
                    //     svgName: 'security',
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddFeedbackScreen()));
                      },
                      child: SupportItems(
                        title: 'Services & Feedback',
                        svgName: 'transaction',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HelpCenter(selectedTab: 0,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.help_outline_outlined,
                              size: 20,
                              color: Color(0xff464646),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                'Help Center',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: settingTextColor,
                                    fontFamily: "SemiBold"),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: settingTextColor,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingItems extends StatelessWidget {
  final String title;
  final String svgName;

  const SettingItems({super.key, required this.title, required this.svgName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/$svgName.svg',
            width: 18,
            height: 18,
            color: Color(0xff464646),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 15,
                  color: settingTextColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SemiBold"),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: settingTextColor,
            size: 16,
          )
        ],
      ),
    );
  }
}

class SupportItems extends StatelessWidget {
  final String title;
  final String svgName;

  const SupportItems({super.key, required this.title, required this.svgName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/$svgName.svg',
            width: 20,
            height: 20,
            color: Color(0xff464646),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 15,
                  color: settingTextColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SemiBold"),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: settingTextColor,
            size: 16,
          )
        ],
      ),
    );
  }
}

class NotificationItems extends StatefulWidget {
  final String title;
  final String svgName;
  late bool values;

  NotificationItems(
      {super.key,
        required this.title,
        required this.svgName,
        required this.values});

  @override
  State<NotificationItems> createState() => _NotificationItemsState();
}

class _NotificationItemsState extends State<NotificationItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/${widget.svgName}.svg',
            width: 18,
            height: 18,
            color: Color(0xff464646),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingTextColor,
                  fontFamily: "SemiBold"),
            ),
          ),
          Container(
            height: 16,
            width: 40,
            child: Transform.scale(
              scale: 0.8,
              child: Switch(
                activeColor: Colors.white,
                activeTrackColor: Colors.blue,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withOpacity(0.5),
                value: widget.values,
                onChanged: (value) => {
                  setState(() {
                    widget.values = !widget.values;
                  })
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}