import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FAQScreen extends StatefulWidget {
  final int selectedTab;
  const FAQScreen({super.key, required this.selectedTab});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  late bool codeOne = true;
  late bool codeTwo = false;
  late bool codeThree = false;
  late bool codeFour = false;
  late bool codeFive = false;
  late int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.selectedTab;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                          color: selectedIndex == 0? Color(0xff677294): Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: const Color(0xff677294)),                    ),
                      child:  Center(
                        child: Text(
                          "General",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            fontFamily: "Bold",
                            color: selectedIndex == 0?  colorWhite:Color(0xff677294),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: selectedIndex == 1? Color(0xff677294): Colors.transparent,
                        border: Border.all(color: const Color(0xff677294)),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child:  Center(
                        child: Text(
                          "Recharge",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            fontFamily: "Bold",
                            color: selectedIndex == 1?  colorWhite:Color(0xff677294),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: selectedIndex == 2? Color(0xff677294): Colors.transparent,
                        border: Border.all(color: const Color(0xff677294)),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child:  Center(
                        child: Text(
                          "Services",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            fontFamily: "Bold",
                            color: selectedIndex == 2?  colorWhite:Color(0xff677294),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            // Material(
            //   elevation: 7,
            //   borderRadius: BorderRadius.circular(6),
            //   shadowColor: colorBackground.withOpacity(0.4),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: 56,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.1),
            //           spreadRadius: 5,
            //           blurRadius: 7,
            //           offset: const Offset(0, 0), // changes position of shadow
            //         ),
            //       ],
            //       borderRadius: BorderRadius.circular(6),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         const SizedBox(
            //           width: 26,
            //         ),
            //         Image.asset("assets/images/search.png"),
            //         const SizedBox(
            //           width: 16,
            //         ),
            //         Expanded(
            //           child: TextFormField(
            //             decoration: const InputDecoration(
            //                 hintText: 'Search...',
            //                 hintStyle: TextStyle(
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w200,
            //                     color: Color(0xff70798B),
            //                     fontFamily: "SemiBold"),
            //                 contentPadding: EdgeInsets.only(bottom: 5),
            //                 enabledBorder: InputBorder.none,
            //                 focusedBorder: InputBorder.none),
            //           ),
            //         ),
            //         const SizedBox(
            //           width: 16,
            //         ),
            //         SvgPicture.asset(
            //           'assets/svg/filter.svg',
            //           width: 18,
            //           height: 18,
            //           color: colorViolet,
            //         ),
            //         const SizedBox(
            //           width: 16,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            GestureDetector(
              onTap: () {
                setState(() {
                  codeOne = !codeOne;
                  codeTwo = false;
                  codeThree = false;
                  codeFour = false;
                  codeFive = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "What Is Appname",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: "SemiBold",
                                color: colorBlack,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xff0D0D0D),
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      codeOne?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: Color(0xffECECEC),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                                fontFamily: "SemiBold",
                                color: Color(0xff898989),
                              ),
                            ),
                          ),
                        ],
                      ): SizedBox(),
                      SizedBox(
                        height: 12,
                      )
                    ],

                  ),

                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  codeTwo = !codeTwo;
                  codeOne = false;
                  codeThree = false;
                  codeFour = false;
                  codeFive = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(8)),
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "How do i Cancel an appointment",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: "SemiBold",
                              color: colorBlack,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xff0D0D0D),
                            size: 16,
                          )
                        ],
                      ),
                      codeTwo?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: Color(0xffECECEC),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                                fontFamily: "SemiBold",
                                color: Color(0xff898989),
                              ),
                            ),
                          ),
                        ],
                      ): SizedBox(),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  codeThree = !codeThree;
                  codeOne = false;
                  codeTwo = false;
                  codeFour = false;
                  codeFive = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(8)),
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "What Is Appname",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: "SemiBold",
                              color: colorBlack,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xff0D0D0D),
                            size: 16,
                          )
                        ],
                      ),
                      codeThree?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: Color(0xffECECEC),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                                fontFamily: "SemiBold",
                                color: Color(0xff898989),
                              ),
                            ),
                          ),
                        ],
                      ): SizedBox(),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  codeFour = !codeFour;
                  codeOne = false;
                  codeTwo = false;
                  codeThree = false;
                  codeFive = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(8)),
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "What Is Appname",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: "SemiBold",
                              color: colorBlack,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xff0D0D0D),
                            size: 16,
                          )
                        ],
                      ),
                      codeFour?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: Color(0xffECECEC),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                                fontFamily: "SemiBold",
                                color: Color(0xff898989),
                              ),
                            ),
                          ),
                        ],
                      ): SizedBox(),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  codeFive = !codeFive;
                  codeOne = false;
                  codeTwo = false;
                  codeThree = false;
                  codeFour = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(8)),
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "What Is Appname",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: "SemiBold",
                              color: colorBlack,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xff0D0D0D),
                            size: 16,
                          )
                        ],
                      ),
                      codeFive?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: Color(0xffECECEC),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                                fontFamily: "SemiBold",
                                color: Color(0xff898989),
                              ),
                            ),
                          ),
                        ],
                      ): SizedBox(),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
