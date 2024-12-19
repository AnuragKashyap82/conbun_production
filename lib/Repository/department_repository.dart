import 'dart:convert';
import 'package:conbun_production/Models/department_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class DepartmentRepository extends GetxController {
  static DepartmentRepository get instance => Get.find();

  Future<List<DepartmentModel>> getAllDepartment() async {
    try {

      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/tickets/getDepartments'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken,
        },
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> countryData = json.decode(response.body);
        final List<DepartmentModel> department = countryData
            .map((countryJson) => DepartmentModel.fromJson(countryJson))
            .toList();
        print('Response status code: ${department}');
        return department;
      } else {
        throw "Failed to load invites: HTTP ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }

}
