import 'package:conbun_production/Models/slider_model.dart';
import 'package:conbun_production/Repository/slider_repository.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  static SliderController get instance => Get.find();

  final isLoading = false.obs;
  final _sliderRepository = Get.put(SliderRepository());
  RxList<SliderModel> allSlider = <SliderModel>[].obs;

  @override
  void onInit() {
    fetchSliders();
    super.onInit();
  }

  Future<void> fetchSliders() async {
    try {
      isLoading.value = true;

      final sliders = await _sliderRepository.getAllSliders();
      sliders.sort((a, b) => a.order.compareTo(b.order));
      allSlider.assignAll(sliders);
      isLoading.value = false;


    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
