import 'dart:convert';
import 'package:conbun_production/Models/states_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class StatesRepository extends GetxController {
  static StatesRepository get instance => Get.find();

  Future<List<StatesModel>> getAllStates(String countryId) async {
    try {
      final requestBody = {
        "country_id": countryId
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/world/getStates'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> countryData = json.decode(response.body);
        final List<StatesModel> country = countryData
            .map((countryJson) => StatesModel.fromJson(countryJson))
            .toList();
        print('Response status code: ${country}');
        return country;
      } else {
        throw "Failed to load states: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
