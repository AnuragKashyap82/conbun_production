import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4)
          .copyWith(bottom: 36),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.green.shade300,
      content: Row(
        children: [
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    ),
  );
}
