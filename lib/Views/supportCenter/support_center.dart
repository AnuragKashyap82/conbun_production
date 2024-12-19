import 'package:conbun_production/Views/supportCenter/add_ticket_screen.dart';
import 'package:conbun_production/Views/supportCenter/widget/ticket_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../Controllers/support_ticket_controller.dart';
import '../../utils/colors.dart';

class SupportCenter extends StatefulWidget {
  const SupportCenter({super.key});

  @override
  State<SupportCenter> createState() => _SupportCenterState();
}

class _SupportCenterState extends State<SupportCenter> {
  SupportTicketController supportTicketController = Get.put(SupportTicketController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
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
              "Support Center",
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
                child: Icon(
                  Icons.arrow_back,
                  color: colorViolet,
                  size: 20,
                )),
            actions: [
              IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> AddTicketsScreen()));
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: colorOrange,
                  ))
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await supportTicketController.fetchAllTickets();
        },
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Obx(() {
                  if (supportTicketController.isLoading.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 100,
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          ShimmerEffect(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 100,
                              )),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    );
                  }
                  if (supportTicketController.allTickets.isEmpty) {
                    return Transform.scale(
                      scale: 0.5,
                      child : Lottie.asset(
                        'assets/lottie/noData.json',
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: supportTicketController.allTickets.length,
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final supportTicket = supportTicketController.allTickets[index];
                      return TicketWidget(supportTicketModel: supportTicket);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
