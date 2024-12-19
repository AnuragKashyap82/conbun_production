import 'package:conbun_production/Controllers/coupon_controller.dart';
import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/Views/rechargeScreen/recharge_apis.dart';
import 'package:conbun_production/Views/transactionHistoryScreen/transaction_history_screen.dart';
import 'package:conbun_production/Widgets/coupons_bottom_sheet.dart';
import 'package:conbun_production/utils/constant.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Controllers/transaction_recharge_controller.dart';
import '../../utils/colors.dart';

class RechargeScreen extends StatefulWidget {
  final String code;
  const RechargeScreen({super.key, required this.code});
  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  RechargeApis rechargeApis = Get.put(RechargeApis());
  // late Razorpay _razorpay;
  UserController userController = Get.find();
  TextEditingController _amountController = TextEditingController();
  TransactionRechargeController transactionRechargeController = Get.find();
  CouponController couponController = Get.put(CouponController());

  // ///Razorpay Payment
  // void openCheckout(amount) async {
  //   amount = amount * 100;
  //   var options = {
  //     'key': Constant.razorpayKeyId,
  //     'amount': amount,
  //     'name': 'Consultants',
  //     'currency': 'INR',
  //     'retry': {'enabled': false, 'max_count': 1},
  //     'description': 'Consultants Wallet Recharge',
  //     'prefill': {'phone': userController.userData().phoneNumber, 'email': "${userController.userData().email}"},
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
  //
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
  //
  // void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   // Handle payment success
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   print("Status: Payment Failed ${response.paymentId}");
  //   showSnackBar("Status: Success, PaymentId: ${response.paymentId}", context);
  //
  //   // showSnackBar(rechargeApis.couponAmount.value, context);
  //   // showSnackBar(rechargeApis.couponId.value, context);
  //   // showSnackBar(rechargeApis.netAmount.value, context);
  //
  //   final responseMessage = await rechargeApis.rechargeUserWallet(
  //     userController.userData().id,
  //     rechargeApis.couponId.value,
  //     rechargeApis.couponAmount.value,
  //     _amountController.text.trim(),
  //     rechargeApis.netAmount.value == ''?_amountController.text.trim():rechargeApis.netAmount.value,
  //     response.paymentId.toString(),
  //     '',
  //     '',
  //     'Success',
  //   );
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: colorWhite,
  //           surfaceTintColor: colorWhite,
  //           alignment: Alignment(0.0, 0.0),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(
  //                 20.0,
  //               ),
  //             ),
  //           ),
  //           contentPadding: EdgeInsets.only(
  //             top: 10.0,
  //           ),
  //           insetPadding:
  //           EdgeInsets.symmetric(horizontal: 36),
  //           content: Container(
  //             height: 420,
  //             child: Column(
  //               crossAxisAlignment:
  //               CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Lottie.asset(
  //                   'assets/lottie/done.json',
  //                   width: 200,
  //                   height: 200,
  //                   fit: BoxFit.fill,
  //                 ),
  //                 SizedBox(
  //                   height: 16,
  //                   width:
  //                   MediaQuery.of(context).size.width,
  //                 ),
  //                 Text(
  //                   "Wallet Recharged\nSuccessfully",
  //                   style: TextStyle(
  //                       fontSize: 21,
  //                       fontWeight: FontWeight.w800,
  //                       color: Color(0xff677294),
  //                       fontFamily: "Bold"),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 Text(
  //                   "dsvfdbvdfkn kfcn kvg\ndfkbofdbofjbogf",
  //                   style: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w500,
  //                       color: Color(0xff9C9C9C),
  //                       fontFamily: "SemiBold"),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 SizedBox(
  //                   height: 26,
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     if(widget.code == 'booking'){
  //                       Navigator.pop(context);
  //                     }else{
  //                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> TransactionHistoryScreen()));
  //                     }
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     width: MediaQuery.of(context)
  //                         .size
  //                         .width *
  //                         0.5,
  //                     decoration: BoxDecoration(
  //                         color: colorBlack,
  //                         borderRadius:
  //                         BorderRadius.circular(100)),
  //                     child: Center(
  //                       child: Text(
  //                         "Done",
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.w600,
  //                             color: colorWhite,
  //                             fontFamily: "SemiBold"),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  //   await userController.fetchUserWalletBalance();
  //   await transactionRechargeController.fetchAllTransactionRecharge();
  //   await transactionRechargeController.fetchSuccessTransactionRecharge();
  //   await transactionRechargeController.fetchPendingTransactionRecharge();
  //   await transactionRechargeController.fetchFailedTransactionRecharge();
  //   await transactionRechargeController.fetchInitiateTransactionRecharge();
  //   await transactionRechargeController.fetchCancelledTransactionRecharge();
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) async {
  //   // Handle payment error
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   print("Status: Payment Failed ${response.message}");
  //   showSnackBar('Status: Payment Failed ${response.message} ', context);
  //
  //   showSnackBar(rechargeApis.couponAmount.value, context);
  //   showSnackBar(rechargeApis.couponId.value, context);
  //   showSnackBar(rechargeApis.netAmount.value, context);
  //
  //   final responseMessage = await rechargeApis.rechargeUserWallet(
  //     userController.userData().id,
  //     rechargeApis.couponId.value,
  //     rechargeApis.couponAmount.value,
  //     _amountController.text.trim(),
  //     rechargeApis.netAmount.value == ''?_amountController.text.trim():rechargeApis.netAmount.value,
  //     '',
  //     '',
  //     '',
  //     'Failed',
  //   );
  //
  //   showSnackBar(responseMessage['message'], context);
  //   await userController.fetchUserWalletBalance();
  //   await transactionRechargeController.fetchAllTransactionRecharge();
  //   await transactionRechargeController.fetchSuccessTransactionRecharge();
  //   await transactionRechargeController.fetchPendingTransactionRecharge();
  //   await transactionRechargeController.fetchFailedTransactionRecharge();
  //   await transactionRechargeController.fetchInitiateTransactionRecharge();
  //   await transactionRechargeController.fetchCancelledTransactionRecharge();
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) async {
  //   // Handle external wallet response
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   print("Status: Payment Failed ${response.walletName}");
  //   showSnackBar('Status: Payment Failed ${response.walletName} ', context);
  //
  //   showSnackBar(rechargeApis.couponAmount.value, context);
  //   showSnackBar(rechargeApis.couponId.value, context);
  //   showSnackBar(rechargeApis.netAmount.value, context);
  //
  //   final responseMessage = await rechargeApis.rechargeUserWallet(
  //     userController.userData().id,
  //     rechargeApis.couponId.value,
  //     rechargeApis.couponAmount.value,
  //     _amountController.text.trim(),
  //     rechargeApis.netAmount.value == ''?_amountController.text.trim():rechargeApis.netAmount.value,
  //     '',
  //     '',
  //     '',
  //     'Failed',
  //   );
  //   showSnackBar(responseMessage['message'], context);
  //   await userController.fetchUserWalletBalance();
  //   await transactionRechargeController.fetchAllTransactionRecharge();
  //   await transactionRechargeController.fetchSuccessTransactionRecharge();
  //   await transactionRechargeController.fetchPendingTransactionRecharge();
  //   await transactionRechargeController.fetchFailedTransactionRecharge();
  //   await transactionRechargeController.fetchInitiateTransactionRecharge();
  //   await transactionRechargeController.fetchCancelledTransactionRecharge();
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _razorpay = Razorpay();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  //   rechargeApis.clearCoupon();
  // }

  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppBar(
            backgroundColor: colorWhite,
            elevation: 7,
            shadowColor: Colors.black.withOpacity(0.1),
            automaticallyImplyLeading: false,
            title: const Text(
              "Recharge",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "MontserratBold",
                color: colorViolet,
              ),
            ),
            centerTitle: false,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: colorViolet,
                  size: 20,
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 26,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: const Color(0xffEDF7F2).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: const Color(0xff8AE6B7), width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Woohoo! This recharge is eligible for",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                fontFamily: "Bold",
                                color: colorSecondaryViolet,
                              ),
                            ),
                            Text(
                              "Recharge Cashback",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                fontFamily: "Bold",
                                color: Color(0xff05945B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Image.asset(
                      'assets/images/recharge.png',
                      height: 80,
                      fit: BoxFit.fitHeight,
                    )),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              const Text(
                "Amount",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Bold",
                  color: colorSecondaryViolet,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: colorWhite,
                    border:
                        Border.all(color: const Color(0xffD9D9DA), width: 0.8),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    controller: _amountController,
                    onChanged: (value) {},
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      fontFamily: "SemiBold",
                      color: Color(0xff60697B),
                    ),
                    decoration: InputDecoration(
                        hintText: 'Enter amount',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff70798B),
                            fontFamily: "SemiBold"),
                        contentPadding: EdgeInsets.only(bottom: 0),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
              ),
              Obx((){
                return  GestureDetector(
                  onTap: () async{
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        couponController.fetchAllCoupons();
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            constraints: BoxConstraints(
                                maxHeight:
                                MediaQuery.of(context).size.height * 0.9),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                            ),
                            child: CouponsBottomSheet(
                              amount: _amountController.text.trim(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: DottedBorder(
                      color: Colors.grey.shade400,
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(6),
                      dashPattern: [3],
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child:
                            rechargeApis.couponId.value == ''?ListTile(
                              leading: SvgPicture.asset(
                                'assets/svg/tag.svg',
                                height: 24,
                                width: 24,
                                color: colorViolet,
                              ),
                              title: Text(
                                "Apply Coupon",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Bold",
                                  color: Color(0xff60697B),
                                ),
                              ),
                              subtitle: Text(
                                "See coupons inside to save extra",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Bold",
                                  color: Colors.green,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: colorViolet,
                                size: 14,
                              ),
                            ):ListTile(
                              leading: SvgPicture.asset(
                                'assets/svg/tag.svg',
                                height: 24,
                                width: 24,
                                color: colorViolet,
                              ),
                              title: Text(
                                rechargeApis.couponTitle.value,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Bold",
                                  color: Color(0xff60697B),
                                ),
                              ),
                              subtitle: Text(
                                rechargeApis.couponDescription.value,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Bold",
                                  color: Colors.green,
                                ),
                              ),
                              trailing: Icon(
                                Icons.close,
                                color: colorViolet,
                                size: 14,
                              ),
                              onTap: ()async{
                                rechargeApis.clearCoupon();
                              },
                            )
                      ),
                    ),
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      _amountController.text = '500';
                    },
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                          color: colorWhite,
                          border: Border.all(color: const Color(0xffD9D9DA)),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "+500",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Bold",
                                color: Color(0xff60697B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: (){
                      _amountController.text = '1500';
                    },
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                          color: colorWhite,
                          border: Border.all(color: const Color(0xffD9D9DA)),
                          borderRadius: BorderRadius.circular(10),),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "+1500",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Bold",
                                color: Color(0xff60697B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: (){
                      _amountController.text = '5000';
                    },
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                          color: colorWhite,
                          border: Border.all(color: const Color(0xffD9D9DA)),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "+5000",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Bold",
                                color: Color(0xff60697B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              const Text(
                "Summary",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Bold",
                  color: colorSecondaryViolet,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: colorWhite.withOpacity(0.3),
                    border:
                        Border.all(color: const Color(0xffD9D9DA), width: 0.8),
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Recharge Amount",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              fontFamily: "SemiBold",
                              color: Color(0xff666F80),
                            ),
                          ),
                          Text(
                            "₹2501.00",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Bold",
                              color: colorBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "GST applicable",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: "SemiBold",
                              color: Color(0xff666F80),
                            ),
                          ),
                          Text(
                            "₹2501.00",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Bold",
                              color: colorBlack,
                            ),
                          ),
                        ],
                      ),
                      Obx((){
                        return Column(
                          children: [
                            rechargeApis.couponId.isNotEmpty?
                            const SizedBox(
                              height: 16,
                            ):SizedBox(),
                            rechargeApis.couponId.isNotEmpty?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Coupon Amount",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "SemiBold",
                                    color: Color(0xff666F80),
                                  ),
                                ),
                                Text(
                                  "₹${rechargeApis.couponAmount.value}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Bold",
                                    color: colorBlack,
                                  ),
                                ),
                              ],
                            ):SizedBox(),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        );
                      }),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "-----------------------------------------------",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w100,
                                fontFamily: "Regular",
                                color: const Color(0xff666F80).withOpacity(0.2),
                              ),
                            ),
                            Text(
                              "-----------------------------------------------",
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w100,
                                fontFamily: "Regular",
                                color: const Color(0xff666F80).withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Deposit bal. credit",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: "SemiBold",
                              color: Color(0xff666F80),
                            ),
                          ),
                          Text(
                            "₹2501.00",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Bold",
                              color: colorBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Promotional bal. credit",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Bold",
                                  color: Color(0xff666F80),
                                ),
                              ),
                              Text(
                                "🎉 Recharge Cashback",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "SemiBold",
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹2501.00",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Bold",
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "-----------------------------------------------",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w100,
                                fontFamily: "Regular",
                                color: const Color(0xff666F80).withOpacity(0.2),
                              ),
                            ),
                            Text(
                              "-----------------------------------------------",
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w100,
                                fontFamily: "Regular",
                                color: const Color(0xff666F80).withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "₹2501.00",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Bold",
                                  color: colorBlack,
                                ),
                              ),
                              Text(
                                "Net Balance",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                  color: Color(0xffA9A9A9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {

                    // if (_amountController.text.trim().isEmpty) {
                    //   showSnackBar('Enter Recharge amount', context);
                    // } else {
                    //   if (widget.code == "booking") {
                    //     ///Implement the razorpay then pop
                    //     setState(() {
                    //       _isLoading = true;
                    //     });
                    //     openCheckout(
                    //         double.parse(_amountController.text.trim()));
                    //   } else {
                    //     setState(() {
                    //       _isLoading = true;
                    //     });
                    //     openCheckout(
                    //         double.parse(_amountController.text.trim()));
                    //   }
                    // }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        color: colorBlack,
                        border: Border.all(color: const Color(0xff636363)),
                        borderRadius: BorderRadius.circular(4)),
                    child:  Center(
                      child: _isLoading?CircularProgressIndicator(strokeWidth: 2, color: colorWhite,):Text(
                        "Recharge",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: colorWhite,
                            fontFamily: "SemiBold",),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
