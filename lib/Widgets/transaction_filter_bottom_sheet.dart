import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Views/searchConsultantScreen/search_consultant_apis.dart';
import '../utils/colors.dart';

class TransactionFilterBottomSheetItems extends StatefulWidget {
  const TransactionFilterBottomSheetItems({super.key});

  @override
  State<TransactionFilterBottomSheetItems> createState() => _TransactionFilterBottomSheetItemsState();

}

class _TransactionFilterBottomSheetItemsState extends State<TransactionFilterBottomSheetItems> {
  bool isChecked = false;
  bool isFeaturedChecked = false;
  late String selectedRating = '';
  late String selectedService = '';
  late String selectedCity = 'Select Your City';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child:
              Column(
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
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: colorBlack.withOpacity(0.5),
                                  size: 24,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child:  Text(
                                  "Filter by",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: colorBlack,
                                      fontFamily: "Bold"),
                                ),
                              ),
                              GestureDetector(
                                onTap: ()async{
                                  // searchConsultantApis.clearFilter();
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Clear",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff677294),
                                      fontFamily: "Bold"),
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
                          "Status",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: colorBlack,
                              fontFamily: "Bold"),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedService = 'Entry Paid';
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selectedService == 'Entry Paid' ? colorBlack: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xffE7E7E7),
                                    ),
                                    borderRadius: BorderRadius.circular(100)),
                                child:  Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                  child: Center(
                                    child: Text(
                                      "Entry Paid",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: selectedService == 'Entry Paid' ? colorWhite:colorBlack,
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
                                  selectedService = 'Entry Refund';
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selectedService == 'Entry Refund' ? colorBlack: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xffE7E7E7),
                                    ),
                                    borderRadius: BorderRadius.circular(100)),
                                child:  Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                  child: Center(
                                    child: Text(
                                      "Entry Refund",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: selectedService == 'Entry Refund' ? colorWhite:colorBlack,
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
                                  selectedService = 'Offer Details';
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selectedService == 'Offer Details' ? colorBlack: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xffE7E7E7),
                                    ),
                                    borderRadius: BorderRadius.circular(100)),
                                child:  Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                  child: Center(
                                    child: Text(
                                      "Offer Details",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: selectedService == 'Offer Details' ? colorWhite: colorBlack,
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
                                  selectedService = 'Winning';
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selectedService == 'Winning' ? colorBlack: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xffE7E7E7),
                                    ),
                                    borderRadius: BorderRadius.circular(100)),
                                child:  Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                  child: Center(
                                    child: Text(
                                      "Winning",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: selectedService == 'Winning' ? colorWhite:colorBlack,
                                          fontFamily: "Bold"),
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
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xffE5E5E5),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                ],
              ),
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