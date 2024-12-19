import 'package:conbun_production/Views/bottomNavScreens/bottomNavScreen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:conbun_production/Views/reviewScreen/write_review_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../Controllers/consultants_details_controller.dart';
import '../Controllers/user_controller.dart';

class ConsultantSessionEndScreen extends StatefulWidget {
  final String consultantId;
  const ConsultantSessionEndScreen({super.key, required this.consultantId});

  @override
  State<ConsultantSessionEndScreen> createState() => _ConsultantSessionEndScreenState();
}

class _ConsultantSessionEndScreenState extends State<ConsultantSessionEndScreen> {

  ConsultantDetailsController consultantDetailsController =
  Get.put(ConsultantDetailsController());
  UserController userController = Get.put(UserController());

  Future<void> fetchData() async{
    await consultantDetailsController.fetchUserData(widget.consultantId, userController.userData().id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.consultantId);
    fetchData();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                  ),
                  Image.asset('assets/images/sessionEnd.png'),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "The Consultant session has ended",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Bold",
                      color: colorBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "The Consultant session has ended",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Regular",
                      color: Color(0xff5E5E5E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 36,
                  ),
                 Obx((){
                   if(consultantDetailsController.isLoading.value){
                     return ShimmerEffect(
                       baseColor: Colors.grey.shade300,
                       highlightColor: Colors.grey.shade100,
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(100),
                         child: Image.network(consultantDetailsController.userData().profileImage,
                           width: 120,
                           height: 120,
                           fit: BoxFit.cover,
                           loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                             if (loadingProgress == null) {
                               return child;
                             } else {
                               return ShimmerEffect(
                                 baseColor: Colors.grey.shade300,
                                 highlightColor: Colors.grey.shade100,
                                 child: Container(
                                   width: 120,
                                   height: 120,
                                   decoration: BoxDecoration(
                                       color: Colors.grey.shade200,
                                       borderRadius: BorderRadius.circular(6)
                                   ),
                                 ),
                               );
                             }
                           },
                           errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                             return Container(
                               width: MediaQuery.of(context).size.width * 0.35,
                               height: MediaQuery.of(context).size.height * 0.2,
                               decoration: BoxDecoration(
                                   color: Colors.grey.shade200,
                                   borderRadius: BorderRadius.circular(6)
                               ),
                               child: Icon(
                                 Icons.person,
                                 color: Colors.grey,
                               ),
                             );
                           },
                         ),
                       ),
                     );
                   }else{
                     return  ClipRRect(
                       borderRadius: BorderRadius.circular(100),
                       child: Image.network(consultantDetailsController.userData().profileImage,
                         width: 120,
                         height: 120,
                         fit: BoxFit.cover,
                         loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                           if (loadingProgress == null) {
                             return child;
                           } else {
                             return ShimmerEffect(
                               baseColor: Colors.grey.shade300,
                               highlightColor: Colors.grey.shade100,
                               child: Container(
                                 width: 120,
                                 height: 120,
                                 decoration: BoxDecoration(
                                     color: Colors.grey.shade200,
                                     borderRadius: BorderRadius.circular(6)
                                 ),
                               ),
                             );
                           }
                         },
                         errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                           return Container(
                             width: MediaQuery.of(context).size.width * 0.35,
                             height: MediaQuery.of(context).size.height * 0.2,
                             decoration: BoxDecoration(
                                 color: Colors.grey.shade200,
                                 borderRadius: BorderRadius.circular(6)
                             ),
                             child: Icon(
                               Icons.person,
                               color: Colors.grey,
                             ),
                           );
                         },
                       ),
                     );
                   }
                 }),
                  Obx((){
                    if(consultantDetailsController.isLoading.value){
                      return SizedBox();
                    }else{
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            consultantDetailsController.userData().name,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Bold",
                              color: colorBlack,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            consultantDetailsController.userData().categories,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Regular",
                              color: Color(0xff5E5E5E),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${consultantDetailsController.userData().city}, ${consultantDetailsController.userData().state}, ${consultantDetailsController.userData().country}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Regular",
                              color: Color(0xff5E5E5E),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),

                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BottomNavScreen(currentTab: 0,),
                                    maintainState: false));
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
                                "Back to Home",
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => WriteReviewScreen(consultantsDetailsModel: consultantDetailsController.userData(),),
                                    maintainState: false));
                          },
                          child: Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width * 0.37,
                            decoration: BoxDecoration(
                                color: colorBlack,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                "Leave a Review",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
