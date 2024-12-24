import 'package:conbun_production/Controllers/invite_controller.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  InviteController inviteController = Get.put(InviteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppBar(
            backgroundColor: Colors.black.withOpacity(0.95),
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            surfaceTintColor: colorBlack,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: colorWhite,
                  size: 20,
                )),
            title: Text(
              "Refer & Earn",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorWhite,
                  fontFamily: "SemiBold"),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await inviteController.fetchAllInvites();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black.withOpacity(0.95),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: Image.asset(
                        "assets/images/referearn.png",
                        fit: BoxFit.fill,
                        height: 80,
                        width: 120,
                      )),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Invite your Friends and earn upto ₹200 per user",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: colorWhite,
                            fontFamily: "Bold"),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 38,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: colorWhite),
                        child: DottedBorder(
                          color: Color(0xffE7E7E7),
                          strokeWidth: 2,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(6),
                          dashPattern: [6],
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(() {
                                    if (inviteController.isLoading.value) {
                                      return Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: onBoardingTextColor,
                                            fontFamily: "Bold"),
                                      );
                                    } else {
                                      return Text(
                                        inviteController
                                                .refrelData()!
                                                .referralCode
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: onBoardingTextColor,
                                            fontFamily: "Bold"),
                                      );
                                    }
                                  }),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Copy",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: onBoardingTextColor,
                                            fontFamily: "Bold"),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.copy, color: colorBlack, size: 16,) ,
                                        onPressed: (){
                                          Clipboard.setData(ClipboardData(text: inviteController
                                              .refrelData()!
                                              .referralCode
                                              .toString()));
                                          showSnackBar('Copied ${inviteController
                                              .refrelData()!
                                              .referralCode
                                              .toString()}', context);
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 42,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How does it work??",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: colorSecondaryViolet,
                          fontFamily: "SemiBold"),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 138,
                      width: MediaQuery.of(context).size.width,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            "assets/images/youtube.png",
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: colorBlack)),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200,
                                  color: colorSecondaryViolet,
                                  fontFamily: "SemiBold"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Invite your friends to Conbun",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: colorSecondaryViolet,
                              fontFamily: "Bold"),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: colorBlack)),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200,
                                  color: colorSecondaryViolet,
                                  fontFamily: "SemiBold"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            "You earn 1% fund share every time your friends",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorSecondaryViolet,
                                fontFamily: "Bold"),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: colorBlack)),
                          child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200,
                                  color: colorSecondaryViolet,
                                  fontFamily: "SemiBold"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Earn upto ₹200 per invite",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: colorSecondaryViolet,
                              fontFamily: "Bold"),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Rules",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: colorSecondaryViolet,
                          fontFamily: "SemiBold"),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: colorBlack)),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200,
                                  color: colorSecondaryViolet,
                                  fontFamily: "SemiBold"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            "Invite your friends to Conbun Invite your friends to Conbun Invite your friends to Conbun Invite your friends to Conbun",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorSecondaryViolet,
                                fontFamily: "Bold"),
                            textAlign: TextAlign.start,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: colorBlack)),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200,
                                  color: colorSecondaryViolet,
                                  fontFamily: "SemiBold"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            "Invite your friends to Conbun Invite your friends to Conbun Invite your friends to Conbun Invite your friends to Conbun",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorSecondaryViolet,
                                fontFamily: "Bold"),
                            textAlign: TextAlign.start,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Your Invite Status",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: colorSecondaryViolet,
                          fontFamily: "SemiBold"),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() {
                      if (inviteController.isLoading.value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ShimmerEffect(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10)),
                                    height: 72,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 72,
                                    )),
                                SizedBox(
                                  height: 16,
                                ),
                                ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 72,
                                    )),
                                SizedBox(
                                  height: 16,
                                ),
                                ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 72,
                                    )),
                                SizedBox(
                                  height: 16,
                                ),
                                ShimmerEffect(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 72,
                                    )),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      if (inviteController.refrelData()!.invites.isEmpty) {
                        return Center(
                          child: Text("No Invites"),
                        );
                      }
                      return ListView.builder(
                        itemCount: inviteController.refrelData()!.invites.length,
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final invites =
                              inviteController.refrelData()!.invites[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                          height: 34,
                                          width: 34,
                                          decoration: BoxDecoration(
                                              color: colorWhite,
                                              shape: BoxShape.circle),
                                          child: invites.profileImage != null
                                              ? Image.network(invites.profileImage!, fit: BoxFit.cover,)
                                              : Icon(
                                                  Icons.person,
                                                  color: colorOrange,
                                                )),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            invites.name,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "SemiBold",
                                              color: Color(0xff697182),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '₹${invites.amount}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "Bold",
                                        color: Color(0xff697182),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 42,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 36,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width * 0.37,
                            decoration: BoxDecoration(
                                color: colorBlack,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Invite Now",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w200,
                                        color: colorWhite,
                                        fontFamily: "SemiBold"),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    color: colorWhite,
                                    size: 13,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width * 0.37,
                          decoration: BoxDecoration(
                              color: colorWhite,
                              border: Border.all(color: Color(0xff636363)),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Other Options",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: colorBlack,
                                      fontFamily: "SemiBold"),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.share_outlined,
                                  color: colorBlack,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
