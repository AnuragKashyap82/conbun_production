import 'package:conbun_production/Models/package_duration_model.dart';
import 'package:conbun_production/Repository/package_duration_repository.dart';
import 'package:get/get.dart';

class PackageDurationController extends GetxController {
  static PackageDurationController get instance => Get.find();

  final isLoading = false.obs;
  final _packageDurationRepository = Get.put(PackageDurationRepository());
  RxList<PackageDurationModel> packageDuration = <PackageDurationModel>[].obs;


  Future<void> fetchPackageDuration(String consultantId, String packageId) async {
    try {
      isLoading.value = true;
      final packages = await _packageDurationRepository.getPackagesDuration(consultantId, packageId);
      packageDuration.assignAll(packages);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
