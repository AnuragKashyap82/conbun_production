import 'package:conbun_production/Repository/cities_repository.dart';
import 'package:get/get.dart';

import '../Models/states_model.dart';


class CitiesController extends GetxController {
  static CitiesController get instance => Get.find();

  final isLoading = false.obs;
  final _statesRepository = Get.put(CitiesRepository());
  RxList<StatesModel> allCities = <StatesModel>[].obs;
  RxList<StatesModel> searchedCities = <StatesModel>[].obs;

  RxBool isExpanded = false.obs; // To manage the state of the menu

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchCites(String countryId, String stateId) async {
    try {
      isLoading.value = true;
      final serviceArea = await _statesRepository.getAllStates(countryId, stateId);
      allCities.assignAll(serviceArea);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchStates(String queryText) async {
    searchedCities.value = allCities
        .where((country) =>
        country.name.toLowerCase().contains(queryText.toLowerCase()))
        .toList();
  }
}
