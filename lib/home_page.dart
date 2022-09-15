import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mmoney_consumer/pages/homeScreen/history_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/service_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/setting_page.dart';
import 'package:mmoney_consumer/pages/walletScreen/wallet_screen.dart';
import 'package:mmoney_consumer/utility/my_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List pages = [
    const WalletScreen(),
    // const WallletPage(),
    const ServicePage(),
    const HistoryPage(),
    const SetingPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: 75,
        color: MyConstant.dark,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: 33,
          ),
          Icon(
            Icons.dashboard,
            color: Colors.white,
            size: 33,
          ),
          Icon(
            Icons.history_rounded,
            color: Colors.white,
            size: 33,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
            size: 33,
          ),
        ],
      ),
    );
  }
}
