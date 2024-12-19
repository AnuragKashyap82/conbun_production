import 'dart:async';
import 'dart:io';
import 'package:conbun_production/Views/loginScreen/login_apis.dart';
import 'package:conbun_production/Views/verifyOtpScreen/verify_otp_apis.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../NotificationServices/notification_services.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../bottomNavScreens/bottomNavScreen.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String mobileNo;

  const VerifyOTPScreen({super.key, required this.mobileNo});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  VerifyOtpApis verifyOtpApis = Get.put(VerifyOtpApis());

  String otp = '';
  late String errorText = '';
  int _start = 30;
  Timer? _timer;
  bool _isButtonVisible = false;

  void startTimer() {
    _isButtonVisible = false;
    _start = 30;
    _timer?.cancel(); // Ensure any existing timer is canceled before starting a new one
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        setState(() {
          _isButtonVisible = true;
        });
        _timer?.cancel();
      }
    });
  }
  // Add a FocusNode for the OTP field

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    // getToken();
    getDeviceId();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Future<void> getToken() async {
  //   String newToken = await NotificationServices().getDeviceToken();
  //   verifyOtpApis.deviceToken.value = newToken;
  //   print("Token!!!!!!!!!:${verifyOtpApis.deviceToken.value}");
  // }

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      verifyOtpApis.deviceId.value = androidInfo.id;
      print("Android Id: ${verifyOtpApis.deviceId.value}");
      return androidInfo.id;
    }
    else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      verifyOtpApis.deviceId.value = iosInfo.identifierForVendor!;
      print("IOS Id: ${verifyOtpApis.deviceId.value}");
      return iosInfo.identifierForVendor;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: colorBackground,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 36,
                ),
                Text(
                  "Verify Phone",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: colorBlack,
                      fontFamily: "Bold"),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "OTP has been sent to +91-${widget.mobileNo}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff757575),
                      fontFamily: "SemiBold"),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: OtpTextField(
                    numberOfFields: 6,
                    borderColor: Color(0xffE7E7E7),
                    borderWidth: 1,
                    fieldWidth: 44,
                    keyboardType: TextInputType.number,
                    borderRadius: BorderRadius.circular(6),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    contentPadding: EdgeInsets.zero,
                    enabledBorderColor: Color(0xffE7E7E7),
                    focusedBorderColor: colorOrange,
                    fieldHeight: 44,
                    showFieldAsBox: true,
                    fillColor: colorWhite,
                    filled: true,
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colorBlack,
                      fontFamily: "SemiBold",
                    ),
                    //runs when a code is typed inww
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) async {
                      otp = verificationCode;
                      verifyOtpApis.isVerifyOTPButtonActive.value = false;
                      final response = await verifyOtpApis.verifyOTP(
                        widget.mobileNo,
                        verificationCode,
                        verifyOtpApis.deviceId.value,
                        verifyOtpApis.deviceToken.value,
                      );
                      int error = response['Error'];
                      String message = response['message'];
                      if (error == 0) {

                        await verifyOtpApis.saveToken(response['data']['id']);
                        Get.offAll(BottomNavScreen(currentTab: 0));
                        verifyOtpApis.isVerifyOTPButtonActive.value = true;
                      } else {
                        setState(() {
                          errorText = message;
                        });
                        verifyOtpApis.isVerifyOTPButtonActive.value = true;
                      }
                    }, // end onSubmit
                  ),
                ),
                errorText.isNotEmpty?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorText,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colorOrange,
                        fontFamily: "Bold"),
                  ),
                ):SizedBox(),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Resend OTP in ",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff757575),
                          fontFamily: "SemiBold"),
                    ),
                    Text(
                      " $_start sec",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff757575),
                          fontFamily: "SemiBold"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                _isButtonVisible?
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      errorText = '';
                    });
                   final response =  await LoginApis().sendOTP(
                      widget.mobileNo,
                      '',
                      verifyOtpApis.deviceId.value,
                      verifyOtpApis.deviceToken.value,
                    );
                    int error = response['Error'];
                    String message = response['message'];
                    if (error == 0) {
                      startTimer();
                    } else {
                      setState(() {
                        errorText = message;
                      });
                    }
                  },
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/message.svg',
                            width: 18,
                            height: 18,
                            color: colorBlack.withOpacity(0.5),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "SMS",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Bold",
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ):SizedBox()
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 8,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width * 0.37,
                        decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: Color(0xff636363)),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            "Back",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorBlack,
                                fontFamily: "SemiBold"),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                       if(verifyOtpApis.isVerifyOTPButtonActive.value){
                         verifyOtpApis.isVerifyOTPButtonActive.value = false;
                         final response = await verifyOtpApis.verifyOTP(
                           widget.mobileNo,
                           otp,
                           verifyOtpApis.deviceId.value,
                           verifyOtpApis.deviceToken.value,
                         );
                         int error = response['Error'];
                         String message = response['message'];
                         // String mobileNo = response['data']['mobile'];
                         //
                         // showSnackBar(mobileNo, context);
                         if (error == 0) {
                           verifyOtpApis.isVerifyOTPButtonActive.value = true;
                           await verifyOtpApis.saveToken(response['data']['id']);
                           Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(
                                 builder: (_) => BottomNavScreen(currentTab: 0),
                                 maintainState: false
                             ),

                           );

                         } else {
                           verifyOtpApis.isVerifyOTPButtonActive.value = true;
                           showSnackBar(message, context);
                         }
                       }
                      },
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width * 0.37,
                        decoration: BoxDecoration(
                            color: verifyOtpApis.isVerifyOTPButtonActive.value?colorBlack:colorBlack.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorWhite,
                                fontFamily: "SemiBold"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
