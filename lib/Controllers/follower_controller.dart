
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/followers_model.dart';
import '../Repository/follower_repository.dart';


class FollowerController extends GetxController {
  static FollowerController get instance => Get.find();

  final isLoading = false.obs;
  final _followerRepository = Get.put(FollowerRepository());
  RxList<FollowerModel> allFollowers = <FollowerModel>[].obs;

  @override
  void onInit() {
    fetchAllFollowers();
    super.onInit();
  }
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string

    return userId;
  }

  Future<void> fetchAllFollowers() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final leads = await _followerRepository.getAllFollowers(userId);
      allFollowers.assignAll(leads);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
      allFollowers.value = [];
    } finally {
      isLoading.value = false;
    }
  }
}
