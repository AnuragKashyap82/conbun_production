import 'package:get/get.dart';
import '../../../Controllers/consultants_controller.dart';
import '../../../Controllers/service_category_controller.dart';
import '../../../Controllers/slider_controller.dart';

class ConsultantApis extends GetxController {
  RxBool isLoading = false.obs;

  RxString currentFilter = 'All'.obs;

  Future<void> changeFilter(String filterName)  async{
    currentFilter.value = filterName;
  }


}
