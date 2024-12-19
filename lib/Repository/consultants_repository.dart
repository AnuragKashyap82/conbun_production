import 'dart:convert';
import 'package:conbun_production/Models/consultants_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class ConsultantsRepository extends GetxController {
  static ConsultantsRepository get instance => Get.find();

  Future<List<ConsultantModel>> getTopConsultants() async {
    try {
      final requestBody = {"category": "All", "start": 0, "limit": 10};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/consultants/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> consultantsData = json.decode(response.body);
        final List<ConsultantModel> topConsultants = consultantsData
            .map((consultantsJson) => ConsultantModel.fromJson(consultantsJson))
            .toList();
        print('Response status code: ${topConsultants}');
        return topConsultants;
      } else {
        throw "Failed to load Consultants Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<List<ConsultantModel>> getFeaturedConsultants() async {
    try {
      final requestBody = {"category": "All", "start": 0, "limit": 10};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/consultants/getFeaturedConsultants'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> consultantsData = json.decode(response.body);
        final List<ConsultantModel> featuredConsultants = consultantsData
            .map((consultantsJson) => ConsultantModel.fromJson(consultantsJson))
            .toList();
        print('Response status code: ${featuredConsultants}');
        return featuredConsultants;
      } else {
        throw "Failed to load featuredConsultants Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<List<ConsultantModel>> getSearchConsultants(
      String queryText,
      String city,
      category,
      String featured,
      String verified,
      String rating,
      ) async {
    try {
      final requestBody = {
        "q": queryText,
        "city": city,
        "category": category,
        "featured": featured,
        "verified": verified,
        "rating": rating,
        "start": "0",
        "limit": "10"
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/search/find'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> consultantsData = json.decode(response.body);
        final List<ConsultantModel> searchedConsultants = consultantsData
            .map((consultantsJson) => ConsultantModel.fromJson(consultantsJson))
            .toList();
        print('Response status code: $searchedConsultants');
        return searchedConsultants;
      } else {
        throw "Failed to load searchConsultant Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<String> saveSearchHistory(
      String relId,
      String relType,
      String searchQuery
      ) async {
    try {
      final requestBody = {
        "rel_id": relId,
        "rel_type": relType,
        "search_query": searchQuery
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/search/saveSearchHistory'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        throw "Failed to load searchConsultant Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
