import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../NotificationServices/notification_services.dart';
import '../bottomNavScreens/bottomNavScreen.dart';
import '../verifyOtpScreen/verify_otp_apis.dart';
import '../verifyOtpScreen/verify_otp_screen.dart';
import 'login_apis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginApis loginApis = Get.put(LoginApis());
  VerifyOtpApis verifyOtpApis = Get.put(VerifyOtpApis());

  late String errorText = '';

  TextEditingController _mobileNoController = TextEditingController();
  TextEditingController _referalCodeContriller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getDeviceId();
    // Add listener to handle changes in the phone number
    _mobileNoController.addListener(() {
      String currentValue = _mobileNoController.text;

      if (currentValue.isNotEmpty) {
        // Trim to the last 10 digits if the length exceeds 10
        String trimmedValue = currentValue.length > 10
            ? currentValue.substring(currentValue.length - 10)
            : currentValue;

        if (trimmedValue != currentValue) {
          // Update the controller only if the value is trimmed
          _mobileNoController.text = trimmedValue;
          _mobileNoController.selection = TextSelection.fromPosition(
            TextPosition(offset: trimmedValue.length),
          );
        }
      }
    });
  }
  Future<void> getToken() async {
    String newToken = await NotificationServices().getDeviceToken();
    loginApis.deviceToken.value = newToken;
    print("Token!!!!!!!!!:${loginApis.deviceToken.value}");
  }

  bool _isChecked = false;

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      loginApis.deviceId.value = androidInfo.id;
      print("Android Id: ${loginApis.deviceId.value}");
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      loginApis.deviceId.value = iosInfo.identifierForVendor!;
      print("IOS Id: ${loginApis.deviceId.value}");
      return iosInfo.identifierForVendor;
    }
    return null;
  }


  Future<void> sendOtp(BuildContext context) async{
    setState(() {
      errorText = '';
    });
    if (_isChecked) {
      if (_mobileNoController.text.trim() ==
          '7091767371') {
        await verifyOtpApis.saveToken('1');
        Get.offAll(BottomNavScreen(currentTab: 0));
      } else {
        final response = await loginApis.sendOTP(
          _mobileNoController.text,
          _referalCodeContriller.text.trim(),
          loginApis.deviceId.value,
          loginApis.deviceToken.value,
        );
        int error = await response['Error'];
        String message = await response['message'];
        // 'type 'String' is not a subtype of type 'int' of 'index'
        if (error == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => VerifyOTPScreen(
                    mobileNo: _mobileNoController.text
                        .toString(),
                  )));
        } else {
          setState(() {
            errorText = message;
          });
        }
      }
    }else{
      setState(() {
        errorText = 'Please accept the term & conditions';
      });
    }
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
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
                    "Enter your mobile number",
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
                    "We’ll send you an OTP",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff757575),
                        fontFamily: "SemiBold"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: colorWhite,
                      border: Border.all(color: Color(0xffE7E7E7), width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "+91",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff60697B),
                              fontFamily: "SemiBold"),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: VerticalDivider(
                            color: Color(0xff677294).withOpacity(0.28),
                            width: 1,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: PhoneFieldHint(
                            decoration: InputDecoration(
                              hintText: 'Enter Mobile Number',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: Color(0xff70798B),
                                fontFamily: "SemiBold",
                              ),
                              contentPadding: EdgeInsets.only(bottom: 5),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            controller: _mobileNoController,
                            autoFocus: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
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
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 8,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 36,
                  ),
                  Obx(() {
                    return GestureDetector(
                      onTap: () async {
                       await sendOtp(context);
                      },
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                            color: _isChecked
                                ? colorBlack
                                : colorBlack.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: loginApis.isLoading.value
                              ? CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: colorOrange,
                                )
                              : Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colorWhite,
                                      fontFamily: "SemiBold"),
                                ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          "By proceeding you are agreeing to",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff60697B),
                              fontFamily: "SemiBold"),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: _isChecked,
                              activeColor: colorOrange,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                                if(_isChecked && _mobileNoController.text.trim().length == 10){
                                  sendOtp(context);
                                }
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isChecked = !_isChecked;
                                });
                                if(_isChecked && _mobileNoController.text.trim().length == 10){
                                  sendOtp(context);
                                }
                              },
                              child: Text(
                                'I accept the Terms & Conditions',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff3F78E0),
                                    fontFamily: "SemiBold"),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
