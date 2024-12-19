import 'dart:convert';
import 'package:conbun_production/Models/service_area_model.dart';
import 'package:conbun_production/Models/service_area_model.dart';
import 'package:conbun_production/Models/service_area_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class ServiceAreaRepository extends GetxController {
  static ServiceAreaRepository get instance => Get.find();

  Future<List<ServiceAreaModel>> getAllServiceArea() async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/servicearea/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> serviceAreaData = json.decode(response.body);
        final List<ServiceAreaModel> serviceArea = serviceAreaData
            .map((serviceCategoryJson) => ServiceAreaModel.fromJson(serviceCategoryJson))
            .toList();
        print('Response status code: ${serviceArea}');
        return serviceArea;
      } else {
        throw "Failed to load serviceArea: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
