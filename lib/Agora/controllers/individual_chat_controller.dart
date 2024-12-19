// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:conbun_production/Views/bottomNavScreens/liveScreen/live_screen_apis.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import '../../Controllers/user_controller.dart';
// import '../../utils/constant.dart';
// import '../agora_code/agora_audio/voice_call_start.dart';
// import '../agora_code/video_call_start.dart';
// import '../agora_code/videocall_pojo.dart';
// import '../text_call_start.dart';
//
// class IndividualChatController extends GetxController {
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     getCallDetails();
//   }
//
//   @override
//   void onReady() {
//     // TODO: implement onReady
//     super.onReady();
//     getCallDetails();
//   }
//
//   UserController userController = Get.find();
//   LiveScreenApis liveScreenApis = Get.put(LiveScreenApis());
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   /// call calling or ringing
//   final _callringingornotstatus = "".obs;
//
//   String get callringingornotstatus => _callringingornotstatus.value;
//
//   set callringingornotstatus(String status) {
//     _callringingornotstatus.value = status;
//     update();
//   }
//
//   RxString liveCallId = ''.obs;
//
//   /// call active or disconnect
//   final _callactiveornotstatus = true.obs;
//
//   bool get callactiveornotstatus => _callactiveornotstatus.value;
//
//   set callactiveornotstatus(bool status) {
//     _callactiveornotstatus.value = status;
//     update();
//   }
//
//   /// audio call active or disconnect
//   final _audiocallactiveornotstatus = true.obs;
//
//   bool get audiocallactiveornotstatus => _audiocallactiveornotstatus.value;
//
//   set audiocallactiveornotstatus(bool status) {
//     _audiocallactiveornotstatus.value = status;
//     update();
//   }
//
//   /// audio call calling or ringing
//   final _audiocallringingornotstatus = "".obs;
//
//   String get audiocallringingornotstatus => _audiocallringingornotstatus.value;
//
//   set audiocallringingornotstatus(String status) {
//     _audiocallringingornotstatus.value = status;
//     update();
//   }
//
//   final _userToken = "".obs;
//
//   String get userToken => _userToken.value;
//
//   set userToken(String flag) {
//     _userToken.value = flag;
//     update();
//   }
//
//   var chatIdd = "";
//
//   String formatMillisecondsSinceEpoch(
//       {String millisecondsSinceEpochString = "1693917692239"}) {
//     // Convert the string back to an integer
//     int millisecondsSinceEpoch = int.parse(millisecondsSinceEpochString);
//
//     // Create a DateTime object from the milliseconds since epoch
//     DateTime dateTime =
//         DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
//
//     // Format the DateTime object to 'hh:mm' format
//     String formattedTime = DateFormat('HH:mm').format(dateTime);
//
//     return formattedTime;
//   }
//
//   String _formatDateTime(DateTime dateTime) {
//     final now = DateTime.now();
//     if (dateTime.day == now.day &&
//         dateTime.month == now.month &&
//         dateTime.year == now.year) {
//       final format = DateFormat.jm();
//       return format.format(dateTime);
//     } else if (dateTime.year == now.year) {
//       final format = DateFormat('MMM d');
//       return format.format(dateTime);
//     } else {
//       final format = DateFormat('MMM d, y');
//       return format.format(dateTime);
//     }
//   }
//
//   ///agora setup start form here==============.
//   Future<void> makeCall(
//       channelName,
//       userId,
//       fname,
//       imageUrl,
//       lname,
//       token,
//       consultantId,
//       appointmentDate,
//       appointmentTime,
//       duration,
//       appointmentId,
//       isLive) async {
//     print("MAKE CALL RUNNING HERE");
//     print(token);
//     await fetchDataforcreater(
//         channelName,
//         userId,
//         fname,
//         imageUrl,
//         lname,
//         "video",
//         duration,
//         appointmentId,
//         isLive,
//         consultantId,
//         appointmentDate,
//         appointmentTime);
//     await getFirebaseTokenforcall(
//         userId,
//         channelName,
//         fname,
//         imageUrl,
//         "video",
//         true,
//         false,
//         token,
//         false,
//         appointmentId,
//         duration,
//         isLive,
//         appointmentDate,
//         consultantId);
//   }
//
//   void makeTextCall(
//       channelName,
//       userId,
//       fname,
//       imageUrl,
//       channelId,
//       lname,
//       token,
//       consultantId,
//       appointmentDate,
//       appointmentTime,
//       duration,
//       appointmentId) async {
//     print("Text Call RUNNING HERE");
//     print(token);
//     // var userlist = [];
//     // userlist.add(userId);
//     //
//     // userlist.add(userController.userData().id);
//     // userlist.sort();
//     // print(userlist.join('-'));
//     // Map<String, dynamic> userData = {
//     //   "receiverid": userId,
//     //   "receiverfname": fname,
//     //   "receiverlname": lname,
//     //   "receiverimage": imageUrl,
//     //   "sendername": userController.userData().name,
//     //   "senderimage": userController.userData().profileImage,
//     //   "senderid": userController.userData().id,
//     //   "channelid": channelName,
//     //   'commonusers': [userId, userController.userData().id],
//     //   'activecall': true,
//     //   'callingstatus': "calling",
//     //   'calldisconnectby': '',
//     // };
//     // await FirebaseFirestore.instance
//     //     .collection('Text')
//     //     .doc(userlist.join('-'))
//     //     .set(userData);
//     print("Text Call CREATED HEREEE ${channelName}");
//     await fetchDataforcreater(channelName, userId, fname, imageUrl, lname,
//         "text", duration, appointmentId, false, consultantId, appointmentDate,appointmentTime);
//     await getFirebaseTokenforcall(
//         userId,
//         channelName,
//         fname,
//         imageUrl,
//         "text",
//         false,
//         false,
//         token,
//         true,
//         appointmentId,
//         duration,
//         false,
//         appointmentDate,
//         consultantId);
//   }
//
//   ///call ring ho raha ya nahi ye update krne k liye
//   callringingornot(callid) async {
//     Map<String, dynamic> userData = {
//       'callingstatus': "ringing",
//     };
//     await FirebaseFirestore.instance
//         .collection('Videocall')
//         .doc(callid)
//         .update(userData);
//   }
//
//   // ///call disconnect
//   // leaveDisconnectCall(userId, context) async {
//   //   Map<String, dynamic> userData = {
//   //     'activecall': false,
//   //     'calldisconnectby': FirebaseAuth.instance.currentUser!
//   //   };
//   //   await FirebaseFirestore.instance
//   //       .collection('Videocall')
//   //       .doc(userId)
//   //       .update(userData);
//   //   Navigator.pop(context);
//   // }
//   fetchDataforcreater(
//       channelName,
//       userId,
//       name,
//       imageUrl,
//       lname,
//       calltype,
//       appointmentDuration,
//       appointmentId,
//       isLive,
//       consultantId,
//       appointmentDate,
//       appointmentTime) async {
//     try {
//       print('fetchDataForcast');
//       String url =
//           'https://agoratokensrrver.onrender.com/rtcToken?channelName=$channelName';
//
//       // Make the HTTP POST request
//       final response = await http.get(Uri.parse(url));
//       // Check if the request was successful (status code 200)
//       print(response.body.toString());
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         // Access the data field
//         String token = responseData['token'];
//         print('Token---------------${token}');
//         if (calltype == "video") {
//           if (isLive) {
//             print('object');
//             liveCallId.value = '';
//             String endTime = await liveScreenApis.getEndTime(
//                 liveScreenApis.startTime.value,
//                 Duration(minutes: int.parse(appointmentDuration)));
//             print('object');
//             final response = await liveScreenApis.createAppointment(
//               consultantId,
//               userId,
//               appointmentId,
//               appointmentDate,
//               appointmentTime,
//               endTime,
//               responseData['token'],
//               channelName,
//             );
//             print('object');
//             liveCallId.value = await response['data']['id'];
//             print('object');
//             Get.to(() => VideoCallScreen(
//                   imageUrl: imageUrl,
//                   fname: name,
//                   lname: lname,
//                   userId: userId,
//                   receivecall: true,
//                   channelId: channelName,
//                   agoratoken: responseData['token'],
//                   appointmentDuration: appointmentDuration,
//                   appointmentId: appointmentId,
//                   isLive: isLive,
//                   consultantId: consultantId,
//                   appointmentDate: appointmentDate,
//                 ));
//           } else {
//             Get.to(() => VideoCallScreen(
//                   imageUrl: imageUrl,
//                   fname: name,
//                   lname: lname,
//                   userId: userId,
//                   receivecall: true,
//                   channelId: channelName,
//                   agoratoken: responseData['token'],
//                   appointmentDuration: appointmentDuration,
//                   appointmentId: appointmentId,
//                   isLive: isLive,
//                   consultantId: consultantId,
//                   appointmentDate: appointmentDate,
//                 ));
//           }
//         } else if (calltype == "text") {
//           Get.to(TextCallScreen(
//             imageUrl: imageUrl,
//             fname: name,
//             lname: lname,
//             userId: userId,
//             receivecall: true,
//             channelId: channelName,
//             agoratoken: responseData['token'],
//             appointmentDuration: appointmentDuration,
//             appointmentId: appointmentId,
//           ));
//         } else {
//           Get.to(VoiceCallScrenn(
//             imageUrl: imageUrl,
//             fname: name,
//             lname: lname,
//             userId: userId,
//             receivecall: true,
//             channelId: channelName,
//             agoratoken: responseData['token'],
//             appointmentDuration: appointmentDuration,
//             appointmentId: appointmentId,
//           ));
//         }
//       }
//     } catch (e) {
//       print('Cztech error ${e.toString()}');
//     }
//   }
//
//   Future<String> getFirebaseTokenforcall(
//       userID,
//       channelidd,
//       name,
//       imageUrl,
//       calltype,
//       isvideocall,
//       isvoicecall,
//       tokenn,
//       isText,
//       appointmentId,
//       duration,
//       isLive,
//       appointmentDate,
//       consultantId) async {
//     try {
//       ///Change to Api Call
//       await sendNotificationToSelectedDriver(
//           "Video Call",
//           channelidd,
//           tokenn,
//           userID,
//           name,
//           imageUrl,
//           calltype,
//           isvideocall,
//           isvoicecall,
//           isText,
//           appointmentId,
//           duration,
//           isLive,
//           appointmentDate,
//           consultantId);
//       return '';
//     } catch (e) {
//       print('Error retrieving data: $e');
//       return 'Error retrieving data: $e';
//     }
//   }
//
//   static Future<String> getAccessToken() async {
//     final serviceAccountJson = {
//       "type": "service_account",
//       "project_id": "conbun829",
//       "private_key_id": "6282a26892c97e1296b159530a5daf615080753a",
//       "private_key":
//           "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDjKcT8TiZJsuW9\nVXdJ0KibSSfM15A/BYJ4bomTJY5ZQJmWOZ/5FtVCqjerdcqgQdgFIl7tUnk8NDuP\nQqdYlbikbMxIDnUQ4dHHClTpAz3hLtDxpxvmQqqP1QpjHed2OCU5WkcMof5+FtJ6\nGtdnswp79FsXNEz/VUIZi3+hl6uTpGNMn9WJmD5/JrWT2lmsC5DqOPobcrIaJcXH\nmrC4mq28+AkRsGn6bXauyM3dPU77GZkc/ccohHdJaoT8jmTgF6qlebmB/hJdpI2h\nFfq5OmWJ6Kg2idTOOVS3RxTjzXnuh7UZlzRzhpj8TSHnKoeu2qAoA5gO7nq21QTn\nhdkY7Jy/AgMBAAECggEAB0L7kBEzeiGk5HOJ96sa6LPi+NJfQxR7AjyOW0zVCxdc\nkYfQDFdlg9cLJokCbDMOo8Ngg3eidoE48jBwRw2qNF9h/F+x8FM3sIQtCLHY1Yz4\nkvEDnE2/RA/MYDTBhG7xCa9QHCBFkWRLYCnhfugjSqkaDFjYqUThcw2Zi+HcU0Db\nnCBIHO3NRgkQbUcm9FYJDtUKj8DFGLGZya1y5uf6c5SMotfH+4+NzCZN6gNxMe4c\nP9mzWbz3Mkbjp3y3qzCDJeUC/K2s0TQOngi/J/IwinhV2LiahezDkQaQnZcbIg5Z\nw7xRzgcmrHD2UJ3/MMb+wnMeEwUeWPWYOYB8smK3gQKBgQD1qku+BcyMmbCwupEM\nbVE9Tc1eZED9jHbzxGKX3BEq2yqez35+UdOUDdOD6n6z6hWPOIdREWCZcgi2nseA\nx0zCWjRyqG7F6B3/qPi7482Q2vQ4F4coVkF72P4CYTjkH7M8zE41VkPB1bk8sr/W\nWuWsTfmxY5gyYW6cdSNUEbL8fwKBgQDsuDb65TIxPoAazVzTHKLwZ39bGWYlSI6f\nwZI07FClhHHdMmF52kTqXQFBmZ7PMtOgkIU48F2NClPDFAwoK9VAtsiHh3xMOsPL\n6Ui5T7NmgSWFnuTzRw4G1vAJFQFAQEppI5srD/J43YyX6AGgvKfnVVli7O685hY5\nolIfAqc/wQKBgQDXnQ+9R/mvrXSWqCiGb6vN0mtdXUBtSMteSA8AmfW3V4SgvhyX\nYdoBJ+Fs9nMeFWW2vjaFwGq4Qo3DOrh/Hm0QZ3uA5rPSn1c0/GjS/618Za/TS1Mk\n5A+1U04daJc2IVx/EBHUXlI53gsmavxUdpL+F7H/Lxp1nW4ng+ft8VrWoQKBgQCX\nLiM24y/GEXOBKozQ6yYIwSCuDq+Uuh0UXGzCzfXHb6nEqgtk5ghDYTiPK8wn6f8M\nOaBLt/8XN3Q9T01gTnY4iUPSgq3YhWNMlGV0rDkYCvzqtIrl8Ag+SAEu27Jb1XNw\naGQOAXZKyLukvHBltnbJIFIhAs6J56xkDI3D7k7gQQKBgQDk1E1+UwlASuFxQdDK\nalY9NkZcgsMUcpoT7WdvOO9oRHKh4TIHG5aLN03jpw+9ire7wehlcM+iSlBlc9rx\nAH61arZ7HD3wFHB6TcDsCSUrd5IvqkjORxHa/X07N1V1iw7c+CzH0Iz+J0DWsmxx\ndbsOW65sPj6bWQz4Ux9a56A/vg==\n-----END PRIVATE KEY-----\n",
//       "client_email": "notification@conbun829.iam.gserviceaccount.com",
//       "client_id": "105575163877221166296",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url":
//           "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url":
//           "https://www.googleapis.com/robot/v1/metadata/x509/notification%40conbun829.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     };
//     List<String> scopes = [
//       "https://www.googleapis.com/auth/userinfo.email",
//       "https://www.googleapis.com/auth/firebase.database",
//       "https://www.googleapis.com/auth/firebase.messaging"
//     ];
//
//     http.Client client = await auth.clientViaServiceAccount(
//       auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//       scopes,
//     );
//     // get the access token
//     auth.AccessCredentials credentials =
//         await auth.obtainAccessCredentialsViaServiceAccount(
//             auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//             scopes,
//             client);
//     client.close();
//     return credentials.accessToken.data;
//   }
//
//   Future<void> sendNotificationToSelectedDriver(
//       messagee,
//       channelid,
//       token,
//       userID,
//       name,
//       imageUrl,
//       calltype,
//       isvideocall,
//       isvoicecall,
//       isText,
//       appointmentId,
//       duration,
//       isLive,
//       appointmentDate,
//       consultantId) async {
//     final String serverAccessTokenKey = await getAccessToken();
//     String endpointFirebaseCloudMessaging =
//         'https://fcm.googleapis.com/v1/projects/conbun829/messages:send';
//     final Map<String, dynamic> message = {
//       'message': {
//         'token': token,
//         'notification': {
//           'title': "Agora ${isLive ? 'Live': 'Not Live'}",
//           'body': "Join with Consultant",
//         },
//         "android": {
//           "priority": "high",
//           "notification": {
//             "click_action": "FLUTTER_NOTIFICATION_CLICK",
//             "channel_id": "consult",
//             "sound": "ringtone",
//           }
//         },
//         "data": {
//           "title": "Consultant",
//           "body": messagee,
//           "custom_key": "videocall",
//           "videocall": isvideocall.toString(),
//           "voicecall": isvoicecall.toString(),
//           "textcall": isText.toString(),
//           "channelid": channelid,
//           "userid": userController.userData().id,
//           "receiverid": userID,
//           "fname": userController.userData().name,
//           "lname": userController.userData().name,
//           "imageurl": userController.userData().profileImage,
//           "calltype": calltype,
//           "appointmentId": appointmentId,
//           "duration": duration,
//           "isLive": isLive.toString(),
//           "appointmentDate": appointmentDate,
//           "consultantId": consultantId,
//           "liveCallId": liveCallId.value,
//         },
//       }
//     };
//
//     final http.Response response = await http.post(
//       Uri.parse(endpointFirebaseCloudMessaging),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $serverAccessTokenKey'
//       },
//       body: jsonEncode(message),
//     );
//
//     if (response.statusCode == 200) {
//       print('Notification Sent');
//       // final audioPlayer = AudioPlayer();
//       // await audioPlayer.play(AssetSource('assets/tunes/ringtone.mp3'));
//     } else {
//       print('Notification Failed ${response.body}');
//     }
//   }
//
//   Future<void> getCallDetails() async {
//     var chatsCollection = FirebaseFirestore.instance
//         .collection('Videocall')
//         .where('commonusers', arrayContains: userController.userData().id)
//         .where('activecall', isEqualTo: true);
//     Stream<QuerySnapshot> chatStream = chatsCollection.snapshots();
//
//     chatStream.listen((QuerySnapshot chatQuerySnapshot) {
//       if (chatQuerySnapshot.docs.isEmpty) {
//         // No documents found
//         print("No active calls found");
//         _callactiveornotstatus(false);
//         _callringingornotstatus("");
//       } else {
//         for (QueryDocumentSnapshot document in chatQuerySnapshot.docs) {
//           Map<String, dynamic> chatData =
//               document.data() as Map<String, dynamic>;
//           VideoCallData videoCallData = VideoCallData.fromMap(chatData);
//           print("CALL STATUS RUNNING");
//           print(videoCallData.channelId);
//           print(videoCallData.receiverfname);
//           print(videoCallData.senderName);
//           print(videoCallData.activeCall);
//           _callactiveornotstatus(videoCallData.activeCall);
//           _callringingornotstatus(videoCallData.callingstatus);
//           update();
//         }
//       }
//     });
//   }
//
//   ///agora audio call------------------audio call-----------------------audio call------------
//   void makeAudioCall(
//       channelName,
//       userId,
//       fname,
//       imageUrl,
//       channelId,
//       context,
//       lname,
//       token,
//       consultantId,
//       appointmentDate,
//       appointmentTime,
//       duration,
//       appointmentId) async {
//     print("MAKE CALL RUNNING HERE");
//
//     // var userlist = [];
//     // userlist.add(userId);
//     // userlist.add(userController.userData().id);
//     // userlist.sort();
//     // print(userlist.join('-'));
//     // Map<String, dynamic> userData = {
//     //   "receiverid": userId,
//     //   "receiverfname": fname,
//     //   "receiverlname": lname,
//     //   "receiverimage": imageUrl,
//     //   "sendername": "Shantanu Singh",
//     //   "senderimage": imageUrl,
//     //   "senderid": userController.userData().id,
//     //   "channelid": channelId,
//     //   'commonusers': [userId, userController.userData().id],
//     //   'activecall': true,
//     //   'callingstatus': "calling",
//     //   'calldisconnectby': '',
//     // };
//     // await FirebaseFirestore.instance
//     //     .collection('Audiocall')
//     //     .doc(userlist.join('-'))
//     //     .set(userData);
//     print("CHAT CREATED HEREEE ${channelId}");
//     await fetchDataforcreater(channelName, userId, fname, imageUrl, lname,
//         "audio", duration, appointmentId, false, consultantId, appointmentDate,appointmentTime);
//     getFirebaseTokenforcall(
//         userId,
//         channelId,
//         fname,
//         imageUrl,
//         "audio",
//         false,
//         true,
//         token,
//         false,
//         appointmentId,
//         duration,
//         false,
//         appointmentDate,
//         consultantId);
//   }
//
//   Future<void> getAudioCallDetails(String userId) async {
//     var chatsCollection = FirebaseFirestore.instance
//         .collection('Audiocall')
//         .where('commonusers', arrayContains: userId)
//         .where('activecall', isEqualTo: true);
//     Stream<QuerySnapshot> chatStream = chatsCollection.snapshots();
//
//     chatStream.listen((QuerySnapshot chatQuerySnapshot) {
//       if (chatQuerySnapshot.docs.isEmpty) {
//         // No documents found
//         print("No active calls found");
//         _audiocallactiveornotstatus(false);
//         _audiocallringingornotstatus("");
//       } else {
//         for (QueryDocumentSnapshot document in chatQuerySnapshot.docs) {
//           Map<String, dynamic> chatData =
//               document.data() as Map<String, dynamic>;
//           VideoCallData videoCallData = VideoCallData.fromMap(chatData);
//           print("CALL STATUS RUNNING");
//           print(videoCallData.channelId);
//           print(videoCallData.receiverfname);
//           print(videoCallData.senderName);
//           print(videoCallData.activeCall);
//           _audiocallactiveornotstatus(videoCallData.activeCall);
//           _audiocallringingornotstatus(videoCallData.callingstatus);
//           update();
//         }
//       }
//     });
//   }
//
//   Future<void> getTextCallDetails(String userId) async {
//     var chatsCollection = FirebaseFirestore.instance
//         .collection('Text')
//         .where('commonusers', arrayContains: userId)
//         .where('activecall', isEqualTo: true);
//     Stream<QuerySnapshot> chatStream = chatsCollection.snapshots();
//
//     chatStream.listen((QuerySnapshot chatQuerySnapshot) {
//       if (chatQuerySnapshot.docs.isEmpty) {
//         // No documents found
//         print("No active calls found");
//         _audiocallactiveornotstatus(false);
//         _audiocallringingornotstatus("");
//       } else {
//         for (QueryDocumentSnapshot document in chatQuerySnapshot.docs) {
//           Map<String, dynamic> chatData =
//               document.data() as Map<String, dynamic>;
//           VideoCallData videoCallData = VideoCallData.fromMap(chatData);
//           print("CALL STATUS RUNNING");
//           print(videoCallData.channelId);
//           print(videoCallData.receiverfname);
//           print(videoCallData.senderName);
//           print(videoCallData.activeCall);
//           _audiocallactiveornotstatus(videoCallData.activeCall);
//           _audiocallringingornotstatus(videoCallData.callingstatus);
//           update();
//         }
//       }
//     });
//   }
//
//   audiocallringingornot(callid) async {
//     Map<String, dynamic> userData = {
//       'callingstatus': "ringing",
//     };
//     await FirebaseFirestore.instance
//         .collection('Audiocall')
//         .doc(callid)
//         .update(userData);
//   }
//
//   // Future updateLiveCallStatus(
//   //     String liveCallId,
//   //     String status,
//   //     ) async {
//   //   final requestBody = {
//   //     'livecallid': liveCallId,
//   //     'status': status,
//   //   };
//   //   final String requestBodyJson = jsonEncode(requestBody);
//   //
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse('${Constant.baseUrl}api/livecall/updateStatus'),
//   //       headers: <String, String>{
//   //         'Content-Type': 'application/json',
//   //         'authtoken': Constant.authToken
//   //       },
//   //       body: requestBodyJson,
//   //     );
//   //     Map<String, dynamic> responseBody = json.decode(response.body);
//   //     if (response.statusCode == 200) {
//   //
//   //       return responseBody;
//   //     } else {
//   //
//   //       return responseBody;
//   //     }
//   //   } catch (e) {
//   //
//   //     return "An error occurred: $e";
//   //   }
//   // }
// }
