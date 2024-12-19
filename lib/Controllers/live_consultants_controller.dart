import 'package:conbun_production/Models/live_consultant_model.dart';
import 'package:conbun_production/Repository/live_consultants_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiveConsultantsController extends GetxController {
  static LiveConsultantsController get instance => Get.find();

  final isLoading = false.obs;
  final _liveConsultantsRepository = Get.put(LiveConsultantsRepository());
  RxList<LiveConsultantModel> liveConsultant = <LiveConsultantModel>[].obs;

  @override
  void onInit() {
    fetchLiveConsultant();
    super.onInit();
  }
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string

    return userId;
  }

  Future<void> fetchLiveConsultant() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final consultants = await _liveConsultantsRepository.getLiveConsultants(userId);
      liveConsultant.assignAll(consultants);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
