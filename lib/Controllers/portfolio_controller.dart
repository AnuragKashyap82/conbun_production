import 'package:conbun_production/Models/portfolio_model.dart';
import 'package:conbun_production/Repository/portfolio_repository.dart';
import 'package:get/get.dart';

class PortfolioController extends GetxController {
  static PortfolioController get instance => Get.find();

  final isLoading = false.obs;
  final _portfolioRepository = Get.put(PortfolioRepository());
  RxList<PortfolioModel> allPortfolio = <PortfolioModel>[].obs;


  Future<void> fetchPortfolio(String consultantId) async {
    try {
      isLoading.value = true;
      final consultants = await _portfolioRepository.getPortfolio(consultantId);
      allPortfolio.clear();
      allPortfolio.assignAll(consultants);
      isLoading.value = false;
    } catch (e) {
      allPortfolio.clear();
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
