import 'dart:convert';
import 'package:conbun_production/Models/portfolio_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class PortfolioRepository extends GetxController {
  static PortfolioRepository get instance => Get.find();

  Future<List<PortfolioModel>> getPortfolio(String consultantId) async {
    try {
      final requestBody = {"consultantid": consultantId, "start": "0", "limit": "10",};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/portfolio/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');
      print('Response status code getAllPortfolio: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> portfolioData = json.decode(response.body);
        final List<PortfolioModel> allPortfolio = portfolioData
            .map((portfolioJson) => PortfolioModel.fromJson(portfolioJson))
            .toList();
        print('Response status code: ${allPortfolio}');
        return allPortfolio;
      } else {
        throw "Failed to load allPortfolio Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

}

