import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';

class CallNotificationScreen extends StatelessWidget {
  const CallNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(

        backgroundColor: colorOrange,
        title: Text("Call Notification Screen", style: TextStyle(
          fontFamily: "Bold",
          fontSize: 16
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Hiii")
          ],
        ),
      ),
    );
  }
}
