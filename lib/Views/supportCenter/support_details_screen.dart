import 'package:conbun_production/Views/supportCenter/apis/support_center_apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import '../../utils/colors.dart';

class SupportDetailsScreen extends StatefulWidget {
  final String ticketId;
  final String subject;

  const SupportDetailsScreen(
      {super.key, required this.ticketId, required this.subject});

  @override
  State<SupportDetailsScreen> createState() => _SupportDetailsScreenState();
}

class _SupportDetailsScreenState extends State<SupportDetailsScreen> {
  SupportCenterApis supportCenterApis = Get.put(SupportCenterApis());

  String _stripHtmlTags(String input) {
    final document = parse(input); // Parse the HTML string
    return document.body?.text ?? ""; // Extract plain text
  }

  String getTimeAgo(String dateTimeString) {
    // Parse the input date string into a DateTime object
    final DateTime inputTime = DateTime.parse(dateTimeString);
    final now = DateTime.now();
    final difference = now.difference(inputTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() > 1 ? 's' : ''} ago";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago";
    } else {
      return "${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    supportCenterApis.getTicketDetails(widget.ticketId);
  }

  late bool isReplyVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            title: Text(
              widget.subject,
              style: TextStyle(
                fontSize: 16,
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
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await supportCenterApis.getTicketDetails(widget.ticketId);
        },
        child: SingleChildScrollView(
          child: Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() {
                  if (supportCenterApis.isLoading.value) {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorOrange,
                        )));
                  } else {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.airplane_ticket,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      supportCenterApis
                                                  .ticketDetails()
                                                  .subject !=
                                              null
                                          ? supportCenterApis
                                              .ticketDetails()
                                              .subject!
                                          : 'No Subject',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Bold",
                                        color: colorBlack,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isReplyVisible = !isReplyVisible;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: colorBlack)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 6),
                                        child: Text(
                                          isReplyVisible
                                              ? 'Close Reply'
                                              : 'Add Reply',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Bold",
                                            color: colorBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: isReplyVisible ? 0 : 16,
                        ),
                        isReplyVisible
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w200,
                                                color: colorBlack,
                                                fontFamily: "SemiBold"),
                                            maxLines: 10,
                                            decoration: InputDecoration(
                                                hintText: 'Enter message',
                                                hintStyle: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w200,
                                                    color: Color(0xffADACAC),
                                                    fontFamily: "SemiBold"),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 0,
                                                        top: 8,
                                                        right: 6,
                                                        left: 16),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder:
                                                    InputBorder.none),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                height: 52,
                                                width: 52,
                                                decoration: BoxDecoration(
                                                    color: colorWhite,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.send,
                                                    color: colorOrange,
                                                    size: 20,
                                                  ),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: isReplyVisible ? 8 : 0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 0.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '#TC-${supportCenterApis.ticketDetails().ticketid}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Bold",
                                            fontWeight: FontWeight.w800,
                                            color: colorBlack,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        supportCenterApis
                                            .ticketDetails()
                                            .subject != null?
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Text(
                                            supportCenterApis
                                                .ticketDetails()
                                                .subject!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Regular",
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  colorBlack.withOpacity(0.8),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ):SizedBox(),
                                      ],
                                    ),
                                    supportCenterApis
                                        .ticketDetails()
                                        .statuscolor != null?
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(int.parse(
                                                  supportCenterApis
                                                      .ticketDetails()
                                                      .statuscolor!
                                                      .replaceAll("#", "0xff")))
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0, horizontal: 16),
                                          child: Text(
                                            supportCenterApis
                                                .ticketDetails()
                                                .statusName!,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Bold",
                                                color: Color(int.parse(
                                                    supportCenterApis
                                                        .ticketDetails()
                                                        .statuscolor!
                                                        .replaceAll(
                                                            "#", "0xff")))),
                                          ),
                                        ),
                                      ),
                                    ):Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey
                                              .withOpacity(0.1),
                                          borderRadius:
                                          BorderRadius.circular(100)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0, horizontal: 16),
                                          child: Text(
                                            'open',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Bold",
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 0.7,
                              ),
                              Container(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Status',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Bold",
                                            color: colorBlack.withOpacity(0.6),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        supportCenterApis
                                            .ticketDetails()
                                            .statuscolor != null?
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                      supportCenterApis
                                                          .ticketDetails()
                                                          .statuscolor!
                                                          .replaceAll(
                                                              "#", "0xff")))
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Color(int.parse(
                                                            supportCenterApis
                                                                .ticketDetails()
                                                                .statuscolor!
                                                                .replaceAll("#",
                                                                    "0xff")))
                                                        .withOpacity(1),
                                                    size: 8,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    supportCenterApis
                                                        .ticketDetails()
                                                        .statusName!,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Bold",
                                                      color: Color(int.parse(
                                                          supportCenterApis
                                                              .ticketDetails()
                                                              .statuscolor!
                                                              .replaceAll("#",
                                                                  "0xff"))),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: colorBlack
                                                        .withOpacity(0.4),
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ):SizedBox(),
                                      ],
                                    ),
                                    VerticalDivider(
                                      color: Colors.grey.shade300,
                                      thickness: 0.7,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Priority',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Bold",
                                            color: colorBlack.withOpacity(0.6),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey.shade100
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.red
                                                        .withOpacity(0.4),
                                                    size: 8,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  supportCenterApis
                                                      .ticketDetails()
                                                      .priorityName != null?
                                                  Text(
                                                    supportCenterApis
                                                        .ticketDetails()
                                                        .priorityName!,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Bold",
                                                      color: colorBlack,
                                                    ),
                                                  ):Text(
                                                    'low',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Bold",
                                                      color: colorBlack,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: colorBlack
                                                        .withOpacity(0.4),
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      color: Colors.grey.shade300,
                                      thickness: 0.7,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Department',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Bold",
                                            color: colorBlack.withOpacity(0.6),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey.shade100
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: colorBlack,
                                                    size: 8,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  supportCenterApis
                                                      .ticketDetails()
                                                      .departmentName != null?
                                                  Text(
                                                    supportCenterApis
                                                        .ticketDetails()
                                                        .departmentName!,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Bold",
                                                      color: colorBlack,
                                                    ),
                                                  ):Text(
                                                    'sales',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Bold",
                                                      color: colorBlack,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: colorBlack
                                                        .withOpacity(0.4),
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 8),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 5,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                'Ticket Message',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Bold",
                                                  color: colorBlack
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                supportCenterApis.ticketDetails().message !=null?
                                Text(
                                  supportCenterApis.ticketDetails().message!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Bold",
                                    color: colorBlack,
                                  ),
                                ):Text(
                                  'message',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Bold",
                                    color: colorBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Obx(() {
                          if (supportCenterApis.isLoading.value) {
                            return CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorOrange,
                            );
                          }
                          if (supportCenterApis
                              .ticketDetails()
                              .ticketReplies
                              .isEmpty) {
                            return SizedBox();
                          }
                          return ListView.builder(
                            itemCount: supportCenterApis
                                .ticketDetails()
                                .ticketReplies
                                .length,
                            shrinkWrap: true,
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final ticketReplies = supportCenterApis
                                  .ticketDetails()
                                  .ticketReplies[index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0,
                                                        horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      ticketReplies.submitter,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Bold",
                                                        color: colorBlack
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: SizedBox(
                                                      width: 2,
                                                    )),
                                                    Text(
                                                      getTimeAgo(
                                                          ticketReplies.date),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Bold",
                                                        color: colorBlack
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        _stripHtmlTags(ticketReplies.message!),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Bold",
                                          color: colorBlack,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      ticketReplies.attachments.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                ticketReplies.attachments.first.full_file_name,
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    );
                  }
                })),
          ),
        ),
      ),
    );
  }
}
