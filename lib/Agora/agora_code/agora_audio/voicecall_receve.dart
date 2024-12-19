// import 'dart:convert';
// import 'package:conbun_production/Agora/agora_code/agora_audio/voice_call_start.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../../Views/bottomNavScreens/bottomNavScreen.dart';
// import '../../../utils/colors.dart';
// import '../../controllers/individual_chat_controller.dart';
//
// class MakeVoiceCall extends StatefulWidget {
//   final String fname;
//   final String imageUrl;
//   final String userId;
//   final bool receivecall;
//   final String channelId;
//   final String lname;
//   final String receiverid;
//   final String appointmentDuration;
//   final String appointmentId;
//
//   MakeVoiceCall(
//       {required this.fname,
//         required this.imageUrl,
//         required this.userId,
//         required this.receivecall,
//         required this.channelId,
//         required this.lname,
//         required this.receiverid, required this.appointmentDuration, required this.appointmentId});
//
//   @override
//   State<MakeVoiceCall> createState() => _MakeVoiceCallState();
// }
//
// class _MakeVoiceCallState extends State<MakeVoiceCall> {
//   var userToken = "";
//   var controller = Get.put(IndividualChatController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchDatareceiver(widget.channelId, widget.userId, "appointmentDate", "appointmentTime",  widget.receiverid);
//     controller.getAudioCallDetails(widget.userId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorBackground,
//       body: GetBuilder<IndividualChatController>(builder: (controller) {
//         return
//           Stack(
//             fit: StackFit.expand,
//             children: [
//               Image.network(
//                   '${widget.imageUrl}', // Replace with your image URL
//                 fit: BoxFit.cover,
//                 errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                   return SizedBox();
//                 },
//               ),
//               Container(
//                 color: Colors.black.withOpacity(0.5),
//               ),
//               // controller.audiocallactiveornotstatus == true
//               //     ? Column(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   crossAxisAlignment: CrossAxisAlignment.center,
//               //   children: [
//               //     const SizedBox(height: 60.0),
//               //     Text(
//               //       'Incoming Voice Call',
//               //       style: TextStyle(
//               //         color: Colors.grey.shade300,
//               //         fontSize: 18.0,
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //     const SizedBox(height: 8.0),
//               //     Text(
//               //       '${widget.fname} ${widget.lname}',
//               //       style:
//               //       TextStyle(fontSize: 16, color: Colors.grey.shade300, fontWeight: FontWeight.bold),
//               //     ),
//               //     Expanded(child: const SizedBox(height: 40.0)),
//               //     Row(
//               //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //       children: [
//               //
//               //         Container(
//               //           height: 60,
//               //           width: 60,
//               //           decoration: BoxDecoration(
//               //               shape: BoxShape.circle,
//               //               color: Colors.grey.shade300
//               //           ),
//               //           child: IconButton(
//               //             icon: const Icon(
//               //               Icons.call_end,
//               //               color: Colors.red,
//               //               size: 24.0,
//               //             ),
//               //             onPressed: () {
//               //               // var userlist = [widget.receiverid, widget.userId]..sort();
//               //               // var userJoin = userlist.join('-');
//               //               // print(
//               //               //     "AT DISCONNECT CALLING STATEUS ${userJoin}");
//               //               // var myController =
//               //               // Get.isRegistered<IndividualChatController>()
//               //               //     ? Get.find<IndividualChatController>()
//               //               //     : Get.put(IndividualChatController());
//               //               // myController.leaveDisconnectCall(userJoin,context);
//               //               Get.off(BottomNavScreen(currentTab: 0));
//               //             },
//               //           ),
//               //         ),
//               //         Container(
//               //           height: 60,
//               //           width: 60,
//               //           decoration: BoxDecoration(
//               //               shape: BoxShape.circle,
//               //               color: Colors.grey.shade300
//               //           ),
//               //           child: IconButton(
//               //             icon: const Icon(
//               //               Icons.call,
//               //               color: Colors.green,
//               //               size: 24.0,
//               //             ),
//               //             onPressed: () {
//               //               // Add logic for accepting the call
//               //               print("GETTNG CHANNEL ID IS ${widget.channelId}");
//               //               print(
//               //                   "GETTING TOKEN WITH CHANNER ${widget.channelId} and token is ${userToken}");
//               //
//               //               Get.to(VoiceCallScrenn(
//               //                   imageUrl: widget.imageUrl,
//               //                   fname: widget.fname,
//               //                   userId: widget.userId,
//               //                   receivecall: true,
//               //                   channelId: widget.channelId,
//               //                   agoratoken: userToken,
//               //                   lname: ''));
//               //               print('Call Accepted');
//               //             },
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //     SizedBox(height: 80.0)
//               //   ],
//               // )
//               //     : const Center(
//               //   child: Text(
//               //     "Call disconnect",
//               //     style: TextStyle(color: Colors.black, fontSize: 12.0),
//               //   ),
//               // ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 60.0),
//                   Text(
//                     'Incoming Voice Call',
//                     style: TextStyle(
//                       color: Colors.grey.shade300,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     '${widget.fname}',
//                     style:
//                     TextStyle(fontSize: 16, color: Colors.grey.shade300, fontWeight: FontWeight.bold),
//                   ),
//                   Expanded(child: const SizedBox(height: 40.0)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//
//                       Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.grey.shade300
//                         ),
//                         child: IconButton(
//                           icon: const Icon(
//                             Icons.call_end,
//                             color: Colors.red,
//                             size: 24.0,
//                           ),
//                           onPressed: () {
//                             // var userlist = [widget.receiverid, widget.userId]..sort();
//                             // var userJoin = userlist.join('-');
//                             // print(
//                             //     "AT DISCONNECT CALLING STATEUS ${userJoin}");
//                             // var myController =
//                             // Get.isRegistered<IndividualChatController>()
//                             //     ? Get.find<IndividualChatController>()
//                             //     : Get.put(IndividualChatController());
//                             // myController.leaveDisconnectCall(userJoin,context);
//                             Get.off(BottomNavScreen(currentTab: 0));
//                           },
//                         ),
//                       ),
//                       Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.grey.shade300
//                         ),
//                         child: IconButton(
//                           icon: const Icon(
//                             Icons.call,
//                             color: Colors.green,
//                             size: 24.0,
//                           ),
//                           onPressed: () {
//                             // Add logic for accepting the call
//                             print("GETTNG CHANNEL ID IS ${widget.channelId}");
//                             print(
//                                 "GETTING TOKEN WITH CHANNER ${widget.channelId} and token is ${userToken}");
//
//                             Get.to(VoiceCallScrenn(
//                                 imageUrl: widget.imageUrl,
//                                 fname: widget.fname,
//                                 userId: widget.userId,
//                                 receivecall: true,
//                                 channelId: widget.channelId,
//                                 agoratoken: userToken,
//                                 lname: '',
//                               appointmentDuration: widget.appointmentDuration,
//                               appointmentId: widget.appointmentId,
//                             ));
//                             print('Call Accepted');
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 80.0)
//                 ],
//               )
//             ],
//           );
//       }),
//     );
//   }
//
//
//   void fetchDatareceiver(channelName,consultantId, appointmentDate, appointmentTime, userId) async {
//     // URL and request body
//      String url =
//         'https://agoratokensrrver.onrender.com/rtcToken?channelName=$channelName';
//
//     // Make the HTTP POST request
//     final response = await http.get(Uri.parse(url));
//
//     // Check if the request was successful (status code 200)
//     if (response.statusCode == 200) {
//       // Parse the JSON response
//       final Map<String, dynamic> responseData = json.decode(response.body);
//
//       // Access the data field
//       String token = responseData['token'];
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         // Access the data field
//         String token = responseData['token'];
//         setState(() {
//           userToken = responseData['token'];
//         });
//         // Handle the token as needed
//         print('Token: $token');
//       }
//       else {
//         // Handle errors
//         print('Error: ${response.statusCode} - ${response.reasonPhrase}');
//       }
//     }
//   }
// }
