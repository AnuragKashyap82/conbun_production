import 'package:conbun_production/Models/support_ticket_model.dart';
import 'package:conbun_production/Views/supportCenter/support_details_screen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';

class TicketWidget extends StatefulWidget {
  final SupportTicketModel supportTicketModel;

  const TicketWidget({super.key, required this.supportTicketModel});

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
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
  Widget build(BuildContext context) {
    print(widget.supportTicketModel.date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SupportDetailsScreen(
                        ticketId: widget.supportTicketModel.ticketId,
                    subject: widget.supportTicketModel.subject,
                      )));
        },
        child:
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            color: colorWhite,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  widget.supportTicketModel.subject,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Bold",
                    color: colorBlack,
                  ),
                  maxLines: 1,
                ),
                trailing: Text(
                  getTimeAgo(widget.supportTicketModel.date),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "SemiBold",
                    color: colorBlack.withOpacity(0.6),
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                  child: Text(
                    widget.supportTicketModel.message,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Regular",
                      color: colorBlack.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              widget.supportTicketModel.statusColor
                                  .replaceAll("#", "0xff"),
                            ),
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 16),
                          child: Text(
                            widget.supportTicketModel.statusName,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Bold",
                              color:
                                  widget.supportTicketModel.statusName == 'New'
                                      ? Color(0xff074708)
                                      : Color(0xff134c6a),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color:
                              widget.supportTicketModel.priorityName == 'High'
                                  ? Colors.red.withOpacity(0.05)
                                  : Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: widget.supportTicketModel.priorityName ==
                                        'High'
                                    ? Color(0xffb51d14)
                                    : Color(0xff1f7b9e),
                                size: 8,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${widget.supportTicketModel.priorityName} Priority',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Bold",
                                  color:
                                      widget.supportTicketModel.priorityName ==
                                              'High'
                                          ? Color(0xffb51d14)
                                          : Color(0xff1f7b9e),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8),
                          child: Text(
                            '${widget.supportTicketModel.departmentName} Department',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Bold",
                              color: Color(0xffb51d14),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
