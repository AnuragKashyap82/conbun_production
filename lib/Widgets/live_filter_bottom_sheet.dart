import 'package:conbun_production/Agora/controllers/individual_chat_controller.dart';
import 'package:conbun_production/Controllers/package_controller.dart';
import 'package:conbun_production/Controllers/package_duration_controller.dart';
import 'package:conbun_production/Controllers/service_area_controller.dart';
import 'package:conbun_production/Controllers/service_category_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Models/live_consultant_model.dart';
import 'package:conbun_production/Views/bottomNavScreens/liveScreen/live_screen_apis.dart';
import 'package:conbun_production/Views/consultantDetailsScreen/consultants_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';

class LiveFilterBottomSheet extends StatefulWidget {
  final LiveConsultantModel consultantModel;

  const LiveFilterBottomSheet({
    super.key,
    required this.consultantModel,
  });

  @override
  State<LiveFilterBottomSheet> createState() =>
      _LiveFilterBottomSheetItemsState();
}

class _LiveFilterBottomSheetItemsState extends State<LiveFilterBottomSheet> {
  ServiceCategoryController serviceCategoryController = Get.find();
  UserController userController = Get.find();
  ServiceAreaController serviceAreaController =
      Get.put(ServiceAreaController());

  LiveScreenApis liveScreenApis = Get.put(LiveScreenApis());

  PackageController packageController = Get.put(PackageController());
  PackageDurationController packageDurationController =
      Get.put(PackageDurationController());
  bool isChecked = false;
  bool isFeaturedChecked = false;
  late String selectedService = '';
  late String selectedCity = 'Select Your City';

  // IndividualChatController individualChatController =
  //     Get.put(IndividualChatController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Schedule the callback to run after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      liveScreenApis.currentLivePackage.value = ''; // Clear live package
      liveScreenApis.packageDuration.value = ''; // Clear live package
      liveScreenApis.errorMessage.value = ''; // Clear error message
    });
  }

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat timeFormat = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ConsultantsDetailsScreen(
                                consultantId: widget.consultantModel.id,
                                code: 'live')));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 26),
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            widget.consultantModel.profileImage,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ConsultantsDetailsScreen(
                                  consultantId: widget.consultantModel.id,
                                  code: 'live')));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.consultantModel.name,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: colorSecondaryViolet,
                                    fontFamily: "Bold"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade700,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.consultantModel.avgRating,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff7A7A7A),
                                        fontFamily: "Bold"),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 4,
                                    decoration: BoxDecoration(
                                        color: Color(0xff7A7A7A),
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${widget.consultantModel.reviews} Review",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff7A7A7A),
                                          fontFamily: "Bold"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.consultantModel.categories,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff7A7A7A),
                                    fontFamily: "Bold"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: colorSecondaryViolet,
                      )),
                )
              ],
            ),
          ),
          Divider(
            color: Color(0xffE5E5E5),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Talk to consultant",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff343F52),
                      fontFamily: "Bold"),
                ),
                const SizedBox(
                  height: 16,
                ),
                FutureBuilder(
                  future: packageController
                      .fetchAllLivePackages(userController.userData().id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return FutureBuilder(
                        future: packageDurationController.fetchPackageDuration(
                            widget.consultantModel.id,
                            packageController.allLivePackages().id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            // Listening to changes in `allLivePackages` using GetX's reactive state management
                            return Obx(() {
                              if (packageDurationController
                                  .packageDuration.isEmpty) {
                                return Center(
                                    child: Text('No Live Packages Available'));
                              }

                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Number of columns
                                  crossAxisSpacing: 8, // Space between columns
                                  mainAxisSpacing: 0, // Space between rows
                                  childAspectRatio:
                                      1.2, // Adjust the item height to width ratio
                                ),
                                itemCount: packageDurationController
                                    .packageDuration.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(8.0),
                                itemBuilder: (context, index) {
                                  final package = packageDurationController
                                      .packageDuration[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      liveScreenApis.updateSelectedPackage(package.id);
                                      liveScreenApis.updateDuration(package.duration);
                                      liveScreenApis.updateStartDate('${dateFormat.format(DateTime.now())}');
                                      liveScreenApis.updateStartTime('${timeFormat.format(DateTime.now())}');
                                    },
                                    child: Obx(() {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: colorWhite,
                                                    border: Border.all(
                                                      color: colorSecondaryViolet,
                                                      width: liveScreenApis
                                                                  .currentLivePackage
                                                                  .value ==
                                                              package.id
                                                          ? 3
                                                          : 0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [


                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "For",
                                                              // You can replace this with package.duration or another field
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: colorBlack,
                                                                fontFamily: "Bold",
                                                              ),
                                                            ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                            Icon(Icons.timer_outlined, color: colorBlack, size: 12,),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                              "${package.duration}",
                                                              // You can replace this with package.duration or another field
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w800,
                                                                color: colorBlack,
                                                                fontFamily: "Bold",
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              "Mint.",
                                                              // You can replace this with package.duration or another field
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: colorBlack,
                                                                fontFamily: "Bold",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 26.0,),
                                                          child: Divider(
                                                            color: Colors.grey.shade200,
                                                          ),
                                                        ),
                                                        Text(
                                                          "₹${package.amount}",
                                                          // You can replace this with package.amount or another field
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w900,
                                                            color: colorBlack,
                                                            fontFamily: "Bold",
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              liveScreenApis
                                                  .currentLivePackage
                                                  .value ==
                                                  package.id?
                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Container(
                                                      height: 18,
                                                      width: 18,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: colorBlack
                                                      ),
                                                      child: Center(child: Icon(Icons.done,color: colorWhite, size: 14,)))):SizedBox(),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                  );
                                },
                              );
                            });
                          }
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0)
                    .copyWith(bottom: 8),
                child: Text(
                  '${liveScreenApis.errorMessage.value}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                      fontFamily: "Bold"),
                ),
              );
            }),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async {
                liveScreenApis.errorMessage.value = '';
                if (liveScreenApis.currentLivePackage.value != '') {
                  // liveScreenApis.errorMessage.value = 'Calling....';
                  // DateTime time = DateTime.now();
                  // var channelid = '${time.millisecondsSinceEpoch}';
                  // await individualChatController.makeCall(
                  //     channelid,
                  //     userController.userData().id,
                  //     widget.consultantModel.name,
                  //     widget.consultantModel.profileImage,
                  //     widget.consultantModel.name,
                  //     widget.consultantModel.devicetoken,
                  //     widget.consultantModel.id,
                  //     liveScreenApis.startDate.value,
                  //     liveScreenApis.startTime.value,
                  //     liveScreenApis.packageDuration.value,
                  //     liveScreenApis.currentLivePackage.value,
                  //     true
                  // );
                } else {
                  liveScreenApis.errorMessage.value = 'Select package first';

                }
              },
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    color: colorBlack, borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: Text(
                    "Join with ${widget.consultantModel.name}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorWhite,
                        fontFamily: "SemiBold"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
