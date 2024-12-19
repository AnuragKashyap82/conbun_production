import 'package:conbun_production/Models/consultants_model.dart';
import 'package:conbun_production/Repository/consultants_repository.dart';
import 'package:get/get.dart';

class ConsultantsController extends GetxController {
  static ConsultantsController get instance => Get.find();

  final isLoading = false.obs;
  final _consultantsRepository = Get.put(ConsultantsRepository());
  RxList<ConsultantModel> topConsultants = <ConsultantModel>[].obs;
  RxList<ConsultantModel> filteredTopConsultants = <ConsultantModel>[].obs;
  RxList<ConsultantModel> featuredConsultants = <ConsultantModel>[].obs;
  RxList<ConsultantModel> searchedConsultants = <ConsultantModel>[].obs;

  @override
  void onInit() {
    fetchTopConsultants();
    fetchFeaturedConsultants();
    super.onInit();
  }

  Future<void> fetchTopConsultants() async {
    try {
      isLoading.value = true;
      final consultants = await _consultantsRepository.getTopConsultants();
      consultants.sort((b, a) => a.avgRating.compareTo(b.avgRating));
      topConsultants.assignAll(consultants);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFeaturedConsultants() async {
    try {
      isLoading.value = true;

      final consultants = await _consultantsRepository.getFeaturedConsultants();
      consultants.sort((b, a) => a.avgRating.compareTo(b.avgRating));
      featuredConsultants.assignAll(consultants);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getConsultantsByCategory(String category) async {
    if (category == 'All') {
      filteredTopConsultants.clear();
    } else {
      filteredTopConsultants.assignAll(topConsultants
          .where((consultant) => consultant.categories
              .toLowerCase()
              .contains(category.toLowerCase()))
          .toList());
    }
  }

  ///Search Consultant
  Future<void> searchConsultant(String queryText, String city, category,
      String featured, String verified, String rating) async {
    try {
      isLoading.value = true;
      searchedConsultants.clear();
      final searchedConsultant =
          await _consultantsRepository.getSearchConsultants(
              queryText, city, category, featured, verified, rating);
      searchedConsultants.assignAll(searchedConsultant);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  ///Save Search Consultants
  Future<String> saveSearchConsultant(
      String relId,
      String relType,
      String searchQuery
      ) async {
    try {
      final message =
      await _consultantsRepository.saveSearchHistory(
        relId, relType, searchQuery,);
      return message;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
