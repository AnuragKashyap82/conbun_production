import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContactItems(title: 'Customer Services', iconData: Icons.headphones,isSvg: false,svgPath: '',),
            ContactItems(title: 'Whatsapp', iconData: Icons.whatshot,isSvg: true,svgPath: 'whatsapp',),
            ContactItems(title: 'Website', iconData: Icons.web_stories,isSvg: false,svgPath: '',),
            ContactItems(title: 'Facebook', iconData: Icons.facebook,isSvg: false,svgPath: '',),
            ContactItems(title: 'Twitter', iconData: Icons.bike_scooter,isSvg: true,svgPath: 'twitter',),
            ContactItems(title: 'Instagram', iconData: Icons.facebook,isSvg: true,svgPath: 'instagram',),
          ],
        ),
      ),
    );
  }
}


class ContactItems extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool isSvg;
  final String svgPath;
  const ContactItems({super.key, required this.iconData, required this.title, required this.isSvg, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isSvg?SizedBox():
                  Icon(iconData, color: Color(0xff0D0D0D), size: 20,),
                  isSvg?
                  SvgPicture.asset(
                    'assets/svg/$svgPath.svg',
                    width: 16,
                    height: 16,
                    color: colorBlack,
                  ):SizedBox(),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SemiBold",
                      color: colorBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
