import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../Controllers/appointments_controller.dart';
import '../Views/call_notification_screen.dart';

// final audioPlayer = AudioPlayer();
Future<void> handleBackgroundMessage(RemoteMessage? message) async {
  if (message == null) return;

  // await audioPlayer.play(AssetSource('tunes/ringtone.mp3'));
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices().initLocalNotification();
  NotificationServices().initNotification();
  NotificationServices().initPushNotification();

  // Extract relevant data from the message
  Map<String, dynamic> data = message.data;
  bool videocall = data['videocall'] == 'true';
  bool voicecall = data['voicecall'] == 'true';
  bool textcall = data['textcall'] == 'true';

  if (videocall || voicecall || textcall) {
    if (videocall) {
      // Get.to(CallReceiveScreen(
      //   imageUrl: data['senderimage'],
      //   fname: data['sendername'],
      //   lname: data['sendername'],
      //   userId: data['userid'],
      //   receivecall: true,
      //   channelId: data['channelid'],
      //   receiverid: data['receiverid'],
      //   appointmentId: data['appointmentId'],
      //   appointmentDuration: data['duration'],
      //   isLive: data['isLive'],
      //   consultantId: data['consultantId'],
      //   appointmentDate: data['appointmentDate'],
      // ));
    } else if (voicecall) {
      // Get.to(MakeVoiceCall(
      //   imageUrl: data['senderimage'],
      //   fname: data['sendername'],
      //   lname: data['sendername'],
      //   userId: data['userid'],
      //   receivecall: true,
      //   channelId: data['channelid'],
      //   receiverid: data['receiverid'],
      //   appointmentId: data['appointmentId'],
      //   appointmentDuration: data['duration'],
      // ));
    } else if (textcall) {
      // Get.to(MakeTextCall(
      //   imageUrl: data['senderimage'],
      //   fname: data['sendername'],
      //   lname: data['sendername'],
      //   userId: data['userid'],
      //   receivecall: true,
      //   channelId: data['channelid'],
      //   receiverid: data['receiverid'],
      //   appointmentId: data['appointmentId'],
      //   appointmentDuration: data['duration'],
      // ));
    }
  } else {
    // Handle other types of notifications
    // Get.to(CallNotificationScreen());
  }
}

void handleVideoCallNotification(RemoteMessage message) async {
  // await audioPlayer.play(AssetSource('tunes/ringtone.mp3'));
  var videoChannelId = message.data?['channelid'];
  var fname = message.data?['fname'];
  var calleruserId = message.data?['userid'];
  var imageUrl = message.data?['imageurl'];
  var lname = message.data?['lname'];
  var receiverId = message.data?['receiverid'];
  var duration = message.data?['duration'];
  var appointmentId = message.data?['appointmentId'];
  var isLive = message.data?['isLive'];
  var appointmentDate = message.data?['appointmentDate'];
  var consultantId = message.data?['consultantId'];

  // var myController = Get.isRegistered<IndividualChatController>()
  //     ? Get.find<IndividualChatController>()
  //     : Get.put(IndividualChatController());

  var userlist = [receiverId, calleruserId]..sort();
  var userJoin = userlist.join('-');
  print("IN NOTIFICATION CALLING STATUS UPDATE  ${userJoin}");
  var isvideocall = message.data?['videocall'];
  var isaudiocall = message.data?['voicecall'];
  var istextcall = message.data?['textcall'];

  if (isvideocall == "true") {
    // myController.callringingornot(userJoin);
    // myController.getCallDetails();
    // Get.to(CallReceiveScreen(
    //   imageUrl: imageUrl,
    //   fname: fname,
    //   lname: lname,
    //   userId: calleruserId,
    //   receivecall: true,
    //   channelId: videoChannelId,
    //   receiverid: receiverId,
    //   appointmentId: appointmentId,
    //   appointmentDuration: duration,
    //   isLive: bool.parse(isLive),
    //   appointmentDate: appointmentDate,
    //   consultantId: consultantId,
    // ));
  } else if (isaudiocall == "true") {
    // myController.audiocallringingornot(userJoin);
    // myController.getAudioCallDetails(receiverId);
    // Get.to(MakeVoiceCall(
    //   imageUrl: imageUrl,
    //   fname: fname,
    //   lname: lname,
    //   userId: calleruserId,
    //   receivecall: true,
    //   channelId: videoChannelId,
    //   receiverid: receiverId,
    //   appointmentId: appointmentId,
    //   appointmentDuration: duration,
    // ));
  } else if (istextcall == "true") {
    // myController.getTextCallDetails(receiverId);
    // Get.to(MakeTextCall(
    //   imageUrl: imageUrl,
    //   fname: fname,
    //   lname: lname,
    //   userId: calleruserId,
    //   receivecall: true,
    //   channelId: videoChannelId,
    //   receiverid: receiverId,
    //   appointmentId: appointmentId,
    //   appointmentDuration: duration,
    // ));
  }
}

