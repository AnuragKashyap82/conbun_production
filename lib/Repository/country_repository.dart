import 'dart:convert';
import 'package:conbun_production/Models/country_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class CountryRepository extends GetxController {
  static CountryRepository get instance => Get.find();

  Future<List<CountryModel>> getAllCountry() async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/world/getCountries'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> countryData = json.decode(response.body);
        final List<CountryModel> country = countryData
            .map((countryJson) => CountryModel.fromJson(countryJson))
            .toList();
        print('Response status code: ${country}');
        return country;
      } else {
        throw "Failed to load country: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
