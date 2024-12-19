import 'dart:convert';
import 'package:conbun_production/Models/coupon_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class CouponRepository extends GetxController {
  static CouponRepository get instance => Get.find();

  Future<List<CouponModel>> getAllCoupon(String start, String limit) async {
    try {
      final requestBody = {"start": start, "limit": limit};
      final String requestBodyJson = jsonEncode(requestBody);
      final response = await http.post(
        Uri.parse('${Constant.baseUrl}api/coupons/get'),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': Constant.authToken
        },
        body: requestBodyJson,
      );
      print('Response status code: ${response.statusCode}');
      print('Response status code getAllCoupon: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> couponData = json.decode(response.body)['data'];
        final List<CouponModel> coupon = couponData
            .map((couponJson) => CouponModel.fromJson(couponJson))
            .toList();
        print('Response status code: ${coupon}');
        return coupon;
      } else {
        throw "Failed to load coupon Json: ${response.statusCode}";
      }
    } catch (e) {
      throw "Something went wrong: $e";
    }
  }
}

