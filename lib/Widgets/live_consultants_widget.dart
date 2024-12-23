import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/consultants_model.dart';
import 'package:conbun_production/Models/live_consultant_model.dart';
import 'package:conbun_production/Widgets/live_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

class LiveConsultantWidget extends StatefulWidget {
  final LiveConsultantModel liveConsultantModel;
  const LiveConsultantWidget({super.key, required this.liveConsultantModel});

  @override
  State<LiveConsultantWidget> createState() => _LiveConsultantWidgetState();
}

class _LiveConsultantWidgetState extends State<LiveConsultantWidget> {
  // var controller = Get.put(IndividualChatController());
  UserController userController = Get.find();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 16.0).copyWith(top: 0),
                constraints: BoxConstraints(
                    maxHeight:
                    MediaQuery.of(context).size.height * 0.9),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: LiveFilterBottomSheet(
                  consultantModel: widget.liveConsultantModel,
                ),
              ),
            );
          },
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: 42,
              child: Container(
                width: (MediaQuery.of(context).size.width / 3) - 24,
                decoration: BoxDecoration(
                    color: colorWhite, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.liveConsultantModel.name,
                        style: TextStyle(
                            fontSize: 11,
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
                            size: 10,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                           constraints: BoxConstraints(
                             maxWidth:40,
                           ),
                            child: Text(
                              widget.liveConsultantModel.avgRating,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff7A7A7A),
                                  fontFamily: "Bold"),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                              "${widget.liveConsultantModel.reviews} Review",
                              style: TextStyle(
                                  fontSize: 10,
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
                        widget.liveConsultantModel.categories,
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff7A7A7A),
                            fontFamily: "Bold"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 21,
              left: 0,
              right: 6,
              child: Center(
                child:
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.liveConsultantModel.profileImage,
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
            Positioned(
              top: 52,
              left: (MediaQuery.of(context).size.width / 3) * 0.45,
              child: Icon(
                Icons.circle,
                color: Colors.green,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveConsultantsSkeleton extends StatelessWidget {
  const LiveConsultantsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (_)=> ConsultantsDetailsScreen(consultantId: consultantModel.id,)));
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: 42,
              child: Container(
                width: (MediaQuery.of(context).size.width / 3) - 24,
                decoration: BoxDecoration(
                    color: colorWhite, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Anurag Kashyap",
                        style: TextStyle(
                            fontSize: 11,
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
                            size: 10,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "2.5",
                            style: TextStyle(
                                fontSize: 10,
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
                              "106 Review",
                              style: TextStyle(
                                  fontSize: 10,
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
                        "Decor | Dj | venue",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff7A7A7A),
                            fontFamily: "Bold"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 21,
              left: 0,
              right: 16,
              child: Center(
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
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/person.png',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            Positioned(
              top: 52,
              left: (MediaQuery.of(context).size.width / 3) * 0.45,
              child: Icon(
                Icons.circle,
                color: Colors.green,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
