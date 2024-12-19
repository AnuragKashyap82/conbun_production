import 'package:conbun_production/Models/coupon_model.dart';
import 'package:conbun_production/Repository/coupon_repository.dart';
import 'package:get/get.dart';

class CouponController extends GetxController {
  static CouponController get instance => Get.find();

  final isLoading = false.obs;
  final _couponsRepository = Get.put(CouponRepository());
  RxList<CouponModel> allCoupons = <CouponModel>[].obs;

  @override
  void onInit() {
    fetchAllCoupons();
    super.onInit();
  }

  Future<void> fetchAllCoupons() async {
    try {
      isLoading.value = true;

      final coupons = await _couponsRepository.getAllCoupon("0", "10");
      allCoupons.assignAll(coupons);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
