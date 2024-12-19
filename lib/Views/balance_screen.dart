import 'package:conbun_production/Views/help_center/help_center.dart';
import 'package:conbun_production/Views/inviteScreen/invite_screen.dart';
import 'package:conbun_production/Views/rechargeScreen/recharge_screen.dart';
import 'package:conbun_production/Views/supportCenter/support_center.dart';
import 'package:conbun_production/Views/transactionHistoryScreen/transaction_history_screen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../Controllers/user_controller.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  UserController userController = Get.find();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNewWidget();
  }

  void _loadNewWidget() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }
  Future<void> refreshData() async {

    await userController.fetchUserWalletBalance();

  }

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
            title: Text(
              "Balance",
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
                child: Icon(
                  Icons.arrow_back,
                  color: colorViolet,
                  size: 20,
                )),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await refreshData();
        },
        child: SingleChildScrollView(
          child:
          _isLoading? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 26,
                ),
                ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12)
                    ),
        
                  )
                ),
                SizedBox(
                  height: 26,
                ),
                ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: colorViolet,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deposit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Regular",
                                      color: colorBlack,
                                    ),
                                  ),
                                  Text(
                                    '₹999',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Bold",
                                      color: colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RechargeScreen(code: "nothing",)));
                              },
                              child: Container(
                                height: 36,
                                width: 91,
                                decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    "Recharge",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: colorWhite,
                                        fontFamily: "SemiBold"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: colorViolet,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deposit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Regular",
                                      color: colorBlack,
                                    ),
                                  ),
                                  Text(
                                    '₹999',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Bold",
                                      color: colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RechargeScreen(code: "nothing",)));
                              },
                              child: Container(
                                height: 36,
                                width: 91,
                                decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    "Recharge",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: colorWhite,
                                        fontFamily: "SemiBold"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                SizedBox(
                  height: 20,
                ),
                ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: colorViolet,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deposit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Regular",
                                      color: colorBlack,
                                    ),
                                  ),
                                  Text(
                                    '₹999',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Bold",
                                      color: colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RechargeScreen(code: "nothing",)));
                              },
                              child: Container(
                                height: 36,
                                width: 91,
                                decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    "Recharge",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: colorWhite,
                                        fontFamily: "SemiBold"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: colorViolet,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deposit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Regular",
                                      color: colorBlack,
                                    ),
                                  ),
                                  Text(
                                    '₹999',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Bold",
                                      color: colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RechargeScreen(code: "nothing",)));
                              },
                              child: Container(
                                height: 36,
                                width: 91,
                                decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    "Recharge",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: colorWhite,
                                        fontFamily: "SemiBold"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ShimmerEffect(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: colorViolet,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deposit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Regular",
                                      color: colorBlack,
                                    ),
                                  ),
                                  Text(
                                    '₹999',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Bold",
                                      color: colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RechargeScreen(code: "nothing",)));
                              },
                              child: Container(
                                height: 36,
                                width: 91,
                                decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    "Recharge",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: colorWhite,
                                        fontFamily: "SemiBold"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        
              ],
            ),
          ):
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.95
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx((){
                        return Text(
                          "₹${double.parse(userController.userWalletBalance.value).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Bold",
                            color: colorBlack,
                          ),
                        );
                      }),
                      SizedBox(
                        width: 16,
                      ),
                      Obx((){
                        return
                        double.parse(userController.userWalletBalance.value) <= 1000 ?
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(1),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                                  child: Text(
                                    "Low Balance",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "SemiBold",
                                      color: colorWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):SizedBox();
                      })
                    ],
                  ),
                  Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Bold",
                      color: colorViolet,
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: colorViolet,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deposit',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Regular",
                                      color: colorBlack,
                                    ),
                                  ),
                                  Text(
                                    '₹${double.parse(userController.totalDeposit.value).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Bold",
                                      color: colorBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RechargeScreen(code: "nothing",)));
                              },
                              child: Container(
                                height: 36,
                                width: 91,
                                decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    "Recharge",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: colorWhite,
                                        fontFamily: "SemiBold"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> InviteScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.card_giftcard,
                                color: colorViolet,
                                size: 24,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Promotional',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Regular",
                                        color: colorBlack,
                                      ),
                                    ),
                                    Text(
                                      '₹${double.parse(userController.totalPromotional.value).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "Bold",
                                        color: colorBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Color(0xffA6A6A6),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    "Ouick Actions",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Bold",
                      color: colorViolet,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TransactionHistoryScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mail_outline_outlined,
                                color: Color(0xffA6A6A6),
                                size: 24,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Transaction History',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "Bold",
                                        color: colorBlack,
                                      ),
                                    ),
                                    Text(
                                      'For all balance debit & credit',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: "SemiBold",
                                        color: colorBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Color(0xffA6A6A6),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> SupportCenter()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.support_agent,
                                color: Color(0xffA6A6A6),
                                size: 24,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Support Center',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "Bold",
                                        color: colorBlack,
                                      ),
                                    ),
                                    Text(
                                      'Get support for failed transactions',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: "SemiBold",
                                        color: colorBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Color(0xffA6A6A6),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(HelpCenter(selectedTab: 1,));
                    },
                    child : Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_chart,
                                color: Color(0xffA6A6A6),
                                size: 24,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Wallet Recharge Help',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "Bold",
                                        color: colorBlack,
                                      ),
                                    ),
                                    Text(
                                      'How to add fund in wallet',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: "SemiBold",
                                        color: colorBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Color(0xffA6A6A6),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
