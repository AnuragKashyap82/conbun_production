import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';

class EditProfileApis extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isStateLoading = false.obs;
  RxBool isCityLoading = false.obs;
  RxString deviceToken = ''.obs;
  RxString deviceId = ''.obs;
  RxString countryId = ''.obs;
  RxString stateId = ''.obs;
  var cities = <Map<String, dynamic>>[].obs;

  Future<void> fetchStates(String stateId, String countryId) async {
    try {
      isCityLoading.value = true;
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/world/getCities'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: json.encode({
          'state_id': stateId,
          'country_id': countryId,
        }),
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Map<String, dynamic>> areas = List<Map<String, dynamic>>.from(data);
        cities.assignAll(areas);
        isCityLoading.value = false;
      } else {
        isCityLoading.value = false;
        print(response.body);
        throw Exception('Failed to load service areas');
      }
    } catch (e) {
      isCityLoading.value = false;
      print("Error fetching service areas: $e");
    }
  }

  Future updateProfile(
      String userid,
      String name,
      String gender,
      String city,
      String state,
      String country,
      String pinCode,
      String address,
      String email,
      ) async {
    isLoading.value = true;
    try {
      final apiUrl =
      Uri.parse('${Constant.baseUrl}api/users/data');

      final headers = {
        'Content-Type': 'application/json',
        'authtoken': Constant.authToken,
      };

      final data = {
        'userid': userid,
        'name': name,
        'gender': gender,
        'state': state,
        'city': city,
        'country': country,
        'pincode': pinCode,
        'address': address,
        'email': email,
      };
      final response = await http.post(
        apiUrl,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        Map<String, dynamic> responseBody = json.decode(response.body);
        return responseBody; // Data posted successfully
      } else {
        isLoading.value = false;
        print('HTTP Error: ${response.statusCode} ${response.body}');
        return "HTTP Error:${response.statusCode} ${response.body}"; // Data posting failed
      }
    } catch (error) {
      isLoading.value = false;
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }


  Future<void> uploadImage(String userId, XFile imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Constant.baseUrl}api/users/updateProfilePic'),
      );

      // Add the auth token to the headers
      request.headers['authtoken'] = Constant.authToken;

      // Add other fields and files to the request
      request.fields['userid'] = userId;
      request.files.add(await http.MultipartFile.fromPath(
        'file', imageFile.path,
        filename: path.basename(imageFile.path),
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Upload successful');
      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during image upload: $e');
    }
  }



}
