import 'package:conbun_production/Models/department_model.dart';
import 'package:conbun_production/Repository/department_repository.dart';
import 'package:get/get.dart';

class DepartmentController extends GetxController {
  static DepartmentController get instance => Get.find();

  final isLoading = false.obs;
  final _countryRepository = Get.put(DepartmentRepository());
  RxList<DepartmentModel> allDepartment = <DepartmentModel>[].obs;

  @override
  void onInit() {
    fetchPriority();
    super.onInit();
  }

  Future<void> fetchPriority() async {
    try {
      isLoading.value = true;
      final department = await _countryRepository.getAllDepartment();
      allDepartment.assignAll(department);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
