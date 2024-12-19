
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../bottomNavScreens/bottomNavScreen.dart';
import 'feedback_apis.dart';

class AddFeedbackScreen extends StatefulWidget {
  const AddFeedbackScreen({super.key});

  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  FeedbackApis  feedbackApis = Get.put(FeedbackApis());
  UserController  userController = Get.find();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: colorViolet,
                  size: 18,
                )),
            title: Text(
              "Feedback",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorViolet,
                  fontFamily: "SemiBold"),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 8,
                  style: TextStyle(
                    fontFamily: "Bold",
                    fontSize: 12,
                    color: Color(0xff60697B),
                  ),
                  controller: _feedbackController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 0),
                      enabledBorder: InputBorder.none,
                      hintText: 'Enter your feedback',
                      hintStyle: TextStyle(
                        fontFamily: "Bold",
                        fontSize: 12,
                        color: Color(0xff60697B),
                      ),
                      focusedBorder: InputBorder.none),
                ),
              ),
            ),
            Expanded(
              child : SizedBox(
                height: 6,
              ),
            ),
            Obx((){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: GestureDetector(
                  onTap: () async{
                    if(_feedbackController.text.trim().isEmpty){
                      showSnackBar('Enter feedback', context);
                    }else{
                      final response = await feedbackApis.submitFeedBack(_feedbackController.text.trim());
                      if(response['Error'] == 0){
                        setState(() {
                          _feedbackController.text = '';
                        });
                        showDialog(
                            context: context,
                            barrierDismissible: false,
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/images/done.png'),
                                      SizedBox(
                                        height: 16,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                      Text(
                                        "FeedBack Submitted Successfully",
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => BottomNavScreen(
                                                    currentTab: 3,
                                                  )));
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          decoration: BoxDecoration(
                                              color: colorBlack,
                                              borderRadius:
                                              BorderRadius.circular(100)),
                                          child: Center(
                                            child: Text(
                                              "Go Back",
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
                      }else{
                        showSnackBar(response['message'], context);
                      }
                    }
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: colorBlack,
                        border: Border.all(color: Color(0xff636363)),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: feedbackApis.isLoading.value?CircularProgressIndicator(strokeWidth: 2,color: colorWhite,):Text(
                        "Sumit",
                        style: TextStyle(
                            fontSize: 14,
                            color: colorWhite,
                            fontFamily: "Regular"),
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
