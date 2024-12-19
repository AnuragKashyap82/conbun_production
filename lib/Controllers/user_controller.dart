import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user_model.dart';
import '../NotificationServices/notification_services.dart';
import '../Repository/user_repository.dart';
import '../utils/constant.dart';

class UserController extends GetxController {
  Rx<UserModel> userData = UserModel.empty().obs;
  Rx<UserModel> otherUserData = UserModel.empty().obs;
  static UserController get instance => Get.find();

  final isLoading = false.obs;
  final _userRepository = Get.put(UserRepository());
  RxString userWalletBalance = ''.obs;
  RxString totalDeposit = ''.obs;
  RxString totalPromotional = ''.obs;

  @override
  void onInit() {
    fetchUserData();
    fetchUserWalletBalance();
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdd = prefs.getString('id') ?? '';
    return userIdd;
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      String userId = await getUserId();
      if (userId != '') {
        final data = await _userRepository.fetchUserData(userId);
        isLoading.value = false;
        userData.value = data;
      }else{

      }
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }

  Future<void> fetchUserWalletBalance() async {
    try {
      isLoading.value = true;
      String userId = await getUserId();
      if (userId != '') {
        final data = await _userRepository.fetchUserWalletBalance(userId);
        isLoading.value = false;
        print("Anurag wallet balance kya hai${data['balance']}");
        userWalletBalance.value = data['balance'].toString();
        totalPromotional.value = data['totalPromotional'] != null? data['totalPromotional'].toString(): '0.0';
        totalDeposit.value = data['totalDeposit'] != null? data['totalDeposit'].toString(): '0.0';
      }else{

      }
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }

  Future<void> fetchOtherUserData(String userId) async {
    try {
      isLoading.value = true;
      final data = await _userRepository.fetchUserData(userId);
      isLoading.value = false;
      otherUserData.value = data;
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }


}
