import 'package:conbun_production/Controllers/policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import '../../utils/colors.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  PolicyController policyController = Get.put(PolicyController());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyController.fetchUserData('Privacy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
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
                  size: 20,
                )),
            title: Text(
              "Privacy Policy",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorViolet,
                  fontFamily: "SemiBold"),
            ),
          ),
        ),
      ),
      body: Obx((){
        if(policyController.isLoading.value){
          return Center(child: CircularProgressIndicator(color: colorOrange, strokeWidth: 2,));
        }else{
          // Parse HTML content using the html package
          var document = html_parser.parse(policyController.policyData().content);
          var body = document.body;

          // Convert parsed HTML into a string
          String parsedContent = body?.text ?? '';
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parsedContent,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorBlack,
                        fontFamily: "Regular"),
                  ),
                ],
              ),
            ),
          );
        }
      })
    );
  }
}