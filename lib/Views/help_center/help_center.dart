import 'package:conbun_production/Views/help_center/FAQ_screen.dart';
import 'package:conbun_production/Views/help_center/contact_us_screen.dart';
import 'package:conbun_production/utils/colors.dart';
import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  final int selectedTab;
  const HelpCenter({super.key, required this.selectedTab});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> with SingleTickerProviderStateMixin {

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
            backgroundColor: colorBackground,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: GestureDetector(
                onTap: (){
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
                      child: Icon(Icons.arrow_back, color: colorViolet, size: 20,)),
                  title: Text(
                    "Help Center",
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
                    labelColor: Color(0xff677294),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0, color:  Color(0xff677294)),
                      insets: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    unselectedLabelColor: Color(0xff9E9E9E),
                    padding: EdgeInsets.zero,
                    indicatorWeight: 1,
                    dividerColor: Color(0xffE8E8E8),
                    tabs: [
                      Tab(text: 'FAQ'),
                      Tab(text: 'Contact Us'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    key: UniqueKey(),
                    controller: _tabController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      FAQScreen(selectedTab: widget.selectedTab,),
                      ContactScreen()
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