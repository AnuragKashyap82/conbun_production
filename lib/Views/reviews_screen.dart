import 'package:conbun_production/Widgets/reviews_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../utils/colors.dart';

class ReviewsScreen extends StatefulWidget {
  final snap;
  const ReviewsScreen({super.key, required this.snap});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
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
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: colorViolet,size: 16,)),
        title: Text(
          "Reviews",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
      ),
      body:
      ListView.builder(
        itemCount: widget.snap.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final consultantReviews =
          widget.snap[index];
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0),
            child:  ReviewsWidget(consultantReviewModel: consultantReviews),
          );
        },
      )
    );
  }
}
