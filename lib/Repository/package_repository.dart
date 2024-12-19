import 'dart:convert';
import 'package:conbun_production/Models/package_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class PackageRepository extends GetxController {
  static PackageRepository get instance => Get.find();

  Future<List<PackageModel>> getAllPackages(String consultantId) async {
    try {
      final requestBody = {
        'consultantid': consultantId,
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/packages/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> package = json.decode(response.body)['data'];
        print(package)  ;
        final List<PackageModel> packages = package
            .map((packageDurationJson) => PackageModel.fromJson(packageDurationJson))
            .toList();
        print('Response status code: ${packages}');
        return packages;
      } else {
        throw "Failed to load packages: ${response.body}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

  Future<PackageModel> getAllLivePackage(String consultantId) async {
    try {
      final requestBody = {
        'consultantid': consultantId,
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
          Uri.parse('${Constant.baseUrl}api/packages/getLivePackages'),
          headers: {
            'Content-Type': 'application/json',
            'authtoken': Constant.authToken
          },
          body: requestBodyJson
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final package = json.decode(response.body)['data'][0];
        print(package)  ;

        print('Response status code: ${package}');
        return PackageModel.fromJson(package);
      } else {
        throw "Failed to load packages: ${response.body}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
