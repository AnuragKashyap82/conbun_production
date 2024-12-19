import 'package:conbun_production/Models/transaction_account_model.dart';
import 'package:conbun_production/Repository/transaction_account_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionAccountController extends GetxController {
  static TransactionAccountController get instance => Get.find();

  final isLoading = false.obs;
  final _transactionAccountRepository = Get.put(TransactionAccountRepository());
  RxList<TransactionAccountModel> allTransactionAccount = <TransactionAccountModel>[].obs;
  RxList<TransactionAccountModel> creditTransactionAccount = <TransactionAccountModel>[].obs;
  RxList<TransactionAccountModel> debitTransactionAccount = <TransactionAccountModel>[].obs;

  @override
  void onInit() {
    fetchAllTransactionAccount();
    fetchCreditTransactionAccount();
    fetchDebitTransactionAccount();
    super.onInit();
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id') ?? ''; // Set default value as empty string

    return userId;
  }

  Future<void> fetchAllTransactionAccount() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionAccountRepository.getAllTransactionAccount(userId, "All", "100");
      allTransactionAccount.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchCreditTransactionAccount() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionAccountRepository.getAllTransactionAccount(
          userId, "Cr", "100");
      creditTransactionAccount.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchDebitTransactionAccount() async {
    try {
      isLoading.value = true;
      String userId = await getToken();
      final transactions = await _transactionAccountRepository.getAllTransactionAccount(
          userId, "Dr", "100");
      debitTransactionAccount.assignAll(transactions);
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
