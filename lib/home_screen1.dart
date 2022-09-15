// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmoney_consumer/pages/homeScreen/history_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/scanqr_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/service_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/setting_page.dart';
import 'package:mmoney_consumer/pages/walletScreen/wallet_screen.dart';
import 'package:mmoney_consumer/utility/my_constant.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  double screenHeight = 0;
  double screenWidth = 0;

  int currentIndex = 0;

  List<IconData> navagationIcons = [
    FontAwesomeIcons.wallet,
    Icons.dashboard,
    Icons.history_rounded,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          WalletScreen(),
          ServicePage(),
          HistoryPage(),
          SetingPage(),
        ],
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ScanQrPage(),
            ));
          },
          // backgroundColor: Colors.grey[900],
          backgroundColor: MyConstant.dark,
          child: const Icon(
            Icons.qr_code_scanner,
            size: 40,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 20,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < navagationIcons.length; i++) ...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            navagationIcons[i],
                            color: i == currentIndex
                                ? MyConstant.dark
                                : MyConstant.blueDark,
                            size: i == currentIndex ? 30 : 26,
                          ),
                          i == currentIndex
                              ? Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  height: 3,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: MyConstant.primary,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
