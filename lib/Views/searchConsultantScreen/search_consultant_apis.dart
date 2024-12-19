import 'package:get/get.dart';

class SearchConsultantApis extends GetxController {
  RxBool isLoading = false.obs;

  RxString currentFilter = 'All'.obs;
  RxString selectedCity = ''.obs;
  RxString selectedRating = ''.obs;
  RxString verified = ''.obs;
  RxString featured = ''.obs;


  Future<void> clearFilter() async{
    currentFilter.value = 'All';
    selectedCity.value = '';
    selectedRating.value = '';
    verified.value = '';
    featured.value = '';
  }



}
