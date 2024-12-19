import 'package:conbun_production/Views/bottomNavScreens/consultantScreen/consultant_apis.dart';
import 'package:conbun_production/Widgets/consultant_skeleton_widget.dart';
import 'package:conbun_production/Widgets/consultants_widget.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../../Controllers/consultants_controller.dart';
import '../../../Controllers/service_category_controller.dart';
import '../bottomNavScreen.dart';

class ConsultantsScreen extends StatefulWidget {
  const ConsultantsScreen({super.key});

  @override
  State<ConsultantsScreen> createState() => _ConsultantsScreenState();
}

class _ConsultantsScreenState extends State<ConsultantsScreen> {
  ConsultantApis consultantApis = Get.put(ConsultantApis());

  ServiceCategoryController serviceCategoryController = Get.find();
  ConsultantsController consultantsController = Get.find();
  Future<void> refreshData() async {
    await consultantsController.fetchTopConsultants();
  }

  late bool _isLoading = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
            title: const Text(
              "Consultants",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorViolet,
                  fontFamily: "SemiBold"),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await refreshData();
        },
        child: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 32,
                child:
                Obx(() {
                  if (serviceCategoryController.isLoading.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShimmerEffect(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                consultantApis.currentFilter.value == "All"
                                    ? colorOrange
                                    : colorWhite,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6),
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                      consultantApis.currentFilter.value ==
                                          "All"
                                          ? colorWhite
                                          : colorOrange,
                                      fontFamily: "SemiBold"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ShimmerEffect(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                consultantApis.currentFilter.value == "All"
                                    ? colorOrange
                                    : colorWhite,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6),
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                      consultantApis.currentFilter.value ==
                                          "All"
                                          ? colorWhite
                                          : colorOrange,
                                      fontFamily: "SemiBold"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ShimmerEffect(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                consultantApis.currentFilter.value == "All"
                                    ? colorOrange
                                    : colorWhite,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6),
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                      consultantApis.currentFilter.value ==
                                          "All"
                                          ? colorWhite
                                          : colorOrange,
                                      fontFamily: "SemiBold"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ShimmerEffect(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                consultantApis.currentFilter.value == "All"
                                    ? colorOrange
                                    : colorWhite,
                                borderRadius: BorderRadius.circular(6),),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6),
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                      consultantApis.currentFilter.value ==
                                          "All"
                                          ? colorWhite
                                          : colorOrange,
                                      fontFamily: "SemiBold"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (serviceCategoryController.allServiceCategory.isEmpty) {
                    return Center(
                      child: Text(
                        "No Service Category",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorViolet,
                            fontFamily: "SemiBold"),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount:
                    serviceCategoryController.allServiceCategory.length +
                        1, // Increase item count by 1
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        // Return "All" category at index 0
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: GestureDetector(
                            onTap: () async {
                              await consultantApis.changeFilter('All');
                              setState(() {
                                _isLoading = true;
                              });
                              await Future.delayed(Duration(seconds: 1));
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            child: Obx(() {
                              return Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  color:
                                  consultantApis.currentFilter.value == "All"
                                      ? colorOrange
                                      : colorWhite,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color(0xffED802D), width: 1),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0),
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                        consultantApis.currentFilter.value ==
                                            "All"
                                            ? colorWhite
                                            : colorOrange,
                                        fontFamily: "SemiBold",
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }

                      final serviceCategory = serviceCategoryController
                          .allServiceCategory[index - 1];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GestureDetector(onTap: () async {
                          await consultantApis.changeFilter(serviceCategory.name);
                          await consultantsController.getConsultantsByCategory(serviceCategory.name);
                          setState(() {
                            _isLoading = true;
                          });
                          await Future.delayed(Duration(seconds: 1));
                          setState(() {
                            _isLoading = false;
                          });
                        }, child: Obx(() {
                          return Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: consultantApis.currentFilter.value ==
                                  serviceCategory.name
                                  ? colorOrange
                                  : colorWhite,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xffED802D), width: 1),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: Text(
                                  serviceCategory.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: consultantApis.currentFilter.value ==
                                        serviceCategory.name
                                        ? colorWhite
                                        : colorOrange,
                                    fontFamily: "SemiBold",
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(() {
                if (consultantsController.isLoading.value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                        ],
                      ),
                    ),
                  );
                }
                if (consultantsController.topConsultants.isEmpty) {
                  return Center(
                    child: Text(
                      "No Top Consultant",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorViolet,
                          fontFamily: "SemiBold"),
                    ),
                  );
                }
                if (_isLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                          SizedBox(
                            height: 8,
                          ),
                          ConsultantSkeleton(),
                        ],
                      ),
                    ),
                  );
                }
                if (consultantApis.currentFilter.value != 'All' && consultantsController.filteredTopConsultants.isEmpty) {
                  return  Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.7
                    ),
                    child: Center(
                      child: Text(
                        "No Top ${consultantApis.currentFilter.value} Consultants",
                        style: TextStyle(
                          fontSize: 14,
                          color: colorBlack,
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: consultantApis.currentFilter.value == 'All'
                      ? consultantsController.topConsultants.length
                      : consultantsController.filteredTopConsultants.length,
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final consultant =
                    consultantApis.currentFilter.value == 'All'
                        ? consultantsController.topConsultants[index]
                        : consultantsController.filteredTopConsultants[index];
                    return ConsultantsWidget(consultantModel: consultant, save: false, searchQuery: '',);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
