import 'package:conbun_production/Controllers/department_controller.dart';
import 'package:conbun_production/Controllers/priority_controller.dart';
import 'package:conbun_production/Models/department_model.dart';
import 'package:conbun_production/Models/priority_model.dart';
import 'package:conbun_production/Views/supportCenter/ad_ticket_apis.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../Controllers/support_ticket_controller.dart';
import '../../utils/colors.dart';

class AddTicketsScreen extends StatefulWidget {
  const AddTicketsScreen({super.key});

  @override
  State<AddTicketsScreen> createState() => _AddTicketsScreenState();
}

class _AddTicketsScreenState extends State<AddTicketsScreen> {
  TextEditingController _messageController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  PriorityController priorityController = Get.put(PriorityController());
  DepartmentController departmentController = Get.put(DepartmentController());
  AddTicketApis addTicketApis = Get.put(AddTicketApis());
  var selectedPriority = Rx<PriorityModel?>(null);
  var selectedDepartment = Rx<DepartmentModel?>(null);

  SupportTicketController supportTicketController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            title: Text(
              "Add Ticket",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "MontserratBold",
                color: colorViolet,
              ),
            ),
            centerTitle: false,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: colorViolet,
                  size: 20,
                )),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddTicketFormField(
                title: 'Subject',
                controller: _subjectController,
                hintText: 'Enter Subject',
                inputType: TextInputType.text,
                maxLines: 1),
            AddTicketFormField(
              title: 'Message',
              controller: _messageController,
              hintText: 'Enter Message',
              inputType: TextInputType.text,
              maxLines: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Priority',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: colorSecondaryViolet,
                        fontFamily: "Bold"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    if (priorityController.isLoading.value) {
                      return ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 39,
                          decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(
                                color: const Color(0xffE6E6E6), width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: "",
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xff343F52),
                                      fontFamily: "SemiBold",
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        bottom: 16, right: 8, left: 8),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .copyWith(left: 0),
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xffADACAC),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: 44,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: colorWhite,
                          border: Border.all(
                              color: const Color(0xffE7E7E7), width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<PriorityModel>(
                            // barrierColor: colorWhite
                            isExpanded: true,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: colorBlack,
                              fontFamily: "SemiBold",
                            ),
                            hint: Text(
                              'Select Proirity',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: colorBlack,
                                fontFamily: "SemiBold",
                              ),
                            ),
                            items: priorityController.allPriority
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: colorBlack,
                                          fontFamily: "SemiBold",
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedPriority.value,
                            onChanged: (value) async {
                              setState(() {
                                selectedPriority.value = value;
                                addTicketApis.priorityId.value =
                                    value!.priorityId;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            dropdownStyleData: const DropdownStyleData(
                                maxHeight: 400,
                                decoration: BoxDecoration(color: colorWhite)),
                            iconStyleData: IconStyleData(
                                openMenuIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 20,
                                    color: Color(0xffADACAC),
                                  ),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Color(0xffADACAC),
                                  ),
                                )),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Department',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: colorSecondaryViolet,
                        fontFamily: "Bold"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    if (departmentController.isLoading.value) {
                      return ShimmerEffect(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 39,
                          decoration: BoxDecoration(
                            color: colorWhite,
                            border: Border.all(
                                color: const Color(0xffE6E6E6), width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: "",
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xff343F52),
                                      fontFamily: "SemiBold",
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        bottom: 16, right: 8, left: 8),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .copyWith(left: 0),
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xffADACAC),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: 44,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: colorWhite,
                          border: Border.all(
                              color: const Color(0xffE7E7E7), width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<DepartmentModel>(
                            // barrierColor: colorWhite
                            isExpanded: true,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: colorBlack,
                              fontFamily: "SemiBold",
                            ),
                            hint: Text(
                              'Select Department',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: colorBlack,
                                fontFamily: "SemiBold",
                              ),
                            ),
                            items: departmentController.allDepartment
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: colorBlack,
                                          fontFamily: "SemiBold",
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedDepartment.value,
                            onChanged: (value) async {
                              setState(() {
                                selectedDepartment.value = value;
                                addTicketApis.departmentId.value =
                                    value!.departmentId;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            dropdownStyleData: const DropdownStyleData(
                                maxHeight: 400,
                                decoration: BoxDecoration(color: colorWhite)),
                            iconStyleData: IconStyleData(
                                openMenuIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 20,
                                    color: Color(0xffADACAC),
                                  ),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Color(0xffADACAC),
                                  ),
                                )),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 8,
              ),
            ),
            Obx((){
              return Center(
                child: GestureDetector(
                  onTap: () async {
                    addTicketApis.isLoading.value = true;
                    if (_subjectController.text.trim().isEmpty) {
                      showSnackBar('Enter Subject', context);
                    } else if (_messageController.text.trim().isEmpty) {
                      showSnackBar('Enter Message', context);
                    } else if (addTicketApis.priorityId.value.isEmpty) {
                      showSnackBar('Select Priority', context);
                    } else if (addTicketApis.departmentId.value.isEmpty) {
                      showSnackBar('Select Department', context);
                    } else {
                      final response = await addTicketApis.addTicket(
                        _subjectController.text.trim(),
                        addTicketApis.departmentId.value,
                        _messageController.text.trim(),
                        addTicketApis.priorityId.value,
                      );
                      showSnackBar(response['message'].toString(), context);
                      await supportTicketController.fetchAllTickets();
                      addTicketApis.isLoading.value = false;
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        color: colorBlack,
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: addTicketApis.isLoading.value
                          ? CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorOrange,
                      )
                          : Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorWhite,
                            fontFamily: "SemiBold"),
                      ),
                    ),
                  )
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class AddTicketFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final int maxLines;

  const AddTicketFormField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.inputType,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: maxLines,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: colorSecondaryViolet,
                fontFamily: "Bold"),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: colorWhite,
              border: Border.all(color: const Color(0xffE7E7E7), width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              maxLines: maxLines,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                  color: colorBlack,
                  fontFamily: "SemiBold"),
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w200,
                      color: Color(0xffADACAC),
                      fontFamily: "SemiBold"),
                  contentPadding:
                      const EdgeInsets.only(bottom: 8, right: 8, left: 8),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
