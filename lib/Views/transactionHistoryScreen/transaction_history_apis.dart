import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';

class TransactionHistoryApis extends GetxController {
  RxBool isLoading = false.obs;

  RxString currentTransactionAccountFilter = 'All'.obs;
  RxString currentTransactionRechargeFilter = 'All'.obs;
}
