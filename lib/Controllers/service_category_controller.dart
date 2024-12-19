import 'package:conbun_production/Models/service_category_model.dart';
import 'package:conbun_production/Repository/service_category_repository.dart';
import 'package:get/get.dart';

class ServiceCategoryController extends GetxController {
  static ServiceCategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _serviceCategoryRepository = Get.put(ServiceCategoryRepository());
  RxList<ServiceCategoryModel> allServiceCategory = <ServiceCategoryModel>[].obs;

  RxBool isExpanded = false.obs; // To manage the state of the menu

  @override
  void onInit() {
    fetchServiceCategory();
    super.onInit();
  }

  Future<void> fetchServiceCategory() async {
    try {
      isLoading.value = true;
      final serviceCategory = await _serviceCategoryRepository.getAllServiceCategory();
      serviceCategory.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
      allServiceCategory.assignAll(serviceCategory);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
