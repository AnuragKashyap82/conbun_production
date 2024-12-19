import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/slider_model.dart';
import '../utils/constant.dart';

class SliderRepository extends GetxController {
  static SliderRepository get instance => Get.find();

  Future<List<SliderModel>> getAllSliders() async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}api/slider/slides'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> sliderData = json.decode(response.body);
        final List<SliderModel> slider = sliderData
            .map((sliderJson) => SliderModel.fromJson(sliderJson))
            .toList();
        print('Response status code: ${slider}');
        return slider;
      } else {
        throw "Failed to load slider: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}
