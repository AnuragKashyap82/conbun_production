
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/notification_model.dart';
import '../Repository/notification_repository.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  final isLoading = false.obs;
  final _notificationRepository = Get.put(NotificationRepository());
  RxList<NotificationModel> allNotification = <NotificationModel>[].obs;

  @override
  void onInit() {
    fetchAllLeads();
    super.onInit();
  }
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string
    return userId;
  }

  Future<void> fetchAllLeads() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final leads = await _notificationRepository.getAllNotification(userId);
      allNotification.assignAll(leads);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
