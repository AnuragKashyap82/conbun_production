import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        body: Center(
          child: GestureDetector(
            onTap: () {
              openAppSettings();
            },
            child: Container(
              height: 52,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  color: colorOrange, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  "Allow Notification Permission",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Bold",
                    color: colorWhite,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
