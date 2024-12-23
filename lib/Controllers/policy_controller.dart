import 'package:conbun_production/Models/policy_model.dart';
import 'package:conbun_production/Repository/policy_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PolicyController extends GetxController {
  Rx<PolicyModel> policyData = PolicyModel.empty().obs;
  static PolicyController get instance => Get.find();

  final isLoading = false.obs;
  final _policyRepository = Get.put(PolicyRepository());

  @override
  void onInit() {

  }

  Future<void> fetchUserData(String policy) async {
    try {
      policyData.value = PolicyModel.empty();
      isLoading.value = true;
      final data = await _policyRepository.fetchPolicy(policy);
      isLoading.value = false;
      policyData.value = data;
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }
}
