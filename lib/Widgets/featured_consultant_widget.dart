import 'package:flutter/material.dart';

import '../Models/consultants_model.dart';
import '../Views/consultantDetailsScreen/consultants_details_screen.dart';

class FeaturedConsultantWidget extends StatelessWidget {
  final ConsultantModel consultantsModel;

  const FeaturedConsultantWidget({super.key, required this.consultantsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ConsultantsDetailsScreen(
                        consultantId: consultantsModel.id,
                    code: 'notLive',
                      )));
        },
        child: Container(
          height: 90,
          width: MediaQuery.of(context).size.width * 0.78,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xffEDEDED))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          consultantsModel.profileImage,
                          width: 42,
                          height: 42,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                       consultantsModel.name,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: "SemiBold"),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      consultantsModel.verified == "Yes"
                                          ?
                                      Icon(Icons.verified, color: Colors.blue, size: 14,):SizedBox()
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                consultantsModel.featured == "Yes"
                                    ?
                                Container(
                                  decoration: BoxDecoration(
                                    color:Colors.yellow,
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                                          child: Center(
                                            child: Text(
                                              'Featured',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: "SemiBold"),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              consultantsModel.categories,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff969696),
                                  fontFamily: "SemiBold"),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade700,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          consultantsModel.avgRating,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff969696),
                              fontFamily: "SemiBold"),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 3,
                          width: 3,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff969696)),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '${consultantsModel.reviews} Reviews',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff969696),
                              fontFamily: "SemiBold"),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffEC9048),
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.card_giftcard,
                              size: 12,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${consultantsModel.experience} years Exp.",
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontFamily: "SemiBold"),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
