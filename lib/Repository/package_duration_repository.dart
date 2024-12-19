import 'dart:convert';
import 'package:conbun_production/Models/package_duration_model.dart';
import 'package:conbun_production/Models/package_duration_model.dart';
import 'package:conbun_production/Models/package_duration_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class PackageDurationRepository extends GetxController {
  static PackageDurationRepository get instance => Get.find();

  Future<List<PackageDurationModel>> getPackagesDuration(String consultantId, String packageId) async {
    try {
      final requestBody = {
        'consultantid': consultantId,
        'packageid': packageId,
      };
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/packages/getPackageDurations'),
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
        final List<PackageDurationModel> packages = package
            .map((packageDurationJson) => PackageDurationModel.fromJson(packageDurationJson))
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
}
