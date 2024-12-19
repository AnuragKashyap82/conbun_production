import 'package:conbun_production/Models/transaction_recharge_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class TransactionHistoryRechargeWidget extends StatefulWidget {
  final TransactionRechargeModel transactionRechargeModel;
  const TransactionHistoryRechargeWidget({super.key, required this.transactionRechargeModel});

  @override
  State<TransactionHistoryRechargeWidget> createState() => _TransactionHistoryRechargeWidgetState();
}

class _TransactionHistoryRechargeWidgetState extends State<TransactionHistoryRechargeWidget> {

  String date = '';
  String dateTimeee = '';

  String formatDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat("dd MMM, yyyy hh:mm a").format(dateTime);
    setState(() {
      dateTimeee = formattedDate;
    });
    return formattedDate;
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String day = DateFormat('dd').format(dateTime);
    String suffix = 'th';

    if (day.endsWith('1') && !day.endsWith('11')) {
      suffix = 'st';
    } else if (day.endsWith('2') && !day.endsWith('12')) {
      suffix = 'nd';
    } else if (day.endsWith('3') && !day.endsWith('13')) {
      suffix = 'rd';
    }

    String formattedDate = DateFormat("dd'$suffix' MMM yyyy").format(dateTime);
    setState(() {
      date = formattedDate;
    });
    return formattedDate;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formatDate(widget.transactionRechargeModel.dateRecorded);
    formatDateTime(widget.transactionRechargeModel.dateRecorded);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   decoration: const BoxDecoration(
          //       color: Color(0xffEBEBEB)
          //   ),
          //   child:   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           date,
          //           style: TextStyle(
          //               fontSize: 12,
          //               fontWeight: FontWeight.w800,
          //               color: colorBlack,
          //               fontFamily: "SemiBold"),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 27,
                      width: 27,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffE7E7E7)),
                          shape: BoxShape.circle
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/recharge.svg',
                          width: 11,
                          height: 11,
                          color: colorBlack,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recharge ${widget.transactionRechargeModel.status}',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: colorBlack,
                              fontFamily: "SemiBold"),
                        ),
                        Text(
                          dateTimeee,
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffA4A4A4),
                              fontFamily: "SemiBold"),
                        ),
                      ],
                    )
                  ],
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text(
                       '+',
                       style: TextStyle(
                           fontSize: 11,
                           fontWeight: FontWeight.w600,
                           color: colorBlack,
                           fontFamily: "SemiBold"),
                     ),
                     Text(
                      '₹${widget.transactionRechargeModel.amount}',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorBlack,
                          fontFamily: "SemiBold"),
                                     ),
                   ],
                 ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Divider(
          //     color: Color(0xffE3E3E3),
          //     thickness: 0.8,
          //   ),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Container(
          //             height: 27,
          //             width: 27,
          //             decoration: BoxDecoration(
          //                 border: Border.all(color: const Color(0xffE7E7E7)),
          //                 shape: BoxShape.circle
          //             ),
          //             child: Center(
          //                 child: Image.asset('assets/images/payment.png', height: 11, width: 11,)
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 8,
          //           ),
          //            Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Entry Paid',
          //                 style: TextStyle(
          //                     fontSize: 11,
          //                     fontWeight: FontWeight.w400,
          //                     color:colorBlack,
          //                     fontFamily: "Bold"),
          //               ),
          //               Text(
          //                 dateTimeee,
          //                 style: TextStyle(
          //                     fontSize: 9,
          //                     fontWeight: FontWeight.w600,
          //                     color: Color(0xffA4A4A4),
          //                     fontFamily: "SemiBold"),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //        Text(
          //         '-₹${widget.transactionAccountModel.amount}',
          //         style: TextStyle(
          //             fontSize: 11,
          //             fontWeight: FontWeight.w600,
          //             color: colorBlack,
          //             fontFamily: "SemiBold"),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Divider(
          //     color: Color(0xffE3E3E3),
          //     thickness: 0.8,
          //   ),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Container(
          //             height: 27,
          //             width: 27,
          //             decoration: BoxDecoration(
          //                 border: Border.all(color: const Color(0xffE7E7E7)),
          //                 shape: BoxShape.circle
          //             ),
          //             child: Center(
          //                 child: Image.asset('assets/images/payment.png', height: 11, width: 11, color: Color(
          //                     0xff258b19),)
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 8,
          //           ),
          //           const Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Offer Applied',
          //                 style: TextStyle(
          //                     fontSize: 11,
          //                     fontWeight: FontWeight.w400,
          //                     color:colorBlack,
          //                     fontFamily: "Bold"),
          //               ),
          //               Text(
          //                 '20 Mar, 2024 04:18 pm',
          //                 style: TextStyle(
          //                     fontSize: 9,
          //                     fontWeight: FontWeight.w600,
          //                     color: Color(0xffA4A4A4),
          //                     fontFamily: "SemiBold"),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //       const Text(
          //         '+₹50',
          //         style: TextStyle(
          //             fontSize: 11,
          //             fontWeight: FontWeight.w600,
          //             color:  colorBlack,
          //             fontFamily: "SemiBold"),
          //       ),
          //     ],
          //   ),
          // ),

        ],
      ),
    );
  }
}