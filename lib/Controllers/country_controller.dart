import 'package:conbun_production/Repository/country_repository.dart';
import 'package:get/get.dart';

import '../Models/country_model.dart';

class CountryController extends GetxController {
  static CountryController get instance => Get.find();

  final isLoading = false.obs;
  final _countryRepository = Get.put(CountryRepository());
  RxList<CountryModel> allCountry = <CountryModel>[].obs;
  RxList<CountryModel> searchedCountry = <CountryModel>[].obs;

  RxBool isExpanded = false.obs; // To manage the state of the menu

  @override
  void onInit() {
    fetchCountry();
    super.onInit();
  }

  Future<void> fetchCountry() async {
    try {
      isLoading.value = true;
      final serviceArea = await _countryRepository.getAllCountry();
      allCountry.assignAll(serviceArea);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchCountry(String queryText) async {
    searchedCountry.value = allCountry
        .where((country) =>
        country.name.toLowerCase().contains(queryText.toLowerCase()))
        .toList();
  }
}
