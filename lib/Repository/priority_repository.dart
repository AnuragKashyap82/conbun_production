import 'dart:convert';
import 'package:conbun_production/Models/priority_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constant.dart';

class PriorityRepository extends GetxController {
  static PriorityRepository get instance => Get.find();

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string

    return userId;
  }
  Future<List<PriorityModel>> getAllPriority() async {
    try {

      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/tickets/getPriorities'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken,
        },
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> countryData = json.decode(response.body);
        final List<PriorityModel> priority = countryData
            .map((countryJson) => PriorityModel.fromJson(countryJson))
            .toList();
        print('Response status code: ${priority}');
        return priority;
      } else {
        throw "Failed to load invites: HTTP ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

}
