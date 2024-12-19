import 'package:conbun_production/Models/package_model.dart';
import 'package:get/get.dart';

import '../Repository/package_repository.dart';

class PackageController extends GetxController {
  static PackageController get instance => Get.find();

  final isLoading = false.obs;
  final _packageRepository = Get.put(PackageRepository());
  RxList<PackageModel> allPackages = <PackageModel>[].obs;
  Rx<PackageModel> allLivePackages = PackageModel(id: '', name: '').obs;


  Future<void> fetchAllPackages(String consultantId) async {
    try {
      isLoading.value = true;
      final packages = await _packageRepository.getAllPackages(consultantId);
      allPackages.assignAll(packages);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllLivePackages(String consultantId) async {
    try {
      isLoading.value = true;
      final packages = await _packageRepository.getAllLivePackage(consultantId);
      allLivePackages.value = packages;
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }


}
