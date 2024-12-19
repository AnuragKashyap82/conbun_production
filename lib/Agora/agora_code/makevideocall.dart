// import 'dart:convert';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:conbun_production/Agora/agora_code/video_call_start.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../Views/bottomNavScreens/bottomNavScreen.dart';
// import '../../utils/colors.dart';
// import '../controllers/individual_chat_controller.dart';
//
// class CallReceiveScreen extends StatefulWidget {
//   final String fname;
//   final String imageUrl;
//   final String userId;
//   final bool receivecall;
//   final String channelId;
//   final String lname;
//   final String receiverid;
//   final String appointmentDuration;
//   final String appointmentId;
//   final bool isLive;
//   final String appointmentDate;
//   final String consultantId;
//
//
//   CallReceiveScreen(
//       {required this.fname,
//       required this.imageUrl,
//       required this.userId,
//       required this.receivecall,
//       required this.channelId,
//       required this.lname,
//       required this.receiverid, required this.appointmentDuration, required this.appointmentId, required this.isLive, required this.appointmentDate, required this.consultantId});
//
//   @override
//   State<CallReceiveScreen> createState() => _CallReceiveScreenState();
// }
//
// class _CallReceiveScreenState extends State<CallReceiveScreen> {
//   var userToken = "";
//   var controller = Get.find<IndividualChatController>();
//
//   final audioPlayer = AudioPlayer();
//
//   // void fetchDatareceiver(channelName, consultantId, appointmentDate,
//   //     appointmentTime, userId) async {
//   //   // URL and request body
//   //   const String url =
//   //       'https://api.vegansmeetdaily.com/api/v1/users/create_agora_token';
//   //   final Map<String, String> body = {
//   //     'channel_name': channelName,
//   //     'appId': '2b0bdd0de9f14d84bcff8fb037e452c3',
//   //     'appCertificate': '18aaec564fbb4443a8d1f5d8345f205a',
//   //   };
//   //
//   //   // Make the HTTP POST request
//   //   final response = await http.post(Uri.parse(url), body: body);
//   //
//   //   // Check if the request was successful (status code 200)
//   //   if (response.statusCode == 200) {
//   //     // Parse the JSON response
//   //     final Map<String, dynamic> responseData = json.decode(response.body);
//   //
//   //     // Access the data field
//   //     String token = responseData['data'];
//   //     if (response.statusCode == 200) {
//   //       // Parse the JSON response
//   //       final Map<String, dynamic> responseData = json.decode(response.body);
//   //       // Access the data field
//   //       String token = responseData['data'];
//   //       setState(() {
//   //         userToken = responseData['data'];
//   //       });
//   //       // Handle the token as needed
//   //       print('Token: $token');
//   //     } else {
//   //       // Handle errors
//   //       print('Error: ${response.statusCode} - ${response.reasonPhrase}');
//   //     }
//   //   }
//   // }
//   void fetchDatareceiver(channelName, consultantId, appointmentDate,
//       appointmentTime, userId) async {
//     print('dataforcaste');
//     // URL and request body
//     String url =
//         'https://agoratokensrrver.onrender.com/rtcToken?channelName=$channelName';
//     try{
//       // Make the HTTP POST request
//       final response = await http.get(Uri.parse(url));
//
//       // Check if the request was successful (status code 200)
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         print('respionseBody: ${responseData}');
//         // Access the data field
//         String token = responseData['token'];
//         print('token---------$token');
//         if (response.statusCode == 200) {
//           // Parse the JSON response
//           final Map<String, dynamic> responseData = json.decode(response.body);
//           // Access the data field
//           String token = responseData['token'];
//           setState(() {
//             userToken = responseData['token'];
//           });
//           print('token---------$token');
//           // Handle the token as needed
//           print('Token: $token');
//         } else {
//           // Handle errors
//           print('Error: ${response.statusCode} - ${response.reasonPhrase}');
//         }
//       }
//     }catch(e){
//       print('Catch error ${e.toString()}');
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     audioPlayer.play(AssetSource('tunes/ringtone.mp3'));
//     fetchDatareceiver(widget.channelId, widget.userId, "appointmentDate",
//         "appointmentTime", widget.receiverid);
//     controller.getCallDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorBackground,
//       body: GetBuilder<IndividualChatController>(builder: (controller) {
//         return Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.network(
//               widget.imageUrl,
//               fit: BoxFit.cover,
//             ),
//             Container(
//               color: Colors.black.withOpacity(0.5),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 60.0),
//                 Text(
//                   'Incoming Video Call',
//                   style: TextStyle(
//                     color: Colors.grey.shade300,
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8.0),
//                 Text(
//                   '${widget.fname}',
//                   style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade300,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Expanded(child: const SizedBox(height: 40.0)),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.grey.shade300),
//                       child: Center(
//                         child: IconButton(
//                           icon: const Icon(
//                             Icons.call_end,
//                             color: Colors.red,
//                             size: 24.0,
//                           ),
//                           onPressed: () async {
//                             await audioPlayer.stop();
//                             Get.offAll(BottomNavScreen(currentTab: 0));
//                           },
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.grey.shade300),
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.videocam_outlined,
//                           color: Colors.green,
//                           size: 24.0,
//                         ),
//                         onPressed: () async {
//                           // Add logic for accepting the call
//                           await audioPlayer.stop();
//                           Get.offAll(VideoCallScreen(
//                             imageUrl: widget.imageUrl,
//                             fname: widget.fname,
//                             userId: widget.userId,
//                             receivecall: true,
//                             channelId: widget.channelId,
//                             agoratoken: userToken,
//                             lname: '',
//                             appointmentId: widget.appointmentId,
//                             appointmentDuration: widget.appointmentDuration,
//                             isLive: widget.isLive,
//                             appointmentDate: widget.appointmentDate, consultantId: widget.consultantId,
//                           ));
//                           print('Call Accepted');
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 80.0)
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         );
//       }),
//     );
//   }
// }
