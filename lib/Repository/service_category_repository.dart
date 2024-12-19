import 'dart:convert';
import 'package:conbun_production/Models/service_category_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class ServiceCategoryRepository extends GetxController {
  static ServiceCategoryRepository get instance => Get.find();

  Future<List<ServiceCategoryModel>> getAllServiceCategory() async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/category/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> serviceCategoryData = json.decode(response.body);
        final List<ServiceCategoryModel> serviceCategory = serviceCategoryData
            .map((serviceCategoryJson) => ServiceCategoryModel.fromJson(serviceCategoryJson))
            .toList();
        print('Response status code: ${serviceCategory}');
        return serviceCategory;
      } else {
        throw "Failed to load serviceCategoryJson: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
