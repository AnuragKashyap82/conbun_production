import 'package:conbun_production/Controllers/faq_controller.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:get/get.dart';

class FAQScreen extends StatefulWidget {
  final int selectedTab;
  const FAQScreen({super.key, required this.selectedTab});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  FaqController faqController = Get.put(FaqController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faqController.fetchFaqCategory();
    faqController.fetchFaq(faqController.selectedIndex.value);
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
            Obx(() {
              if (faqController.isLoading.value) {
                return SizedBox();
              }
              if (faqController.allFaqCategory.isEmpty) {
                return Center(
                  child: Text("No Category"),
                );
              }
              return SizedBox(
                height: 36, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: faqController.allFaqCategory.length,
                  scrollDirection: Axis.horizontal, // Set scroll direction to horizontal
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final followers = faqController.allFaqCategory[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add spacing
                      child: GestureDetector(
                        onTap: () async{
                          faqController.selectedIndex.value = followers.id;
                          await faqController.fetchFaq(followers.id);
                        },
                        child: Obx(() {
                          return Container(
                            width: 140,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                            decoration: BoxDecoration(
                              color: faqController.selectedIndex.value == followers.id
                                  ? Color(0xff677294)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: const Color(0xff677294)),
                            ),
                            child: Center(
                              child: Text(
                                followers.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Bold",
                                  color: faqController.selectedIndex.value == followers.id
                                      ? Colors.white
                                      : Color(0xff677294),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(
              height: 16,
            ),
            Obx(() {
              if (faqController.isLoading.value) {
                return CircularProgressIndicator();
              }
              if (faqController.allFaq.isEmpty) {
                return Center(
                  child: Text("No FAQ"),
                );
              }
              return ListView.builder(
                itemCount: faqController.allFaq.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final faq = faqController.allFaq[index];

                  var document = html_parser.parse( faq.description);
                  var body = document.body;

                  // Convert parsed HTML into a string
                  String parsedContent = body?.text ?? '';
                  return
                    Obx((){
                      return GestureDetector(
                        onTap: () {
                          faqController.selectedFaqIndex.value = faq.id;
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
                                      Flexible(
                                        child: Text(
                                          faq.title,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "SemiBold",
                                            color: colorBlack,
                                          ),
                                          maxLines: 4,
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
                                faqController.selectedFaqIndex.value == faq.id?
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
                                        parsedContent,
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
                      );
                    });
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
