import 'package:conbun_production/Models/faq_category_model.dart';
import 'package:conbun_production/Models/faq_model.dart';
import 'package:conbun_production/Repository/faq_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class FaqController extends GetxController {
  static FaqController get instance => Get.find();

  final isLoading = false.obs;
  final _faqRepository = Get.put(FaqRepository());
   RxString selectedIndex = '1'.obs;
   RxString selectedFaqIndex = '1'.obs;
  RxList<FaqCategoryModel> allFaqCategory = <FaqCategoryModel>[].obs;
  RxList<FaqModel> allFaq = <FaqModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchFaqCategory() async {
    try {
      isLoading.value = true;
      final faqCategory = await _faqRepository.getAllFaqCategory();
      allFaqCategory.assignAll(faqCategory);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFaq(String categoryId) async {
    try {
      isLoading.value = true;
      final faq = await _faqRepository.getAllFaq(categoryId);
      allFaq.assignAll(faq);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
