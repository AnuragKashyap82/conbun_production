import 'package:conbun_production/Controllers/cities_controller.dart';
import 'package:conbun_production/Controllers/country_controller.dart';
import 'package:conbun_production/Controllers/states_controller.dart';
import 'package:conbun_production/Models/states_model.dart';
import 'package:conbun_production/Views/editProfileScreen/edit_profile_apis.dart';
import 'package:conbun_production/Views/profile_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../Controllers/user_controller.dart';
import '../../Models/country_model.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../bottomNavScreens/bottomNavScreen.dart';

class EditProfileScreen extends StatefulWidget {
  final String code;

  const EditProfileScreen({super.key, required this.code});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  StatesController statesController = Get.put(StatesController());
  CitiesController citiesController = Get.put(CitiesController());
  EditProfileApis editProfileApis = Get.put(EditProfileApis());
  CountryController countryController = Get.put(CountryController());
  UserController userController = Get.find();
  late String userId;

  DateTime _selectedDate = DateTime.now();

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdd = prefs.getString('id') ?? '';
    setState(() {
      userId = userIdd;
    });
  }

  TextEditingController _searchCountryController = TextEditingController();
  TextEditingController _searchStateController = TextEditingController();
  TextEditingController _searchCityController = TextEditingController();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _countryNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _genderNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  var selectedCountry = Rx<CountryModel?>(null);
  var selectedState = Rx<StatesModel?>(null);
  var selectedCity = Rx<StatesModel?>(null);

  Future<void> fetchUserData() async {
    if (userController.isLoading.value) {
    } else {
      _firstNameController.text = userController.userData().name ?? '';
      _countryNameController.text = userController.userData().country ?? '';
      _cityController.text = userController.userData().city ?? '';
      _stateController.text = userController.userData().state ?? '';
      _pinCodeController.text = userController.userData().pincode ?? '';
      _addressController.text = userController.userData().address ?? '';
      _genderNameController.text = userController.userData().gender ?? '';
      _emailController.text = userController.userData().email ?? '';
      _phoneController.text = userController.userData().phoneNumber ?? '';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    fetchUserData();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      barrierColor: Colors.transparent,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2101),
      keyboardType: TextInputType.datetime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(useMaterial3: true).copyWith(
            // Customize the overall theme of the dialog
            primaryColor: colorOrange,
            indicatorColor: colorOrange,
            dividerColor: colorOrange,
            focusColor: colorOrange,
            checkboxTheme: CheckboxThemeData(
                checkColor: WidgetStateColor.resolveWith(
              (states) => colorOrange,
            )),
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                    textStyle: WidgetStateProperty.resolveWith(
              (states) => const TextStyle(color: colorWhite),
            ))),
            cardTheme: const CardTheme(color: colorBlack),
            canvasColor: colorWhite,
            cardColor: colorWhite,
            highlightColor: colorOrange,
            secondaryHeaderColor: colorOrange,
            primaryColorLight: colorOrange,
            primaryColorDark: colorOrange,
            unselectedWidgetColor: colorOrange,
            inputDecorationTheme: InputDecorationTheme(
              focusColor: colorOrange,
              focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: colorOrange, // Change underline color
                  ),
                  borderRadius: BorderRadius.circular(0)),
            ),
            textSelectionTheme: const TextSelectionThemeData(
                selectionColor: colorOrange, selectionHandleColor: colorOrange),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: colorBackground,
              surfaceTintColor: colorBackground,
              headerHeadlineStyle: const TextStyle(
                  fontSize: 16, fontFamily: "Bold", color: colorBlack),
              dayStyle: const TextStyle(
                fontSize: 14,
                fontFamily: "SemiBold",
                color: colorBlack,
              ),
              rangePickerSurfaceTintColor: colorOrange,
              headerBackgroundColor: colorOrange,
              headerHelpStyle: const TextStyle(
                fontSize: 16,
                fontFamily: "SemiBold",
                color: colorBlack,
              ),
              todayBorder: const BorderSide(color: colorOrange),
              dayOverlayColor: WidgetStateColor.resolveWith(
                (states) => colorOrange,
              ),
              // dayBackgroundColor: WidgetStateColor.resolveWith((states) => colorOrange,),
              dayForegroundColor: WidgetStateColor.resolveWith(
                (states) => colorBlack,
              ),
            ),
          ),
          child: Container(
            color: Colors.transparent,
            // Change the background color of the dialog
            child: child!,
          ),
        );
      },
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        // _dateNameController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            if (widget.code == 'setting') {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BottomNavScreen(currentTab: 3),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0); // Starts from left
                    const end = Offset.zero; // Ends at the current position
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ProfileScreen(code: 'dashboard'),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0); // Starts from left
                    const end = Offset.zero; // Ends at the current position
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            }
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: () {
                  if (widget.code == 'setting') {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BottomNavScreen(currentTab: 3),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0); // Starts from left
                          const end =
                              Offset.zero; // Ends at the current position
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BottomNavScreen(currentTab: 0),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0); // Starts from left
                          const end =
                              Offset.zero; // Ends at the current position
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  }
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: colorViolet,
                  size: 20,
                )),
            title: const Text(
              "Edit Profile",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorViolet,
                  fontFamily: "SemiBold"),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProfileItems(
                hintText: 'Enter your Name',
                controller: _firstNameController,
                title: 'Your Name',
                inputType: TextInputType.name,
              ),
              EditProfileItems(
                hintText: 'Enter your Email',
                controller: _emailController,
                title: 'Email Id',
                inputType: TextInputType.emailAddress,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: colorSecondaryViolet,
                        fontFamily: "Bold",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() {
                      if (countryController.isLoading.value) {
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0)
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
                            child: DropdownButton2<CountryModel>(
                              // barrierColor: colorWhite
                              isExpanded: true,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: colorBlack,
                                fontFamily: "SemiBold",
                              ),
                              hint: Text(
                                userController.userData().country??'',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: colorBlack,
                                  fontFamily: "SemiBold",
                                ),
                              ),
                              items: countryController.allCountry
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
                              value: selectedCountry.value,
                              onChanged: (value) async {
                                await statesController.fetchStates(value!.id);
                                setState(() {
                                  selectedCountry.value = value;
                                  editProfileApis.countryId.value = value.id;
                                  _countryNameController.text = value.name;
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
                              dropdownSearchData: DropdownSearchData(
                                searchController: _searchCountryController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.fromBorderSide(BorderSide(
                                          color: const Color(0xffE6E6E6),
                                          width: 1)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: _searchCountryController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: colorBlack.withOpacity(0.5),
                                          fontFamily: "SemiBold",
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value!.name
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchValue.toLowerCase());
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  _searchCountryController.clear();
                                }
                              },
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
                    const Text(
                      'State',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: colorSecondaryViolet,
                          fontFamily: "Bold"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() {
                      if (statesController.isLoading.value) {
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
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0)
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
                            child: DropdownButton2<StatesModel>(
                              // barrierColor: colorWhite
                              isExpanded: true,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: colorBlack,
                                fontFamily: "SemiBold",
                              ),
                              hint: Text(
                                userController.userData().state??'',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: colorBlack,
                                  fontFamily: "SemiBold",
                                ),
                              ),
                              items: statesController.allStates
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
                              value: selectedState.value,
                              onChanged: (value) async {
                                await citiesController.fetchCites(
                                  editProfileApis.countryId.value,
                                  editProfileApis.stateId.value,
                                );
                                setState(() {
                                  selectedState.value = value;
                                  editProfileApis.stateId.value = value!.id;
                                  _stateController.text = value.name;
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
                              dropdownSearchData: DropdownSearchData(
                                searchController: _searchStateController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.fromBorderSide(BorderSide(
                                          color: const Color(0xffE6E6E6),
                                          width: 1)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: _searchStateController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: colorBlack.withOpacity(0.5),
                                          fontFamily: "SemiBold",
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value!.name
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchValue.toLowerCase());
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  _searchStateController.clear();
                                }
                              },
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
                    const Text(
                      'City',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: colorSecondaryViolet,
                          fontFamily: "Bold"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() {
                      if (citiesController.isLoading.value) {
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
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0)
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
                            child: DropdownButton2<StatesModel>(
                              // barrierColor: colorWhite
                              isExpanded: true,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: colorBlack,
                                fontFamily: "SemiBold",
                              ),
                              hint: Text(
                                userController.userData().city??'',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: colorBlack,
                                  fontFamily: "SemiBold",
                                ),
                              ),
                              items: citiesController.allCities
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
                              value: selectedCity.value,
                              onChanged: (value) async {
                                setState(() {
                                  selectedCity.value = value;
                                  _cityController.text = value!.name;
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
                              dropdownSearchData: DropdownSearchData(
                                searchController: _searchCityController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: colorWhite,
                                      border: Border.fromBorderSide(BorderSide(
                                          color: const Color(0xffE6E6E6),
                                          width: 1)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: _searchCityController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: colorBlack.withOpacity(0.5),
                                          fontFamily: "SemiBold",
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value!.name
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchValue.toLowerCase());
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  _searchCityController.clear();
                                }
                              },
                            ),
                          ),
                        );
                      }
                    }),
                    // Obx(() {
                    //   if (editProfileApis.isCityLoading.value) {
                    //     return ShimmerEffect(
                    //       baseColor: Colors.grey.shade300,
                    //       highlightColor: Colors.grey.shade100,
                    //       child: Container(
                    //         height: 44,
                    //         decoration: BoxDecoration(
                    //           color: colorWhite,
                    //           border: Border.all(
                    //               color: const Color(0xffE6E6E6), width: 1),
                    //           borderRadius: BorderRadius.circular(6),
                    //         ),
                    //         child: Row(
                    //           children: [
                    //             Expanded(
                    //               child: TextFormField(
                    //                 enabled: false,
                    //                 decoration: InputDecoration(
                    //                   hintText: "",
                    //                   border: InputBorder.none,
                    //                   errorBorder: InputBorder.none,
                    //                   disabledBorder: InputBorder.none,
                    //                   hintStyle: TextStyle(
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w200,
                    //                     color: Color(0xff343F52),
                    //                     fontFamily: "SemiBold",
                    //                   ),
                    //                   contentPadding: EdgeInsets.only(
                    //                       bottom: 16, right: 8, left: 8),
                    //                   enabledBorder: InputBorder.none,
                    //                   focusedBorder: InputBorder.none,
                    //                 ),
                    //               ),
                    //             ),
                    //             const Padding(
                    //               padding:
                    //                   EdgeInsets.symmetric(vertical: 6.0),
                    //               child: VerticalDivider(
                    //                 color: Color(0xffE6E6E6),
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(
                    //                       horizontal: 8.0)
                    //                   .copyWith(left: 0),
                    //               child: const Icon(
                    //                 Icons.keyboard_arrow_down,
                    //                 color: Color(0xffADACAC),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   } else {
                    //     return PopupMenuButton<int>(
                    //       padding: EdgeInsets.zero,
                    //       shadowColor: colorWhite,
                    //       surfaceTintColor: colorWhite,
                    //       color: colorWhite,
                    //       constraints: BoxConstraints(
                    //           minWidth: MediaQuery.of(context).size.width,
                    //           maxHeight: MediaQuery.of(context).size.width),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(4)),
                    //       itemBuilder: (context) =>
                    //           editProfileApis.cities.map((country) {
                    //         return PopupMenuItem<int>(
                    //             padding: EdgeInsets.zero,
                    //             onTap: () async {
                    //               setState(() {
                    //                 _cityController.text = country['name'];
                    //               });
                    //             },
                    //             child: Padding(
                    //               padding: EdgeInsets.all(8.0),
                    //               child: Text(
                    //                 country['name'],
                    //                 style: TextStyle(
                    //                     fontSize: 13,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: colorSecondaryViolet,
                    //                     fontFamily: "Bold"),
                    //               ),
                    //             ));
                    //       }).toList(),
                    //       child: Container(
                    //         height: 44,
                    //         decoration: BoxDecoration(
                    //           color: colorWhite,
                    //           border: Border.all(
                    //               color: const Color(0xffE7E7E7), width: 1),
                    //           borderRadius: BorderRadius.circular(6),
                    //         ),
                    //         child: Row(
                    //           children: [
                    //             Expanded(
                    //               child: TextFormField(
                    //                 controller: _cityController,
                    //                 enabled: false,
                    //                 style: const TextStyle(
                    //                     fontSize: 13,
                    //                     fontWeight: FontWeight.w200,
                    //                     color: colorBlack,
                    //                     fontFamily: "SemiBold"),
                    //                 keyboardType: TextInputType.phone,
                    //                 decoration: const InputDecoration(
                    //                     hintText: 'Select Your City',
                    //                     hintStyle: TextStyle(
                    //                         fontSize: 13,
                    //                         fontWeight: FontWeight.w200,
                    //                         color: Color(0xffADACAC),
                    //                         fontFamily: "SemiBold"),
                    //                     contentPadding: EdgeInsets.only(
                    //                         bottom: 8, right: 8, left: 8),
                    //                     enabledBorder: InputBorder.none,
                    //                     disabledBorder: InputBorder.none,
                    //                     focusedBorder: InputBorder.none),
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(
                    //                       horizontal: 8.0)
                    //                   .copyWith(left: 0),
                    //               child: const Icon(
                    //                 Icons.keyboard_arrow_down,
                    //                 size: 20,
                    //                 color: Color(0xffADACAC),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mobile Number',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: colorSecondaryViolet,
                          fontFamily: "Bold"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorWhite,
                        border: Border.all(
                            color: const Color(0xffE7E7E7), width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          CountryCodePicker(
                            onChanged: print,
                            backgroundColor: colorBackground,
                            padding: EdgeInsets.zero,
                            closeIcon: const Icon(
                              Icons.close,
                              color: colorOrange,
                            ),
                            boxDecoration: BoxDecoration(
                              boxShadow: const [],
                              color: colorBackground,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            showDropDownButton: false,
                            initialSelection: 'IN',
                            flagDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            favorite: const ['+91', 'US'],
                            searchStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: colorBlack,
                                fontFamily: "SemiBold"),
                            dialogTextStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: colorBlack,
                              fontFamily: "SemiBold",
                            ),
                            dialogBackgroundColor: colorBackground,
                            searchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                focusColor: colorOrange,
                                iconColor: colorOrange,
                                prefixIconColor: colorOrange,
                                hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    color: colorBlack.withOpacity(0.5),
                                    fontFamily: "Bold"),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26),
                                    borderSide: BorderSide(
                                        color: colorBlack.withOpacity(0.1))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26),
                                    borderSide:
                                        const BorderSide(color: colorOrange)),
                                hintText: 'Search Your Country Code',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      width: 1, color: colorBlack),
                                )),
                            dialogSize: Size.fromHeight(
                                MediaQuery.of(context).size.height * 0.7),
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: colorViolet,
                                fontFamily: "SemiBold"),
                            hideMainText: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0)
                                .copyWith(left: 0),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: colorBlack,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                  color: colorBlack,
                                  fontFamily: "SemiBold"),
                              decoration: const InputDecoration(
                                  enabled: false,
                                  hintText: 'Mobile No',
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xffADACAC),
                                      fontFamily: "SemiBold"),
                                  contentPadding: EdgeInsets.only(
                                      bottom: 8, right: 8, left: 8),
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              EditProfileItems(
                hintText: 'Enter your Pin Code',
                controller: _pinCodeController,
                title: 'Pin Code',
                inputType: TextInputType.number,
              ),
              EditProfileItems(
                hintText: 'Enter your address',
                controller: _addressController,
                title: 'Address',
                inputType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: colorSecondaryViolet,
                          fontFamily: "Bold"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PopupMenuButton<int>(
                      padding: EdgeInsets.zero,
                      shadowColor: colorWhite,
                      surfaceTintColor: colorWhite,
                      color: colorWhite,
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                            padding: EdgeInsets.zero,
                            onTap: () {
                              setState(() {
                                _genderNameController.text = "Male";
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Male",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: colorSecondaryViolet,
                                    fontFamily: "Bold"),
                              ),
                            )),
                        PopupMenuItem<int>(
                            padding: EdgeInsets.zero,
                            onTap: () {
                              setState(() {
                                _genderNameController.text = "Female";
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Female",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: colorSecondaryViolet,
                                    fontFamily: "Bold"),
                              ),
                            )),
                        PopupMenuItem<int>(
                            padding: EdgeInsets.zero,
                            onTap: () {
                              setState(() {
                                _genderNameController.text = "Prefer No To Say";
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Prefer No To Say",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: colorSecondaryViolet,
                                    fontFamily: "Bold"),
                              ),
                            )),
                      ],
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: colorWhite,
                          border: Border.all(
                              color: const Color(0xffE7E7E7), width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _genderNameController,
                                enabled: false,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    color: colorBlack,
                                    fontFamily: "SemiBold"),
                                decoration: const InputDecoration(
                                    hintText: 'Select Your Gender',
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w200,
                                        color: Color(0xffADACAC),
                                        fontFamily: "SemiBold"),
                                    contentPadding: EdgeInsets.only(
                                        bottom: 8, right: 8, left: 8),
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0)
                                      .copyWith(left: 0),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: Color(0xffADACAC),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Obx(() {
                return GestureDetector(
                  onTap: () async {
                    if (userId == '') {
                      showSnackBar("User Id Not Found", context);
                    } else if (_firstNameController.text.isEmpty) {
                      showSnackBar("Enter your First Name", context);
                    } else if (_emailController.text.isEmpty) {
                      showSnackBar("Enter your Email", context);
                    } else if (_countryNameController.text.isEmpty) {
                      showSnackBar("Select your Country", context);
                    } else if (_stateController.text.isEmpty) {
                      showSnackBar("Select your State", context);
                    } else if (_cityController.text.isEmpty) {
                      showSnackBar("Select your City", context);
                    } else if (_pinCodeController.text.isEmpty) {
                      showSnackBar("Enter your Pin Code", context);
                    } else if (_addressController.text.isEmpty) {
                      showSnackBar("Enter your Address", context);
                    } else if (_phoneController.text.isEmpty) {
                      showSnackBar("Enter your Phone Number", context);
                    } else if (_genderNameController.text.isEmpty) {
                      showSnackBar("Select your Gender", context);
                    } else {
                      final message = await editProfileApis.updateProfile(
                        userId,
                        _firstNameController.text.trim(),
                        _genderNameController.text.trim(),
                        _cityController.text.trim(),
                        _stateController.text.trim(),
                        _countryNameController.text.trim(),
                        _pinCodeController.text.trim(),
                        _addressController.text.trim(),
                        _emailController.text.trim(),
                      );
                      int error = message['Error'];
                      String msg = message['message'];
                      await userController.fetchUserData();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: colorWhite,
                              surfaceTintColor: colorWhite,
                              alignment: Alignment(0.0, 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                top: 10.0,
                              ),
                              insetPadding:
                                  EdgeInsets.symmetric(horizontal: 21),
                              content: Container(
                                height: 420,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/images/done.png'),
                                    SizedBox(
                                      height: 16,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Text(
                                      "Profile Updated",
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff677294),
                                          fontFamily: "Bold"),
                                    ),
                                    Text(
                                      msg,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9C9C9C),
                                          fontFamily: "SemiBold"),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 26,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        decoration: BoxDecoration(
                                            color: colorBlack,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Center(
                                          child: Text(
                                            "Done",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: colorWhite,
                                                fontFamily: "SemiBold"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: colorBlack,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                        child: userController.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: colorOrange,
                                ),
                              )
                            : editProfileApis.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colorOrange,
                                    ),
                                  )
                                : Text(
                                    'Update',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: colorWhite,
                                        fontFamily: "SemiBold"),
                                  )),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileItems extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;

  const EditProfileItems(
      {super.key,
      required this.title,
      required this.controller,
      required this.hintText,
      required this.inputType});

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
            height: 44,
            decoration: BoxDecoration(
              color: colorWhite,
              border: Border.all(color: const Color(0xffE7E7E7), width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
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
