import 'package:conbun_production/Models/working_hour_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../Repository/working_hour_repository.dart';

class WorkingHourController extends GetxController {
  static WorkingHourController get instance => Get.find();

  final WorkingHourRepository _repository = Get.put(WorkingHourRepository());
  var schedules = <String, List<Schedule>>{}.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  RxBool isWorkingHourNull = false.obs;

  Future<void> fetchSchedules(String consultantId) async {
    try {
      isLoading(true);
      final response = await _repository.fetchSchedules(consultantId);

      if (response['status'] == true) {
        schedules.clear();
        schedules.value = response['data'] as Map<String, List<Schedule>>;
        errorMessage.value = '';
      } else {
        schedules.value = {};
        errorMessage.value = response['message'] as String;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      schedules.value = {};
    } finally {
      isLoading(false);
    }
  }


}
