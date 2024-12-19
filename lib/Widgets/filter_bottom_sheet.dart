import 'package:conbun_production/Controllers/service_area_controller.dart';
import 'package:conbun_production/Controllers/service_category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../Views/searchConsultantScreen/search_consultant_apis.dart';
import '../utils/colors.dart';

class FilterBottomSheetItems extends StatefulWidget {
  const FilterBottomSheetItems({super.key});

  @override
  State<FilterBottomSheetItems> createState() => _FilterBottomSheetItemsState();

}

class _FilterBottomSheetItemsState extends State<FilterBottomSheetItems> {
  SearchConsultantApis searchConsultantApis = Get.find();
  ServiceCategoryController serviceCategoryController = Get.find();
  ServiceAreaController serviceAreaController = Get.put(ServiceAreaController());
  bool isChecked = false;
  bool isFeaturedChecked = false;
  late String selectedService = '';
  late String selectedCity = 'Select Your City';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCity = searchConsultantApis.selectedCity.value;
    if(searchConsultantApis.verified.value == "Yes"){
      isChecked = true;
    }else{
      isChecked = false;
    }
    if(searchConsultantApis.featured.value == "Yes"){
      isFeaturedChecked = true;
    }else{
      isFeaturedChecked = false;
    }
    selectedService = searchConsultantApis.currentFilter.value;
    selectedCity = searchConsultantApis.selectedCity.value;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: MediaQuery.of(context).size.width),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: ()async{
                          searchConsultantApis.clearFilter();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff677294),
                              fontFamily: "Bold"),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()async{
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: colorViolet, width: 0.5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                            child: Center(
                              child: const Text(
                                "Apply",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff677294),
                                    fontFamily: "Bold"),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffE5E5E5),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select City",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff343F52),
                      fontFamily: "Bold"),
                ),
                const SizedBox(
                  height: 6,
                ),
            Obx(() {
              if(serviceAreaController.isLoading.value){
                return  ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 39,
                    decoration: BoxDecoration(
                      color: colorWhite,
                      border: Border.all(color: const Color(0xffE6E6E6), width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: selectedCity,
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: Color(0xff343F52),
                                fontFamily: "SemiBold",
                              ),
                              contentPadding: EdgeInsets.only(bottom: 16, right: 8, left: 8),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: VerticalDivider(
                            color: Color(0xffE6E6E6),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(left: 0),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xffADACAC),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                 return PopupMenuButton<int>(
                  padding: EdgeInsets.zero,
                  shadowColor: colorWhite,
                  surfaceTintColor: colorWhite,
                  color: colorWhite,
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  itemBuilder: (context) => serviceAreaController.allServiceArea.map((city) {
                    return PopupMenuItem<int>(
                        padding: EdgeInsets.zero,
                        onTap: () {
                          setState(() {
                            selectedCity = city.name;
                            searchConsultantApis.selectedCity.value = city.name;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            city.name,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: colorSecondaryViolet,
                                fontFamily: "Bold"),
                          ),
                        ));
                  }).toList(),
                  child:
                  Container(
                    height: 39,
                    decoration: BoxDecoration(
                      color: colorWhite,
                      border: Border.all(color: const Color(0xffE6E6E6), width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: selectedCity,
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: Color(0xff343F52),
                                fontFamily: "SemiBold",
                              ),
                              contentPadding: EdgeInsets.only(bottom: 16, right: 8, left: 8),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: VerticalDivider(
                            color: Color(0xffE6E6E6),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(left: 0),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xffADACAC),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

            }),
                const SizedBox(
                  height: 26,
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffE5E5E5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "User Rating",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff343F52),
                      fontFamily: "Bold"),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          searchConsultantApis.selectedRating.value = "1";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: searchConsultantApis.selectedRating.value == '1'? colorBlack : Colors.transparent,
                            border: Border.all(
                              color: const Color(0xffE7E7E7),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child:  Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Center(
                            child: Text(
                              "1 Star",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: searchConsultantApis.selectedRating.value == '1'? colorWhite:Color(0xff6C6C6C),
                                  fontFamily: "Bold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          searchConsultantApis.selectedRating.value = "2";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: searchConsultantApis.selectedRating.value == '2'? colorBlack: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xffE7E7E7),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child:  Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Center(
                            child: Text(
                              "2 Star",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: searchConsultantApis.selectedRating.value == '2'?colorWhite:Color(0xff6C6C6C),
                                  fontFamily: "Bold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          searchConsultantApis.selectedRating.value = "3";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: searchConsultantApis.selectedRating.value == '3'? colorBlack: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xffE7E7E7),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child:  Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Center(
                            child: Text(
                              "3 Star",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: searchConsultantApis.selectedRating.value == '3'?colorWhite:Color(0xff6C6C6C),
                                  fontFamily: "Bold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {

                          searchConsultantApis.selectedRating.value = "4";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: searchConsultantApis.selectedRating.value == '4'? colorBlack: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xffE7E7E7),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child:  Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Center(
                            child: Text(
                              "4 Star",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: searchConsultantApis.selectedRating.value == '4'?colorWhite:Color(0xff6C6C6C),
                                  fontFamily: "Bold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          searchConsultantApis.selectedRating.value = "5";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: searchConsultantApis.selectedRating.value == '5'? colorBlack: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xffE7E7E7),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child:  Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Center(
                            child: Text(
                              "5 Star",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: searchConsultantApis.selectedRating.value == '5'?colorWhite:Color(0xff6C6C6C),
                                  fontFamily: "Bold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            color: Color(0xffE5E5E5),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Verified Certified",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff343F52),
                      fontFamily: "Bold"),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      side: BorderSide(color: Color(0xffE7E7E7)),
                      focusColor: colorOrange,
                      activeColor: colorOrange,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                          if(searchConsultantApis.verified.value == "Yes"){
                            searchConsultantApis.verified.value = "No";
                          }else{
                            searchConsultantApis.verified.value = "Yes";
                          }

                        });
                      },
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isChecked = !isChecked;
                          if(searchConsultantApis.verified.value == "Yes"){
                            searchConsultantApis.verified.value = "No";
                          }else{
                            searchConsultantApis.verified.value = "Yes";
                          }
                        });
                      },
                      child: const Text(
                        'Verified',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff6C6C6C),
                            fontFamily: "Bold"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffE5E5E5),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Featured",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff343F52),
                      fontFamily: "Bold"),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isFeaturedChecked,
                      side: BorderSide(color: Color(0xffE7E7E7)),
                      focusColor: colorOrange,
                      activeColor: colorOrange,
                      onChanged: (value) {
                        setState(() {
                          isFeaturedChecked = value!;
                          if(searchConsultantApis.featured.value == "Yes"){
                            searchConsultantApis.featured.value = "No";
                          }else{
                            searchConsultantApis.featured.value = "Yes";
                          }
                        });
                      },
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isFeaturedChecked = !isFeaturedChecked;
                          if(searchConsultantApis.featured.value == "Yes"){
                            searchConsultantApis.featured.value = "No";
                          }else{
                            searchConsultantApis.featured.value = "Yes";
                          }
                        });
                      },
                      child: const Text(
                        'Featured',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff6C6C6C),
                            fontFamily: "Bold"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffE5E5E5),
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Select Service Category",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff343F52),
                      fontFamily: "Bold"),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(() {
                  if (serviceCategoryController.isLoading.value) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: ShimmerEffect(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        height: 64,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffE5E5E5),
                                            borderRadius:
                                            BorderRadius.circular(3)),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/nine.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            Text(
                                              'Anurag',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontFamily: "Bold"),
                                            ),
                                          ],
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  final itemCount =  serviceCategoryController.allServiceCategory.length;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: GridView.builder(
                      itemCount: itemCount,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 40),
                      itemBuilder: (BuildContext context, int index) {
                        final serviceCategory =
                        serviceCategoryController.allServiceCategory[index];
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedService = serviceCategory.name;
                              searchConsultantApis.currentFilter.value = serviceCategory.name;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selectedService == serviceCategory.name ? colorBlack: Colors.transparent,
                                border: Border.all(
                                  color: const Color(0xffE7E7E7),
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child:  Center(
                              child: Text(
                                serviceCategory.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: selectedService == serviceCategory.name ? colorWhite:Color(0xff6C6C6C),
                                    fontFamily: "Bold"),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    color: colorBlack, borderRadius: BorderRadius.circular(4)),
                child: const Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorWhite,
                        fontFamily: "SemiBold"),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}