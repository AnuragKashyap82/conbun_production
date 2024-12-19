import 'package:conbun_production/Models/service_area_model.dart';
import 'package:conbun_production/Repository/service_area_repository.dart';
import 'package:get/get.dart';

class ServiceAreaController extends GetxController {
  static ServiceAreaController get instance => Get.find();

  final isLoading = false.obs;
  final _serviceAreaRepository = Get.put(ServiceAreaRepository());
  RxList<ServiceAreaModel> allServiceArea = <ServiceAreaModel>[].obs;

  RxBool isExpanded = false.obs; // To manage the state of the menu

  @override
  void onInit() {
    fetchServiceCategory();
    super.onInit();
  }

  Future<void> fetchServiceCategory() async {
    try {
      isLoading.value = true;
      final serviceArea = await _serviceAreaRepository.getAllServiceArea();
      allServiceArea.assignAll(serviceArea);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
