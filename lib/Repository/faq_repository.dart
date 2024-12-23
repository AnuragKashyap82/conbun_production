import 'dart:convert';
import 'package:conbun_production/Models/faq_category_model.dart';
import 'package:conbun_production/Models/faq_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class FaqRepository extends GetxController {
  static FaqRepository get instance => Get.find();

  Future<List<FaqCategoryModel>> getAllFaqCategory() async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/faq/getFAQCategories'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> faqCategoryData = json.decode(response.body)['data'];
        print(faqCategoryData);
        final List<FaqCategoryModel> faqCategory = faqCategoryData
            .map((faqCategoryJson) => FaqCategoryModel.fromJson(faqCategoryJson))
            .toList();
        print('Response status code: ${faqCategory}');
        return faqCategory;
      } else {
        throw "Failed to load faqCategory: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<List<FaqModel>> getAllFaq(String categoryId) async {
    try {
      final requestBody = {"categoryid": categoryId};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/faq/getFAQs'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> faqData = json.decode(response.body)['data'];
        print(faqData);
        final List<FaqModel> faqCategory = faqData
            .map((faqJson) => FaqModel.fromJson(faqJson))
            .toList();
        print('Response status code: ${faqCategory}');
        return faqCategory;
      } else {
        return [];
        throw "Failed to load faq: ${response.statusCode}";
      }
    } catch (e) {
      return [];
      throw "Something went wrong: $e";
    }
  }
}
