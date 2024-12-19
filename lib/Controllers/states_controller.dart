import 'package:conbun_production/Models/states_model.dart';
import 'package:conbun_production/Repository/states_repository.dart';
import 'package:get/get.dart';


class StatesController extends GetxController {
  static StatesController get instance => Get.find();

  final isLoading = false.obs;
  final _statesRepository = Get.put(StatesRepository());
  RxList<StatesModel> allStates = <StatesModel>[].obs;
  RxList<StatesModel> searchedStates = <StatesModel>[].obs;

  RxBool isExpanded = false.obs; // To manage the state of the menu

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchStates(String countryId) async {
    try {
      isLoading.value = true;
      final serviceArea = await _statesRepository.getAllStates(countryId);
      allStates.assignAll(serviceArea);
      isLoading.value = false;

    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchStates(String queryText) async {
    searchedStates.value = allStates
        .where((country) =>
        country.name.toLowerCase().contains(queryText.toLowerCase()))
        .toList();
  }
}
