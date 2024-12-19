import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.1),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,
            color: colorViolet,
            size: 20,),
        ),
        title: Text(
          "Notification",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationItems(title: 'General Notification'),
              NotificationItems(title: 'Sound'),
              NotificationItems(title: 'Vibrate'),
              NotificationItems(title: 'Special Offers'),
              NotificationItems(title: 'Promo & Discount'),
              NotificationItems(title: 'Payments'),
              NotificationItems(title: 'Cashback'),
              NotificationItems(title: 'App Update'),
              NotificationItems(title: 'New Service Available'),
              NotificationItems(title: 'New Tip Available'),
            ],
          ),
        ),
      ),
    );
  }
}


class NotificationItems extends StatelessWidget {
  final String title;
  const NotificationItems(
      {super.key, required this.title,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff353535),
                  fontFamily: "SemiBold"),
            ),
          ),
          Container(
            height: 16,
            width: 60,
            child: Transform.scale(
              scale: 0.6,
              child: Switch(
                activeColor: colorWhite,
                activeTrackColor: colorViolet,
                inactiveThumbColor: colorWhite,
                inactiveTrackColor: colorBackground,
                value: true,
                onChanged: (value) => {},
              ),
            ),
          )
        ],
      ),
    );
  }
}