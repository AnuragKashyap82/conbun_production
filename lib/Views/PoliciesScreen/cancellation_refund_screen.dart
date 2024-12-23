import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import '../../Controllers/policy_controller.dart';
import '../../utils/colors.dart';

class CancellationRefundScreen extends StatefulWidget {
  const CancellationRefundScreen({super.key});

  @override
  State<CancellationRefundScreen> createState() => _CancellationRefundScreenState();
}

class _CancellationRefundScreenState extends State<CancellationRefundScreen> {
  PolicyController policyController = Get.put(PolicyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyController.fetchUserData('Cancellation_Refund');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
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
          "Cancellation & Refund",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
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