late AndroidNotificationChannel channel;
late BuildContext context;

bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class NotificationServices {
  AppointmentsController appointmentsController =
      Get.put(AppointmentsController());
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }

  handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    print("Message Anurag Kashyap ${message}");
    await appointmentsController.fetchWaitingAppointments();
    await appointmentsController.fetchUpcomingAppointments();
    bool videocall = bool.parse(message.data['videocall']) ?? false;
    bool voicecall = bool.parse(message.data['voicecall']) ?? false;
    bool textcall = bool.parse(message.data['textcall']) ?? false;
    if (voicecall || videocall || textcall) {
      handleVideoCallNotification(message);
    } else {
      ///cHECK AUDIO or  video call then navigate accordingly
      // Get.to(CallNotificationScreen());
    }
  }

  // iOS-specific callback for handling notifications when the app is in the foreground
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    await appointmentsController.fetchWaitingAppointments();
    await appointmentsController.fetchUpcomingAppointments();
    Get.to(() => CallNotificationScreen());
  }

  void initLocalNotification() async {
    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@drawable/ic_launcher"),
      iOS: initializationSettingsDarwin,
    );

    // final audioPlayer = AudioPlayer();
    // await audioPlayer.play(AssetSource('tunes/ringtone.mp3'));

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // await audioPlayer.play(AssetSource('tunes/ringtone.mp3'));

        // extractMeetingDetails(notificationResponse.payload);
        Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
        print("fec ${data.toString()}");
        bool videocall = bool.parse(data['data']['videocall']) ?? false;
        bool voicecall = bool.parse(data['data']['voicecall']) ?? false;
        bool textcall = bool.parse(data['data']['textcall']) ?? false;
        print("}}}}}}}}}}${videocall.toString()}");
        print("}}}}}}}}}}${voicecall.toString()}");
        if (voicecall || videocall || textcall) {
          var videoChannelId = data['data']['channelid'];
          var fname = data['data']['fname'];
          var calleruserId = data['data']['userid'];
          var imageUrl = data['data']['imageurl'];
          var lname = data['data']['lname'];
          var receiverId = data['data']['receiverid'];

          // var myController = Get.isRegistered<IndividualChatController>()
          //     ? Get.find<IndividualChatController>()
          //     : Get.put(IndividualChatController());

          var userlist = [receiverId, calleruserId]..sort();
          var userJoin = userlist.join('-');
          print("IN NOTIFICATION CALLING STATUS UPDATE  ${userJoin}");
          var isvideocall = data['data']['videocall'];
          var isaudiocall = data['data']['voicecall'];
          var istextcall = data['data']['textcall'];
          var appointmentId = data['data']['appointmentId'];
          var duration = data['data']['duration'];
          var isLive = data['data']['isLive'];
          var consultantId = data['data']['consultantId'];
          var appointmentDate = data['data']['appointmentDate'];

          if (isvideocall == "true") {
            // myController.callringingornot(userJoin);
            // myController.getCallDetails();
            // Get.to(CallReceiveScreen(
            //   imageUrl: imageUrl,
            //   fname: fname,
            //   lname: lname,
            //   userId: calleruserId,
            //   receivecall: true,
            //   channelId: videoChannelId,
            //   receiverid: receiverId,
            //   appointmentId: appointmentId,
            //   appointmentDuration: duration,
            //   isLive: isLive,
            //   consultantId: consultantId,
            //   appointmentDate: appointmentDate,
            // ));
          } else if (isaudiocall == "true") {
            // myController.audiocallringingornot(userJoin);
            // myController.getAudioCallDetails(receiverId);
            // Get.to(MakeVoiceCall(
            //   imageUrl: imageUrl,
            //   fname: fname,
            //   lname: lname,
            //   userId: calleruserId,
            //   receivecall: true,
            //   channelId: videoChannelId,
            //   receiverid: receiverId,
            //   appointmentId: appointmentId,
            //   appointmentDuration: duration,
            // ));
          } else if (istextcall == "true") {
            // myController.getTextCallDetails(receiverId);
            // Get.to(MakeTextCall(
            //   imageUrl: imageUrl,
            //   fname: fname,
            //   lname: lname,
            //   userId: calleruserId,
            //   receivecall: true,
            //   channelId: videoChannelId,
            //   receiverid: receiverId,
            //   appointmentId: appointmentId,
            //   appointmentDuration: duration,
            // ));
          }
        } else {
          // Get.to(CallNotificationScreen());
        }

      },
    );
  }

  void onSelectNotification(String? payload) async {
    if (payload != null) {
      Map<String, dynamic> data = jsonDecode(payload);
      String actionId = data['actionId'];
      // await audioPlayer.stop();
      print("object");
      if (actionId == 'accept') {
        // Handle accept action
        handleAcceptAction(data);
      } else if (actionId == 'decline') {
        // Handle decline action
        handleDeclineAction(data);
      }
    }
  }

  void handleAcceptAction(Map<String, dynamic> data) async {
    // Handle the accept action here
    print("Call Accepted");
    // Handle the accept action here
    print("Call Accepted");

    // Retrieve the notification ID from the payload data
    int notificationId = data['notificationId'];

    // Cancel the specific notification
    // await audioPlayer.stop();
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  void handleDeclineAction(Map<String, dynamic> data) async {
    // Handle the decline action here
    print("Call Declined");
    // Handle the accept action here
    print("Call Accepted");

    // Retrieve the notification ID from the payload data
    int notificationId = data['notificationId'];
    // await audioPlayer.stop();
    // Cancel the specific notification
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  void extractMeetingDetails(String? payload) {
    if (payload != null) {
      Map<String, dynamic> data = jsonDecode(payload);
      String meetingChannelName =
          data['data']['agoraMeetingChannel'] ?? 'No channel name';
      String token = data['data']['agoraMeetingToken'] ?? 'No token';

      print("Meeting Channel Name: $meetingChannelName");
      print("Token: $token");
    } else {
      print("No payload found");
    }
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'consult', // id
      'Consultants', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
      enableLights: true,
      // sound: RawResourceAndroidNotificationSound('ring'
      sound: RawResourceAndroidNotificationSound('ringtone'),
      // vibrationPattern: Int64List.fromList([
      //   0, 1000, 500, 1000, 500, 1000, 500, 1000, 1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,
      // ]), // custom vibration pattern to mimic ringing
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  initPushNotification() {
    messaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  void showFlutterNotification(RemoteMessage message) async {
    print("foreground ${message.notification!.title}");
    print("foreground ${message.notification!.body}");

    // await audioPlayer.play(AssetSource('tunes/ringtone.mp3'));

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null && !kIsWeb) {
      bool videocall = bool.parse(message.data['videocall']) ?? false;
      bool voicecall = bool.parse(message.data['voicecall']) ?? false;
      bool textcall = bool.parse(message.data['textcall']) ?? false;

      List<AndroidNotificationAction>? actions;
      if (videocall || voicecall || textcall) {
        actions = [
          AndroidNotificationAction("accept", "Accept"),
          AndroidNotificationAction("decline", "Decline"),
        ];
      }

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode({
          ...message.toMap(),
          'actionId': 'accept',
        }),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@drawable/ic_launcher',
            playSound: true,
            enableVibration: true,
            category: AndroidNotificationCategory.call,
            importance: Importance.max,
            // sound: RawResourceAndroidNotificationSound('ring'
            sound: RawResourceAndroidNotificationSound('ringtone'),
            autoCancel: false,
            // Prevents the notification from dismissing automatically
            priority: Priority.high,

            // actions: actions,
            // vibrationPattern: Int64List.fromList([
            //   0, 1000, 500, 1000, 500, 1000, 500, 1000, 1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,1000, 500, 1000,
            // ]), // custom vibration pattern to mimic ringing
          ),
        ),
      );
      // Save notification to Firebase for foreground and background
      // APIs().saveNotificationToFirebase(notification.title, notification.body);
      // Start a timer to cancel the notification after 30 seconds
      Timer(Duration(seconds: 30), () {
        flutterLocalNotificationsPlugin.cancel(message.notification.hashCode);
      });
      // Map<String, dynamic> data = jsonDecode(message.data.toString());
      // print(data);
      await appointmentsController.fetchWaitingAppointments();
      await appointmentsController.fetchUpcomingAppointments();
      print("}}}}}}}}}}${videocall.toString()}");
      print("}}}}}}}}}}${voicecall.toString()}");
      if (voicecall || videocall || textcall) {
        handleVideoCallNotification(message);
      } else {
        ///cHECK AUDIO or  video call then navigate accordingly
        // Get.to(CallNotificationScreen());
      }
    }
  }

  initNotification() async {
    await messaging.requestPermission();
    await setupFlutterNotifications();
    initLocalNotification();
    initPushNotification();
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }
}
