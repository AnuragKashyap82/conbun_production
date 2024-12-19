import 'package:conbun_production/NotificationServices/notification_services.dart';
import 'package:conbun_production/Views/onBoardingScreens/on_boarding_screen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Views/bottomNavScreens/bottomNavScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // NotificationServices().initLocalNotification();
  // NotificationServices().initNotification();
  // NotificationServices().initPushNotification();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  /// This widget is the root of your application.
  Future<Widget> checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('id') ?? ''; // Set default value as empty string
    print(token);
    if (token.isNotEmpty) {
      return BottomNavScreen(currentTab: 0);
    } else {
      return const OnBoardingScreen();
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Conbun',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorOrange),
        useMaterial3: true,
        fontFamily: "SemiBold",
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
        ),
      ),
      home: FutureBuilder(
        future: checkLogin(context),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorOrange,
                ),
              ),
            );
          } else {
            return snapshot.data ?? const OnBoardingScreen();
          }
        },
      ),
    );
  }
}
