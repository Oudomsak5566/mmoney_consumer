// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_consumer/pages/homeScreen/history_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/scanqr_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/service_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/setting_page.dart';
import 'package:mmoney_consumer/pages/walletScreen/wallet_screen.dart';
import 'package:mmoney_consumer/utility/my_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int visit = 0;
  double height = 30;
  Color colorSelect = MyConstant.primary;
  Color color = MyConstant.light;
  Color color2 = MyConstant.bluePrimary;
  Color bgColor = MyConstant.dark;
  List pages = [
    const WalletScreen(),
    const ServicePage(),
    const HistoryPage(),
    const SetingPage(),
  ];
  List<TabItem> items = [
    TabItem(
      icon: Icons.account_balance_wallet,
      title: 'Wallet',
    ),
    TabItem(
      icon: Icons.dashboard,
      title: 'Services',
    ),
    TabItem(
      icon: Icons.history_rounded,
      title: 'History',
    ),
    TabItem(
      icon: Icons.settings,
      title: 'Setting',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[visit],
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ScanQrPage(),
            ));
          },
          backgroundColor: Colors.grey[900],
          child: const Icon(
            Icons.qr_code_scanner,
            size: 50,
          ),
        ),
      ),

      //hide and show description
      //-----------------------------------------------
      bottomNavigationBar: BottomBarSalomon(
        items: items,
        titleStyle: GoogleFonts.poppins(
          fontSize: 14,
        ),
        color: Colors.white,
        heightItem: 50,
        backgroundColor: MyConstant.dark,
        colorSelected: MyConstant.dark,
        backgroundSelected: Colors.white,
        borderRadius: BorderRadius.circular(0),
        indexSelected: visit,
        onTap: (index) => setState(() {
          visit = index;
        }),
      ),

      // //show selected bottom icon
      // //-----------------------------------------------
      // bottomNavigationBar: BottomBarDivider(
      //   items: items,
      //   iconSize: 30,
      //   backgroundColor: MyConstant.dark,
      //   color: Colors.white,
      //   colorSelected: Colors.white,
      //   titleStyle: GoogleFonts.poppins(
      //     fontSize: 12,
      //   ),
      //   indexSelected: visit,
      //   onTap: (index) => setState(() {
      //     visit = index;
      //   }),
      //   styleDivider: StyleDivider.bottom,
      // ),
    );
  }
}
