import 'package:conbun_production/Models/priority_model.dart';
import 'package:conbun_production/Repository/priority_repository.dart';
import 'package:get/get.dart';

class PriorityController extends GetxController {
  static PriorityController get instance => Get.find();

  final isLoading = false.obs;
  final _countryRepository = Get.put(PriorityRepository());
  RxList<PriorityModel> allPriority = <PriorityModel>[].obs;

  @override
  void onInit() {
    fetchPriority();
    super.onInit();
  }

  Future<void> fetchPriority() async {
    try {
      isLoading.value = true;
      final priority = await _countryRepository.getAllPriority();
      allPriority.assignAll(priority);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
