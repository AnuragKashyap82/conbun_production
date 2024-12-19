import 'package:conbun_production/Controllers/consultants_controller.dart';
import 'package:conbun_production/Views/searchConsultantScreen/search_consultant_apis.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../Widgets/consultants_widget.dart';
import '../../Widgets/filter_bottom_sheet.dart';

class SearchConsultantsScreen extends StatefulWidget {
  final String searchKeyWord;

  const SearchConsultantsScreen({super.key, required this.searchKeyWord});

  @override
  State<SearchConsultantsScreen> createState() =>
      _SearchConsultantsScreenState();
}

class _SearchConsultantsScreenState extends State<SearchConsultantsScreen> {
  SearchConsultantApis searchConsultantApis = Get.put(SearchConsultantApis());
  ConsultantsController consultantsController = Get.find();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.searchKeyWord == '') {
      searchConsultantApis.currentFilter.value = 'All';
    } else {
      searchConsultantApis.currentFilter.value = widget.searchKeyWord;
      consultantsController.getConsultantsByCategory(widget.searchKeyWord);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: colorWhite,
          elevation: 7,
          shadowColor: Colors.black.withOpacity(0.1),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,
              color: colorViolet,
              size: 18,)

          ),
          titleSpacing: 0,
          title: const Text(
            "Search Consultants",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorViolet,
                fontFamily: "SemiBold"),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
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
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) async {
                        print(value);
                        print(searchConsultantApis.selectedCity.value);
                        print(searchConsultantApis.featured.value);
                        print(searchConsultantApis.verified.value);
                        print(searchConsultantApis.selectedRating.value);
                        await consultantsController.searchConsultant(
                            value,
                            searchConsultantApis.selectedCity.value,
                            "All",
                            searchConsultantApis.featured.value,
                            searchConsultantApis.verified.value,
                            searchConsultantApis.selectedRating.value);
                        if (value.isEmpty) {
                          consultantsController.searchedConsultants.clear();
                        }
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText:
                        "Search ${widget.searchKeyWord} Consultant....",
                        hintStyle: const TextStyle(
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
                    width: 8,
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
                              padding:
                              const EdgeInsets.symmetric(vertical: 16.0),
                              constraints: BoxConstraints(
                                  maxHeight:
                                  MediaQuery.of(context).size.height * 0.9),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: FilterBottomSheetItems(),
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
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
          const SizedBox(
            height: 16,
          ),
          Obx(() {
            if (consultantsController.isLoading.value) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Column(
                      children: [
                        ShimmerEffect(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color:
                                  Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 100,
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
                                  color:
                                  Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 100,
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
                                  color:
                                  Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 100,
                            )),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            // if (consultantsController.topConsultants.isEmpty) {
            //   return Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //     child: SingleChildScrollView(
            //       child: Column(
            //         children: [
            //           ShimmerEffect(
            //               baseColor: Colors.grey.shade300,
            //               highlightColor: Colors.grey.shade100,
            //               child: Container(
            //                 width: MediaQuery.of(context).size.width,
            //                 decoration: BoxDecoration(
            //                     color:
            //                     Colors.green,
            //                     borderRadius: BorderRadius.circular(10)),
            //                 height: 100,
            //               )),
            //           SizedBox(
            //             height: 16,
            //           ),
            //           ShimmerEffect(
            //               baseColor: Colors.grey.shade300,
            //               highlightColor: Colors.grey.shade100,
            //               child: Container(
            //                 width: MediaQuery.of(context).size.width,
            //                 decoration: BoxDecoration(
            //                     color:
            //                     Colors.green,
            //                     borderRadius: BorderRadius.circular(10)),
            //                 height: 100,
            //               )),
            //           SizedBox(
            //             height: 16,
            //           ),
            //           ShimmerEffect(
            //               baseColor: Colors.grey.shade300,
            //               highlightColor: Colors.grey.shade100,
            //               child: Container(
            //                 width: MediaQuery.of(context).size.width,
            //                 decoration: BoxDecoration(
            //                     color:
            //                     Colors.green,
            //                     borderRadius: BorderRadius.circular(10)),
            //                 height: 100,
            //               )),
            //           SizedBox(
            //             height: 16,
            //           ),
            //           ShimmerEffect(
            //               baseColor: Colors.grey.shade300,
            //               highlightColor: Colors.grey.shade100,
            //               child: Container(
            //                 width: MediaQuery.of(context).size.width,
            //                 decoration: BoxDecoration(
            //                     color:
            //                     Colors.green,
            //                     borderRadius: BorderRadius.circular(10)),
            //                 height: 100,
            //               )),
            //           SizedBox(
            //             height: 16,
            //           ),
            //           ShimmerEffect(
            //               baseColor: Colors.grey.shade300,
            //               highlightColor: Colors.grey.shade100,
            //               child: Container(
            //                 width: MediaQuery.of(context).size.width,
            //                 decoration: BoxDecoration(
            //                     color:
            //                     Colors.green,
            //                     borderRadius: BorderRadius.circular(10)),
            //                 height: 100,
            //               )),
            //           SizedBox(
            //             height: 16,
            //           ),
            //           ShimmerEffect(
            //               baseColor: Colors.grey.shade300,
            //               highlightColor: Colors.grey.shade100,
            //               child: Container(
            //                 width: MediaQuery.of(context).size.width,
            //                 decoration: BoxDecoration(
            //                     color:
            //                     Colors.green,
            //                     borderRadius: BorderRadius.circular(10)),
            //                 height: 100,
            //               )),
            //           SizedBox(
            //             height: 16,
            //           ),
            //         ],
            //       ),
            //     ),
            //   );
            // }
            // if (consultantsController.filteredTopConsultants.isEmpty) {
            //   return  Container(
            //     constraints: BoxConstraints(
            //         minHeight: MediaQuery.of(context).size.height * 0.7
            //     ),
            //     child: Center(
            //       child: Text(
            //         "No ${widget.searchKeyWord} Consultants",
            //         style: TextStyle(
            //           fontSize: 14,
            //           color: colorBlack,
            //         ),
            //       ),
            //     ),
            //   );
            // }
            if(_searchController.text.trim().isEmpty){
              return Expanded(
                child: ListView.builder(
                  itemCount: consultantsController.filteredTopConsultants.length,
                  shrinkWrap: true,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final consultant =
                    consultantsController.filteredTopConsultants[index];
                    return ConsultantsWidget(consultantModel: consultant, save: false, searchQuery: '',);
                  },
                ),
              );
            }
              return Expanded(
                child: ListView.builder(
                  itemCount: consultantsController.searchedConsultants.length,
                  shrinkWrap: true,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                  final consultant =
                  consultantsController.searchedConsultants[index];
                  return ConsultantsWidget(consultantModel: consultant,  save: true, searchQuery: _searchController.text,);
                },
                ),
              );
          }),
        ],
      ),
    );
  }
}