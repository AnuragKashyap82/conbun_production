import 'package:conbun_production/Controllers/transaction_recharge_controller.dart';
import 'package:conbun_production/Views/transactionHistoryScreen/transaction_history_apis.dart';
import 'package:conbun_production/Widgets/transaction_history_recharge_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Widgets/transaction_filter_bottom_sheet.dart';
import '../../utils/colors.dart';

class TransactionRechargeScreen extends StatefulWidget {
  const TransactionRechargeScreen({super.key});

  @override
  State<TransactionRechargeScreen> createState() =>
      _TransactionRechargeScreenState();
}

class _TransactionRechargeScreenState extends State<TransactionRechargeScreen> {
  TransactionRechargeController transactionRechargeController = Get.find();
  TransactionHistoryApis transactionHistoryApis = Get.put(TransactionHistoryApis());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactionRechargeController.fetchAllTransactionRecharge();
    transactionRechargeController.fetchSuccessTransactionRecharge();
    transactionRechargeController.fetchFailedTransactionRecharge();
    transactionRechargeController.fetchPendingTransactionRecharge();
    transactionRechargeController.fetchInitiateTransactionRecharge();
    transactionRechargeController.fetchCancelledTransactionRecharge();

  }

  String formatDate(DateTime dateString) {
    String day = DateFormat('dd').format(dateString);
    String suffix = 'th';

    if (day.endsWith('1') && !day.endsWith('11')) {
      suffix = 'st';
    } else if (day.endsWith('2') && !day.endsWith('12')) {
      suffix = 'nd';
    } else if (day.endsWith('3') && !day.endsWith('13')) {
      suffix = 'rd';
    }

    String formattedDate = DateFormat("dd'$suffix' MMM yyyy").format(dateString);
    return formattedDate;
  }

  Map<String, List<dynamic>> groupTransactionsByDate(List<dynamic> transactions) {
    Map<String, List<dynamic>> groupedTransactions = {};
    for (var transaction in transactions) {
      DateTime dateTime = DateTime.parse(transaction.dateRecorded);
      String date = formatDate(dateTime);
      if (!groupedTransactions.containsKey(date)) {
        groupedTransactions[date] = [];
      }
      groupedTransactions[date]!.add(transaction);
    }
    return groupedTransactions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        filterOption('All'),
                        filterOption('Success'),
                        filterOption('Pending'),
                        filterOption('Failed'),
                        filterOption('Initiate'),
                        filterOption('Cancelled'),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              // GestureDetector(
              //     onTap: () {
              //       showModalBottomSheet(
              //         context: context,
              //         isScrollControlled: true,
              //         backgroundColor: Colors.transparent,
              //         builder: (BuildContext context) {
              //           return ClipRRect(
              //             borderRadius: const BorderRadius.only(
              //               topLeft: Radius.circular(25.0),
              //               topRight: Radius.circular(25.0),
              //             ),
              //             child: Container(
              //               padding: const EdgeInsets.symmetric(vertical: 16.0),
              //               constraints: BoxConstraints(
              //                   maxHeight:
              //                   MediaQuery.of(context).size.height * 0.9),
              //               decoration: const BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(25.0),
              //                   topRight: Radius.circular(25.0),
              //                 ),
              //               ),
              //               child: TransactionFilterBottomSheetItems(),
              //             ),
              //           );
              //         },
              //       );
              //     },
              //     child: Icon(
              //       Icons.filter_alt_outlined,
              //       color: colorBlack,
              //     ))
            ],
          ),
        ),
        Divider(
          height: 0,
          color: Colors.grey.shade400,
          thickness: 0.5,
        ),
        Expanded(
          child: Obx(() {
            if (transactionRechargeController.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorOrange,
                  ));
            }
            if (transactionRechargeController.allTransactionRecharge.isEmpty) {
              return Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.7),
                child: Center(
                  child: Text(
                    "No Transaction",
                    style: TextStyle(
                      fontSize: 14,
                      color: colorBlack,
                    ),
                  ),
                ),
              );
            }
            if (transactionHistoryApis.currentTransactionRechargeFilter.value == 'Success' &&
                transactionRechargeController.successTransactionRecharge.isEmpty) {
              return emptyStateMessage("No Success Transaction");
            }
            if (transactionHistoryApis.currentTransactionRechargeFilter.value == 'Pending' &&
                transactionRechargeController.pendingTransactionRecharge.isEmpty) {
              return emptyStateMessage("No Pending Transaction");
            }
            if (transactionHistoryApis.currentTransactionRechargeFilter.value == 'Failed' &&
                transactionRechargeController.failedTransactionRecharge.isEmpty) {
              return emptyStateMessage("No Failed Transaction");
            }
            if (transactionHistoryApis.currentTransactionRechargeFilter.value == 'Initiate' &&
                transactionRechargeController.initiateTransactionRecharge.isEmpty) {
              return emptyStateMessage("No Initiate Transaction");
            }
            if (transactionHistoryApis.currentTransactionRechargeFilter.value == 'Cancelled' &&
                transactionRechargeController.cancelledTransactionRecharge.isEmpty) {
              return emptyStateMessage("No Cancelled Transaction");
            }

            // Group transactions by date
            List<dynamic> transactions = getFilteredTransactions();
            Map<String, List<dynamic>> groupedTransactions = groupTransactionsByDate(transactions);

            return ListView(
              shrinkWrap: true,
              primary: false,
              children: groupedTransactions.entries.map((entry) {
                String date = entry.key;
                List<dynamic> transactions = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xffEBEBEB)
                      ),
                      child:   Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: colorBlack,
                                  fontFamily: "SemiBold"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      itemCount: transactions.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        final transactionAccount = transactions[index];
                        return TransactionHistoryRechargeWidget(transactionRechargeModel: transactionAccount);
                      },
                    ),
                  ],
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }

  // Filter option widget
  Widget filterOption(String filter) {
    return GestureDetector(
      onTap: () {
        transactionHistoryApis.currentTransactionRechargeFilter.value = filter;
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          height: 24,
          decoration: BoxDecoration(
            color: transactionHistoryApis.currentTransactionRechargeFilter.value == filter
                ? colorBlack
                : colorWhite,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: const Color(0xffD9D9D9)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w200,
                  fontFamily: "SemiBold",
                  color: transactionHistoryApis.currentTransactionRechargeFilter.value == filter
                      ? colorWhite
                      : colorBlack,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Empty state message widget
  Widget emptyStateMessage(String message) {
    return Container(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.7),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: colorBlack,
          ),
        ),
      ),
    );
  }

  // Get filtered transactions
  List<dynamic> getFilteredTransactions() {
    switch (transactionHistoryApis.currentTransactionRechargeFilter.value) {
      case 'Success':
        return transactionRechargeController.successTransactionRecharge;
      case 'Pending':
        return transactionRechargeController.pendingTransactionRecharge;
      case 'Failed':
        return transactionRechargeController.failedTransactionRecharge;
      case 'Initiate':
        return transactionRechargeController.initiateTransactionRecharge;
      case 'Cancelled':
        return transactionRechargeController.cancelledTransactionRecharge;
      case 'All':
      default:
        return transactionRechargeController.allTransactionRecharge;
    }
  }
}
