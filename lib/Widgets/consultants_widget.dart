import 'package:conbun_production/Controllers/consultants_controller.dart';
import 'package:conbun_production/Models/consultants_model.dart';
import 'package:conbun_production/Views/consultantDetailsScreen/consultants_details_screen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class ConsultantsWidget extends StatefulWidget {
  final ConsultantModel consultantModel;
  final bool save;
  final String searchQuery;

  const ConsultantsWidget(
      {super.key,
      required this.consultantModel,
      required this.save,
      required this.searchQuery});

  @override
  State<ConsultantsWidget> createState() => _ConsultantsWidgetState();
}

class _ConsultantsWidgetState extends State<ConsultantsWidget> {
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('id') ?? '';
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 12.0).copyWith(bottom: 16),
      child: GestureDetector(
        onTap: () async {
          ///Save only
          if(widget.save){
            String userId = await getToken();
            String message = await ConsultantsController()
                .saveSearchConsultant(userId, "User", widget.searchQuery);
            print(message);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConsultantsDetailsScreen(
                  consultantId: widget.consultantModel.id,
                  code: 'notLive',
                ),
              ),
            );
          }else{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConsultantsDetailsScreen(
                  consultantId: widget.consultantModel.id,
                  code: 'notLive',
                ),
              ),
            );
          }

        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xffEDEDED))),
          child:
          Padding(
            padding: EdgeInsets.all(8.0),
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
                        widget.consultantModel.profileImage,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
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
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.consultantModel.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: "Bold"),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    widget.consultantModel.verified == 'Yes'
                                        ?
                                    Icon(Icons.verified, size: 12, color: Colors.blue,)
                                        : SizedBox()
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              widget.consultantModel.featured == 'Yes'
                                  ?
                              Container(
                                decoration: BoxDecoration(
                                    color:Colors.yellow,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
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
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.consultantModel.categories,
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
                                "${widget.consultantModel.serviceArea}",
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
                                    widget.consultantModel.avgRating,
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
                                    '${widget.consultantModel.reviews} Reviews',
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
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 3),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            "${widget.consultantModel.experience} years Exp.",
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
