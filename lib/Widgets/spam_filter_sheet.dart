import 'package:conbun_production/Controllers/consultants_details_controller.dart';
import 'package:conbun_production/Controllers/package_controller.dart';
import 'package:conbun_production/Controllers/package_duration_controller.dart';
import 'package:conbun_production/Controllers/service_area_controller.dart';
import 'package:conbun_production/Controllers/service_category_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/consultants_details_model.dart';
import 'package:conbun_production/Models/live_consultant_model.dart';
import 'package:conbun_production/Views/bottomNavScreens/liveScreen/live_screen_apis.dart';
import 'package:conbun_production/Views/consultantDetailsScreen/consultants_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';

class SpamFilterSheet extends StatefulWidget {
  final ConsultantsDetailsModel consultantsDetailsModel;

  const SpamFilterSheet({
    super.key,
    required this.consultantsDetailsModel,
  });

  @override
  State<SpamFilterSheet> createState() => _SpamFilterSheetItemsState();
}

class _SpamFilterSheetItemsState extends State<SpamFilterSheet> {
  UserController userController = Get.find();
  ConsultantDetailsController consultantDetailsController = Get.find();
  late int _selectedReason = 3;
  late String _selectedReasonText = "I don’t want to tell";
  TextEditingController _reportCommentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Schedule the callback to run after the widget is built
    consultantDetailsController.responseMessage.value = '';
    consultantDetailsController.reportReason.value = "I don’t want to tell";
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        constraints: BoxConstraints(
            maxHeight:
            MediaQuery.of(context).size.height * 0.9),
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(top: 26),
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
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
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              widget.consultantsDetailsModel.profileImage,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.consultantsDetailsModel.name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: colorSecondaryViolet,
                                      fontFamily: "Bold"),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      widget.consultantsDetailsModel.avgRating,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff7A7A7A),
                                          fontFamily: "Bold"),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      height: 4,
                                      width: 4,
                                      decoration: BoxDecoration(
                                          color: Color(0xff7A7A7A),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${widget.consultantsDetailsModel.reviews.length} Review",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xff7A7A7A),
                                            fontFamily: "Bold"),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.consultantsDetailsModel.categories,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff7A7A7A),
                                      fontFamily: "Bold"),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: colorSecondaryViolet,
                        )),
                  )
                ],
              ),
              Divider(
                color: Color(0xffE5E5E5),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Reason For Report",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "Bold",
                  fontSize: 14,
                  color: colorBlack,
                ),
              ),
              SizedBox(
                height: 26,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 0;
                    _selectedReasonText = "I'm having a schedule clash";
                    consultantDetailsController.reportReason.value = "I'm having a schedule clash";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "I'm having a schedule clash",
                  isBorder: _selectedReason == 0? true: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 1;
                    _selectedReasonText = "I’m not available on schedule";
                    consultantDetailsController.reportReason.value = "I’m not available on schedule";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "I’m not available on schedule",
                  isBorder: _selectedReason == 1? true: false,

                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 2;
                    _selectedReasonText = "I have a activity that can’t be left behind";
                    consultantDetailsController.reportReason.value = "I have a activity that can’t be left behind";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "I have a activity that can’t be left behind",
                  isBorder: _selectedReason == 2? true: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 3;
                    _selectedReasonText = "I don’t want to tell";
                    consultantDetailsController.reportReason.value = "I don’t want to tell";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "I don’t want to tell",
                  isBorder: _selectedReason == 3? true: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 4;
                    _selectedReasonText = "Changes of plans";
                    consultantDetailsController.reportReason.value = "Changes of plans";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "Changes of plans",
                  isBorder: _selectedReason == 4? true: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedReason = 5;
                    _selectedReasonText = "Others";
                    consultantDetailsController.reportReason.value = "Others";
                  });
                },
                child: RescheduleItemsTwo(
                  title: "Others",
                  isBorder: _selectedReason == 5? true: false,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Comment",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "Bold",
                  fontSize: 14,
                  color: colorBlack,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: colorBlack.withOpacity(0.5)),
                    color: colorWhite, borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 8,
                    style: TextStyle(
                      fontFamily: "Bold",
                      fontSize: 12,
                      color: Color(0xff60697B),
                    ),
                    controller: _reportCommentController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 0),
                        enabledBorder: InputBorder.none,
                        hintText: 'Enter your Comment',
                        hintStyle: TextStyle(
                          fontFamily: "Bold",
                          fontSize: 12,
                          color: Color(0xff60697B),
                        ),
                        focusedBorder: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.center,
                child: Obx((){
                  return Text(
                    consultantDetailsController.responseMessage.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Bold",
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    consultantDetailsController.responseMessage.value =  '';
                    if(_reportCommentController.text.trim().isEmpty){
                      consultantDetailsController.responseMessage.value = 'Enter comment first';
                    }else{
                      final response = await consultantDetailsController.reportSpam(widget.consultantsDetailsModel.id, userController.userData().id, consultantDetailsController.reportReason.value, _reportCommentController.text.trim());
                      consultantDetailsController.responseMessage.value = response.toString();
                    }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        color: colorBlack, borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(
                        "Report Spam",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorWhite,
                            fontFamily: "SemiBold"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
            ),
      );
  }
}

class RescheduleItemsTwo extends StatelessWidget {
  final String title;
  final bool isBorder;

  const RescheduleItemsTwo(
      {super.key, required this.title, required this.isBorder});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
              color: colorWhite,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue,
                width: isBorder ? 4 : 1,
              )),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "Bold",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xff60697B),
          ),
        ),
      ],
    );
  }
}
