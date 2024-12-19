import 'package:conbun_production/Models/consultants_details_model.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

class ReviewsWidget extends StatelessWidget {
  final ConsultantReviewModel consultantReviewModel;
  const ReviewsWidget({super.key, required this.consultantReviewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child:
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: colorWhite
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: colorWhite,
                        shape: BoxShape.circle
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/images/person.png', fit: BoxFit.cover,)),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          consultantReviewModel.name,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                        Text(
                          consultantReviewModel.dateCreated,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                              color: colorSecondaryViolet,
                              fontFamily: "SemiBold"),
                        ),
                      ],
                    ),
                  ),
                  PannableRatingBar(
                    rate: double.parse(consultantReviewModel.rating),
                    spacing: 0,
                    maxRating: 5.0,
                    minRating: 0.0,
                    items: List.generate(5, (index) =>
                     RatingWidget(
                      selectedColor: colorOrange,
                      unSelectedColor: Colors.grey,
                      child: Icon(
                        Icons.star,
                        size: 14,
                      ),
                    )),
                    onChanged: (value) {
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8
                ),
                child: Text(
                  consultantReviewModel.review,
                  style: TextStyle(
                      fontSize: 10,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff60697B),
                      wordSpacing: 2,
                      fontFamily: "SemiBold"),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
