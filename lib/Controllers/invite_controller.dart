import 'package:conbun_production/Models/invite_model.dart';
import 'package:conbun_production/Repository/invite_repository.dart';
import 'package:get/get.dart';

class InviteController extends GetxController {
  static InviteController get instance => Get.find();

  final isLoading = false.obs;
  final _inviteRepository = Get.put(InviteRepository());
  Rx<ReferralData?> refrelData = Rx<ReferralData?>(null);

  RxBool isExpanded = false.obs; // To manage the state of the menu

  @override
  void onInit() {
    fetchAllInvites();
    super.onInit();
  }

  Future<void> fetchAllInvites() async {
    try {
      isLoading.value = true;
      final referralData = await _inviteRepository.getAllInvites();
      refrelData.value = referralData; // Assign the fetched data
    } catch (e) {
      print("Error fetching invites: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
