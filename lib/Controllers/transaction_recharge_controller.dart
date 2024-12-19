import 'package:conbun_production/Models/transaction_recharge_model.dart';
import 'package:conbun_production/Repository/transaction_recharge_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionRechargeController extends GetxController {
  static TransactionRechargeController get instance => Get.find();

  final isLoading = false.obs;
  final _transactionRechargeRepository = Get.put(TransactionRechargeRepository());
  RxList<TransactionRechargeModel> allTransactionRecharge = <TransactionRechargeModel>[].obs;
  RxList<TransactionRechargeModel> initiateTransactionRecharge = <TransactionRechargeModel>[].obs;
  RxList<TransactionRechargeModel> pendingTransactionRecharge = <TransactionRechargeModel>[].obs;
  RxList<TransactionRechargeModel> successTransactionRecharge = <TransactionRechargeModel>[].obs;
  RxList<TransactionRechargeModel> failedTransactionRecharge = <TransactionRechargeModel>[].obs;
  RxList<TransactionRechargeModel> cancelledTransactionRecharge = <TransactionRechargeModel>[].obs;
  @override
  void onInit() {
    // fetchAllTransactionRecharge();
    // fetchInitiateTransactionRecharge();
    // fetchPendingTransactionRecharge();
    // fetchSuccessTransactionRecharge();
    // fetchFailedTransactionRecharge();
    // fetchCancelledTransactionRecharge();
    super.onInit();
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string

    return userId;
  }

  Future<void> fetchAllTransactionRecharge() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionRechargeRepository.getAllTransactionRecharge(userId, "All", "100");
      allTransactionRecharge.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchInitiateTransactionRecharge() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionRechargeRepository.getAllTransactionRecharge(
          userId, "Initiate", "100");
      initiateTransactionRecharge.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchPendingTransactionRecharge() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionRechargeRepository.getAllTransactionRecharge(
          userId, "Pending", "100");
      pendingTransactionRecharge.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchSuccessTransactionRecharge() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionRechargeRepository.getAllTransactionRecharge(
          userId, "Success", "100");
      successTransactionRecharge.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchFailedTransactionRecharge() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionRechargeRepository.getAllTransactionRecharge(
          userId, "Failed", "100");
      failedTransactionRecharge.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchCancelledTransactionRecharge() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionRechargeRepository.getAllTransactionRecharge(
          userId, "Cancelled", "100");
      cancelledTransactionRecharge.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
