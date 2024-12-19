import 'package:conbun_production/Controllers/transaction_account_controller.dart';
import 'package:conbun_production/Views/transactionHistoryScreen/transaction_history_apis.dart';
import 'package:conbun_production/Widgets/transaction_filter_bottom_sheet.dart';
import 'package:conbun_production/Widgets/transaction_widget.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionAccountScreen extends StatefulWidget {
  const TransactionAccountScreen({super.key});

  @override
  State<TransactionAccountScreen> createState() =>
      _TransactionAccountScreenState();
}

class _TransactionAccountScreenState extends State<TransactionAccountScreen> {
  final TransactionAccountController transactionAccountController = Get.find();
  final TransactionHistoryApis transactionHistoryApis = Get.put(TransactionHistoryApis());

  @override
  void initState() {
    super.initState();
    transactionAccountController.fetchAllTransactionAccount();
    transactionAccountController.fetchCreditTransactionAccount();
    transactionAccountController.fetchDebitTransactionAccount();
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

  Map<String, List<dynamic>> _groupTransactionsByDate(List<dynamic> transactions) {
    Map<String, List<dynamic>> groupedTransactions = {};
    for (var transaction in transactions) {
      DateTime dateTime = DateTime.parse(transaction.dateCreated); // Parse the string to DateTime
      String date = formatDate(dateTime); // Format the DateTime to 'yyyy-MM-dd'
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
                        GestureDetector(
                          onTap: () {
                            transactionHistoryApis.currentTransactionAccountFilter.value = 'All';
                          },
                          child: Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: transactionHistoryApis.currentTransactionAccountFilter.value == 'All' ? colorBlack : colorWhite,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: const Color(0xffD9D9D9)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "SemiBold",
                                    color: transactionHistoryApis.currentTransactionAccountFilter.value == 'All' ? colorWhite : colorBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            transactionHistoryApis.currentTransactionAccountFilter.value = 'Credit';
                          },
                          child: Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: transactionHistoryApis.currentTransactionAccountFilter.value == 'Credit' ? colorBlack : colorWhite,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: const Color(0xffD9D9D9)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  "Credit",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "SemiBold",
                                    color: transactionHistoryApis.currentTransactionAccountFilter.value == 'Credit' ? colorWhite : colorBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            transactionHistoryApis.currentTransactionAccountFilter.value = 'Debit';
                          },
                          child: Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: transactionHistoryApis.currentTransactionAccountFilter.value == 'Debit' ? colorBlack : colorWhite,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: const Color(0xffD9D9D9)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  "Debit",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "SemiBold",
                                    color: transactionHistoryApis.currentTransactionAccountFilter.value == 'Debit' ? colorWhite : colorBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(width: 8),
              // GestureDetector(
              //   onTap: () {
              //     showModalBottomSheet(
              //       context: context,
              //       isScrollControlled: true,
              //       backgroundColor: Colors.transparent,
              //       builder: (BuildContext context) {
              //         return ClipRRect(
              //           borderRadius: const BorderRadius.only(
              //             topLeft: Radius.circular(25.0),
              //             topRight: Radius.circular(25.0),
              //           ),
              //           child: Container(
              //             padding: const EdgeInsets.symmetric(vertical: 16.0),
              //             constraints: BoxConstraints(
              //               maxHeight: MediaQuery.of(context).size.height * 0.9,
              //             ),
              //             decoration: const BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.only(
              //                 topLeft: Radius.circular(25.0),
              //                 topRight: Radius.circular(25.0),
              //               ),
              //             ),
              //             child: const TransactionFilterBottomSheetItems(),
              //           ),
              //         );
              //       },
              //     );
              //   },
              //   child: Icon(
              //     Icons.filter_alt_outlined,
              //     color: colorBlack,
              //   ),
              // ),
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
            if (transactionAccountController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorOrange,
                ),
              );
            }

            List<dynamic> transactions;
            switch (transactionHistoryApis.currentTransactionAccountFilter.value) {
              case 'Credit':
                transactions = transactionAccountController.creditTransactionAccount;
                break;
              case 'Debit':
                transactions = transactionAccountController.debitTransactionAccount;
                break;
              case 'All':
              default:
                transactions = transactionAccountController.allTransactionAccount;
                break;
            }

            if (transactions.isEmpty) {
              return Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Center(
                  child: Text(
                    transactionHistoryApis.currentTransactionAccountFilter.value == 'All'
                        ? "No Transaction"
                        : transactionHistoryApis.currentTransactionAccountFilter.value == 'Credit'
                        ? "No Credit Transaction"
                        : "No Debit Transaction",
                    style: TextStyle(
                      fontSize: 14,
                      color: colorBlack,
                    ),
                  ),
                ),
              );
            }

            final groupedTransactions = _groupTransactionsByDate(transactions);

            return ListView.builder(
              itemCount: groupedTransactions.keys.length,
              itemBuilder: (BuildContext context, int index) {
                String date = groupedTransactions.keys.elementAt(index);
                List<dynamic> dateTransactions = groupedTransactions[date]!;
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
                      itemCount: dateTransactions.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        final transactionAccount = dateTransactions[index];
                        return TransactionHistoryWidget(transactionAccountModel: transactionAccount);
                      },
                    ),
                  ],
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
