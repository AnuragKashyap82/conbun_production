import 'package:conbun_production/Views/transactionHistoryScreen/transaction_account_screen.dart';
import 'package:conbun_production/Views/transactionHistoryScreen/transaction_recharge_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: colorWhite,
      theme: ThemeData(useMaterial3: true),
      home: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            backgroundColor: colorWhite,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: AppBar(
                  backgroundColor: colorWhite,
                  surfaceTintColor: colorWhite,
                  shadowColor: Colors.black.withOpacity(0.1),
                  leading: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, color: colorViolet, size: 20,)),
                  title: const Text(
                    "Transaction History",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SemiBold",
                      color: colorViolet,
                    ),
                  ),
                  centerTitle: false,
                  elevation: 12,
                ),
              ),
            ),
            body:

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0)
                      .copyWith(bottom: 0),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: colorOrange,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: colorBlack,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0, color:  Color(0xff677294)),
                      insets: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    unselectedLabelColor: colorBlack,
                    padding: EdgeInsets.zero,
                    indicatorWeight: 1,
                    dividerColor: const Color(0xffE8E8E8),
                    tabs: [
                      const Tab(text: 'Account'),
                      const Tab(text: 'Recharge'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    key: UniqueKey(),
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                     const TransactionAccountScreen(),
                     const TransactionRechargeScreen()
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}




