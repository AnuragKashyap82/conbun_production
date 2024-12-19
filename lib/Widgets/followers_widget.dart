import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../Models/followers_model.dart';
import '../Views/consultantDetailsScreen/consultants_details_screen.dart';
import '../utils/colors.dart';

class FollowersWidget extends StatefulWidget {
  final FollowerModel followerModel;
  const FollowersWidget({super.key, required this.followerModel});

  @override
  State<FollowersWidget> createState() => _FollowersWidgetState();
}

class _FollowersWidgetState extends State<FollowersWidget> {
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('id') ?? '';
    return token;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 16),
      child: GestureDetector(
        onTap: () async{
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>  ConsultantsDetailsScreen(consultantId: widget.followerModel.consultantid, code: 'notLive',)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xffEDEDED))),
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        widget.followerModel.profileImage,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 70,
                                width: 70,
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
                            width: 70,
                            height: 70,
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
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.followerModel.consultant_name,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: "Bold"),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              widget.followerModel.verified == 'Yes'?
                              Icon(
                                Icons.verified,
                                size: 12,
                                color: Colors.blue,
                              ):SizedBox(),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.followerModel.categories,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff969696),
                              fontFamily: "Bold",
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 12,
                                color: Color(0xff969696),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "${widget.followerModel.city} | ${widget.followerModel.state}",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff969696),
                                    fontFamily: "SemiBold"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    widget.followerModel.avgRating,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xff969696),
                                        fontFamily: "Bold"),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    height: 3,
                                    width: 3,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff969696)),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${widget.followerModel.reviews} Reviews',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xff969696),
                                        fontFamily: "SemiBold"),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(100)),
                                  child:  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 3),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.card_giftcard,
                                          size: 12,
                                          color: Color(0xff969696),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${widget.followerModel.experience} years Exp.",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: colorViolet,
                                                fontFamily: "SemiBold"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
