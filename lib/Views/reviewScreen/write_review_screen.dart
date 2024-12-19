import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/consultants_details_model.dart';
import 'package:conbun_production/Views/bottomNavScreens/bottomNavScreen.dart';
import 'package:conbun_production/Views/reviewScreen/review_apis.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class WriteReviewScreen extends StatefulWidget {
  final ConsultantsDetailsModel consultantsDetailsModel;
  const WriteReviewScreen({super.key, required this.consultantsDetailsModel});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {

  ReviewApis reviewApis = Get.put(ReviewApis());
  UserController userController = Get.put(UserController());
  TextEditingController reviewController =  TextEditingController();
  int _selectedValue = 1;
  double rating = 0.0;
  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.1),
        automaticallyImplyLeading: false,
        title: const Text(
          "Write a Review",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "MontserratBold",
            color: colorViolet,
          ),
        ),
        centerTitle: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: colorViolet,
              size: 20,
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(widget.consultantsDetailsModel.profileImage,
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
                        const SizedBox(
                          height: 16,
                        ),
                         Text(
                          "How was your experience\nwith Mr. ${widget.consultantsDetailsModel.name}?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Bold",
                            color: colorBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PannableRatingBar(
                              rate: rating,
                              spacing: 8,
                              maxRating: 5.0,
                              minRating: 0.0,
                              runSpacing: 0.5,
                              items: List.generate(5, (index) =>
                              const RatingWidget(
                                selectedColor: colorOrange,
                                unSelectedColor: Colors.grey,
                                child: Icon(
                                  Icons.star,
                                  size: 22,
                                ),
                              )),
                              onChanged: (value) { // the rating value is updated on tap or drag.
                                // Round the value to the nearest 0.5
                                double roundedValue = (value * 2).round() / 2;

                                setState(() {
                                  rating = roundedValue;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Divider(
                          color: Color(0xffECECEC),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Write Your Review",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff343F52),
                                fontFamily: "Bold"),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(color: const Color(0xffE7E7E7), width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextFormField(
                            maxLines: 5,
                            controller: reviewController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 5, left: 8, right: 8, top: 4),
                                enabledBorder: InputBorder.none,
                                hintText: 'Your Review',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffADACAC),
                                    fontFamily: "SemiBold"),
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        //  Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "Would you recommend Mr.${widget.consultantsDetailsModel.name}\n to your friends?",
                        //     style: TextStyle(
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.w800,
                        //       fontFamily: "SemiBold",
                        //       color: colorBlack,
                        //     ),
                        //     textAlign: TextAlign.start,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Radio<int>(
                  //       value: 1,
                  //       groupValue: _selectedValue,
                  //       activeColor: colorOrange,
                  //       onChanged: _handleRadioValueChange,
                  //     ),
                  //     const Text(
                  //       "Yes",
                  //       style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w200,
                  //         fontFamily: "SemiBold",
                  //         color: colorBlack,
                  //       ),
                  //       textAlign: TextAlign.start,
                  //     ),
                  //     const SizedBox(
                  //       width: 16,
                  //     ),
                  //     Radio<int>(
                  //       value: 2,
                  //       activeColor: colorOrange,
                  //       groupValue: _selectedValue,
                  //       onChanged: _handleRadioValueChange,
                  //     ),
                  //     const Text(
                  //       "No",
                  //       style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w200,
                  //         fontFamily: "SemiBold",
                  //         color: colorBlack,
                  //       ),
                  //       textAlign: TextAlign.start,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  )
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
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => BottomNavScreen(),
                            //         maintainState: false));
                          },
                          child: Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width * 0.37,
                            decoration: BoxDecoration(
                                color: colorWhite,
                                border: Border.all(color: const Color(0xff636363)),
                                borderRadius: BorderRadius.circular(4)),
                            child: const Center(
                              child: Text(
                                "Cancel",
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
                          onTap: () async{
                            if(rating == 0.0) {
                              showSnackBar('Set Rating', context);
                            }else if(reviewController.text.isEmpty){
                              showSnackBar('Enter Review', context);
                            }else{
                              final response = await reviewApis.writeReview(userController.userData().id, widget.consultantsDetailsModel.id, rating.toString(), reviewController.text.trim());
                              showSnackBar(response['message'], context);
                              if(response['Error'] == 0){
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: colorWhite,
                                        surfaceTintColor: colorWhite,
                                        alignment: const Alignment(0.0, 0.0),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              20.0,
                                            ),
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                          top: 10.0,
                                        ),
                                        insetPadding:
                                        const EdgeInsets.symmetric(horizontal: 21),
                                        content: Container(
                                          height: 420,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Stack(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svg/ratingDone.svg',
                                                    color: colorViolet,
                                                  ),
                                                  Positioned(
                                                      left: 0,
                                                      right: 0,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 26.0),
                                                        child: Image.asset('assets/images/star.png'),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(height: 16,
                                                width: MediaQuery.of(context).size.width,
                                              ),
                                              const Text(
                                                "Review Successful!",
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color(0xff677294),
                                                    fontFamily: "Bold"),
                                              ),
                                              const Text(
                                                "Your review has been successfully \nSubmited. thank you very much!",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff9C9C9C),
                                                    fontFamily: "SemiBold"),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(
                                                height: 26,
                                              ),
                                              GestureDetector(
                                                onTap: () async{
                                                  Navigator.pop(context);
                                                  Get.offAll(BottomNavScreen(currentTab: 0));
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                  decoration: BoxDecoration(
                                                      color: colorBlack,
                                                      borderRadius: BorderRadius.circular(100)),
                                                  child: const Center(
                                                    child: Text(
                                                      "Ok",
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
                          child: Obx((){
                            return Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.37,
                              decoration: BoxDecoration(
                                  color: colorBlack,
                                  borderRadius: BorderRadius.circular(4)),
                              child:  Center(
                                child: reviewApis.isLoading.value?CircularProgressIndicator(strokeWidth: 2, color: colorWhite,):Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100,
                                      color: colorWhite,
                                      fontFamily: "SemiBold"),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
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
