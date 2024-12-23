import 'package:conbun_production/Controllers/live_consultants_controller.dart';
import 'package:conbun_production/Widgets/filter_bottom_sheet.dart';
import 'package:conbun_production/Widgets/live_consultants_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../../utils/colors.dart';
import '../bottomNavScreen.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  LiveConsultantsController liveConsultantsController = Get.put(LiveConsultantsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavScreen(
                    currentTab: 0,
                  ),
                  maintainState: false,
                ));
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            leading: IconButton(icon: Icon(
              Icons.arrow_back,
              color: colorViolet,
              size: 20,
            ), onPressed: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavScreen(
                      currentTab: 0,
                    ),
                    maintainState: false,
                  ));
            },),
            titleSpacing: 0,
            title: Text(
              "Live Consultants",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorViolet,
                  fontFamily: "SemiBold"),
            ),
          ),
        ),
      ),
      body:

      Obx(() {
        if (liveConsultantsController.isLoading.value) {
          return
              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 16,
                                ),
                                const Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Search Live Consultant....",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffB2B7C0),
                                        fontFamily: "SemiBold",
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  child: VerticalDivider(
                                    color: Color(0xffE4E4E4),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            constraints: BoxConstraints(
                                                maxHeight: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.9),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight: Radius.circular(25.0),
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                              child: FilterBottomSheetItems(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.filter_alt_outlined,
                                    color: Color(0xffB2B7C0),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                          children: [
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                            ShimmerEffect(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: LiveConsultantsSkeleton()),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        }
        if (liveConsultantsController.liveConsultant.isEmpty) {
          return RefreshIndicator(
            onRefresh: ()async{
              await liveConsultantsController.fetchLiveConsultant();
            },
            child: SingleChildScrollView(
              child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.85
                  ),
                  child: Center(child: Text("No Live Consultant"))),
            ),
          );
        }

        // return
        //     RefreshIndicator(
        //       onRefresh: ()async{
        //         await liveConsultantsController.fetchLiveConsultant();
        //       },
        //       child: SingleChildScrollView(
        //           physics: BouncingScrollPhysics(),
        //           child: Container(
        //             constraints: BoxConstraints(
        //               minHeight: MediaQuery.of(context).size.height
        //             ),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 const SizedBox(
        //                   height: 16,
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //                   child: Container(
        //                     width: MediaQuery.of(context).size.width,
        //                     height: 48,
        //                     decoration: BoxDecoration(
        //                       color: Colors.white,
        //                       borderRadius: BorderRadius.circular(6),
        //                       boxShadow: [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.1),
        //                           spreadRadius: 5,
        //                           blurRadius: 7,
        //                           offset: const Offset(
        //                               0, 0), // changes position of shadow
        //                         ),
        //                       ],
        //                     ),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         const SizedBox(
        //                           width: 16,
        //                         ),
        //                         const Expanded(
        //                           child: TextField(
        //                             decoration: InputDecoration(
        //                               hintText: "Search Live Consultant....",
        //                               hintStyle: TextStyle(
        //                                 fontSize: 16,
        //                                 color: Color(0xffB2B7C0),
        //                                 fontFamily: "SemiBold",
        //                               ),
        //                               border: InputBorder.none,
        //                             ),
        //                           ),
        //                         ),
        //                         const Padding(
        //                           padding: EdgeInsets.symmetric(vertical: 12.0),
        //                           child: VerticalDivider(
        //                             color: Color(0xffE4E4E4),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           width: 6,
        //                         ),
        //                         GestureDetector(
        //                           onTap: () {
        //                             showModalBottomSheet(
        //                               context: context,
        //                               isScrollControlled: true,
        //                               backgroundColor: Colors.transparent,
        //                               builder: (BuildContext context) {
        //                                 return ClipRRect(
        //                                   borderRadius: const BorderRadius.only(
        //                                     topLeft: Radius.circular(25.0),
        //                                     topRight: Radius.circular(25.0),
        //                                   ),
        //                                   child: Container(
        //                                     padding: const EdgeInsets.symmetric(
        //                                         vertical: 16.0),
        //                                     constraints: BoxConstraints(
        //                                         maxHeight: MediaQuery.of(context)
        //                                                 .size
        //                                                 .height *
        //                                             0.9),
        //                                     decoration: const BoxDecoration(
        //                                       color: Colors.white,
        //                                       borderRadius: BorderRadius.only(
        //                                         topLeft: Radius.circular(25.0),
        //                                         topRight: Radius.circular(25.0),
        //                                       ),
        //                                     ),
        //                                     child: FilterBottomSheetItems(),
        //                                   ),
        //                                 );
        //                               },
        //                             );
        //                           },
        //                           child: Icon(
        //                             Icons.filter_alt_outlined,
        //                             color: Color(0xffB2B7C0),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           width: 16,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 16,
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //                   child:
        //                   GridView.builder(
        //                     itemCount: liveConsultantsController.liveConsultant.length,
        //                     shrinkWrap: true,
        //                     physics: const NeverScrollableScrollPhysics(),
        //                     itemBuilder: (BuildContext context, int index) {
        //                       final liveConsultant =
        //                       liveConsultantsController.liveConsultant[index];
        //                       return LiveConsultantWidget(liveConsultantModel: liveConsultant,);
        //                     },
        //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                       crossAxisCount: 3, // Number of items in a row
        //                       mainAxisSpacing: 10.0, // Vertical spacing between rows
        //                       crossAxisSpacing: 10.0, // Horizontal spacing between columns
        //                       childAspectRatio: 1.0, // Aspect ratio of each grid item
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //     );
        return RefreshIndicator(
          onRefresh: ()async{
            await liveConsultantsController.fetchLiveConsultant();
          },
          child: SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.85
                ),
                child: Center(child: Text("No Live Consultant"))),
          ),
        );
      }),

    );
  }
}
