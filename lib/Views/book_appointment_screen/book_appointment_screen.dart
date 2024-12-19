import 'package:conbun_production/Controllers/package_controller.dart';
import 'package:conbun_production/Controllers/package_duration_controller.dart';
import 'package:conbun_production/Views/book_appointment_screen/book_appointment_apis.dart';
import 'package:conbun_production/Views/book_appointment_screen/book_appointment_two_screen.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../utils/colors.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String consultantId;
  final String consultantToken;
  final bool isLiveBooking;

  const BookAppointmentScreen(
      {super.key, required this.consultantId, required this.consultantToken, required this.isLiveBooking});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  PackageController packageController = Get.put(PackageController());
  PackageDurationController packageDurationController =
      Get.put(PackageDurationController());
  BookAppointmentApis bookAppointmentApis = Get.put(BookAppointmentApis());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookAppointmentApis.clearPackage();
    packageController.allPackages.clear();
    packageController.fetchAllPackages(widget.consultantId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
            child: const Icon(
              Icons.arrow_back,
              color: colorViolet,
              size: 20,
            )),
        title: const Text(
          "Book Your Appointment",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 26,
              ),
              const Text(
                "Select Package",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff343F52),
                    fontFamily: "Bold",
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(() {
                if (packageController.isLoading.value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                              height: 60,
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
                                  borderRadius: BorderRadius.circular(10)),
                              height: 60,
                            )),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  );
                }
                if (packageController.allPackages.isEmpty) {
                  return Center(child: Text("No Available Packages"));
                }
                return ListView.builder(
                  itemCount: packageController.allPackages.length,
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final consultant = packageController.allPackages[index];
                    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: GestureDetector(
                          onTap: () async {
                            bookAppointmentApis.currentIndex.value = index;
                            bookAppointmentApis.priceValue.value = "";
                            bookAppointmentApis.selectedDuration.value = "0";
                            await packageDurationController.fetchPackageDuration(widget.consultantId, consultant.id);
                          },
                          child: AppointmentWidget(
                            color:
                                bookAppointmentApis.currentIndex.value == index
                                    ? Color(0xff3D3C3C)
                                    : colorWhite,
                            title: consultant.name,
                            icon: Icons.message_outlined,
                            perMint:
                                'per ${bookAppointmentApis.selectedDuration.value} min',
                            price: '₹${bookAppointmentApis.priceValue.value}',
                            subTitle: '${consultant.name} with Consultant',
                            textColor:
                                bookAppointmentApis.currentIndex.value == index
                                    ? colorWhite
                                    : Color(0xff343F52),
                            svgName: consultant.name == "Text Messaging"
                                ? 'message'
                                : consultant.name == 'Audio Call'
                                    ? ''
                                    : 'video-solid',
                            isSvg:
                                consultant.name == 'Audio Call' ? false : true,
                            isSelected:
                                bookAppointmentApis.currentIndex.value == index
                                    ? true
                                    : false,
                          ),
                        ),
                      );
                    });
                  },
                );
              }),
              const SizedBox(
                height: 26,
              ),
              const Text(
                "Select Duration",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff343F52),
                    fontFamily: "Bold"),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                if (packageDurationController.isLoading.value) {
                  return ShimmerEffect(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 46,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xffE7E7E7), width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "duration",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff343F52),
                                fontFamily: "SemiBold",
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: VerticalDivider(
                              color: const Color(0xff677294).withOpacity(0.28),
                              width: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xffBCBCBC),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  );
                } else {
                  return PopupMenuButton<int>(
                    padding: EdgeInsets.zero,
                    shadowColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    itemBuilder: (context) {
                      return packageDurationController.packageDuration
                          .map((package) {
                        return PopupMenuItem<int>(
                          padding: EdgeInsets.zero,
                          onTap: () async {
                            bookAppointmentApis.selectedDuration.value =
                                package.duration;
                            bookAppointmentApis.priceValue.value =
                                package.amount;
                            bookAppointmentApis.packageId.value = package.id;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              package.duration,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff343F52),
                                fontFamily: "SemiBold",
                              ),
                            ),
                          ),
                        );
                      }).toList();
                    },
                    child: Container(
                      height: 46,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xffE7E7E7), width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 12),
                          Expanded(child: Obx(() {
                            return Text(
                              "${bookAppointmentApis.selectedDuration.value} Minutes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff343F52),
                                fontFamily: "SemiBold",
                              ),
                            );
                          })),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: VerticalDivider(
                              color: const Color(0xff677294).withOpacity(0.28),
                              width: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xffBCBCBC),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  if(widget.isLiveBooking){
                    showSnackBar('Live Booking', context);
                    ///
                  }else{
                    if (bookAppointmentApis.selectedDuration.value == "0") {
                      showSnackBar("Select your package and Duration", context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BookAppointmentTwoScreen(
                                consultantId: widget.consultantId,
                                devicetoken: widget.consultantToken,
                              )));
                    }
                  }

                },
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.65,
                    decoration: BoxDecoration(
                        color: onBoardingTextColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: colorWhite,
                            fontFamily: "Regular"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final String price;
  final String perMint;
  final String svgName;
  final Color color;
  final Color textColor;
  final bool isSvg;
  final bool isSelected;

  const AppointmentWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.price,
      required this.perMint,
      required this.color,
      required this.textColor,
      required this.isSvg,
      required this.svgName,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 16,
          ),
          isSvg
              ? SvgPicture.asset(
                  'assets/svg/$svgName.svg',
                  width: 28,
                  height: 28,
                  color: textColor,
                )
              : Icon(
                  icon,
                  color: textColor,
                  size: 28,
                ),
          const SizedBox(
            width: 52,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      fontFamily: "SemiBold"),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                      fontFamily: "SemiBold"),
                ),
              ],
            ),
          ),
          isSelected
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                          fontFamily: "SemiBold"),
                    ),
                    Text(
                      perMint,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                          fontFamily: "SemiBold"),
                    ),
                  ],
                )
              : SizedBox(),
          const SizedBox(
            width: 26,
          )
        ],
      ),
    );
  }
}
