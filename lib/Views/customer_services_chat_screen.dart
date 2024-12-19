import 'package:conbun_production/Views/session_end_screen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomerServicesChatScreen extends StatelessWidget {
  const CustomerServicesChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.1),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: colorViolet,
              size: 20,
            )),
        title: Text(
          "Customer Services",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
        actions: [
          Icon(
            Icons.call,
            color: colorBlack,
            size: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: colorBlack)),
                child: Icon(
                  Icons.more_horiz,
                  color: colorBlack,
                  size: 12,
                )),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width * 0.77,
                      decoration: BoxDecoration(
                          color: Color(0xffe8e6e6),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.emoji_emotions_outlined,
                            color: Color(0xffBBBBBB),
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: colorBlack,
                                  fontFamily: "Regular"),
                              decoration: InputDecoration(
                                  hintText: 'Type a message',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffBBBBBB),
                                      fontFamily: "SemiBold"),
                                  contentPadding: EdgeInsets.only(bottom: 5),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.attach_file_outlined,
                            color: Color(0xffBBBBBB),
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.camera_enhance,
                            color: Color(0xffBBBBBB),
                            size: 22,
                          ),
                          SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => ConsultantSessionEndScreen()));
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            color: colorViolet, shape: BoxShape.circle),
                        child: Center(
                            child: Icon(
                          Icons.mic,
                          color: colorWhite,
                          size: 32,
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0)
                  .copyWith(bottom: 64),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MessageItems(),
                    MessageItemsReceived(),
                    MessageItems(),
                    MessageItemsReceived(),
                    MessageItems(),
                    MessageItemsReceived(),
                    MessageItems(),
                    MessageItemsReceived(),
                    MessageItems(),
                    MessageItemsReceived(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageItems extends StatelessWidget {
  const MessageItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65,
              minWidth: 120,
              minHeight: 52),
          decoration: BoxDecoration(
            color: colorViolet,
            borderRadius: BorderRadius.all(Radius.circular(26))
                .copyWith(bottomRight: Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hi, good afternoon Mr. onsultant...",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: colorWhite,
                      fontFamily: "SemiBold"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "16:00",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                          color: colorWhite,
                          fontFamily: "Regular"),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.done_all_outlined,
                      color: colorWhite,
                      size: 12,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageItemsReceived extends StatelessWidget {
  const MessageItemsReceived({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65,
              minWidth: 120,
              minHeight: 52),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.all(Radius.circular(26))
                .copyWith(bottomRight: Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Can you tell me the problem you are having? So that i can identify it.So that i can identify it.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: colorBlack,
                      fontFamily: "SemiBold"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "16:00",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                          color: Color(0xff838383),
                          fontFamily: "Regular"),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.done_all_outlined,
                      color: colorBlack,
                      size: 12,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
