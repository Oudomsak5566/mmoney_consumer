// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mmoney_consumer/home_page.dart';
import 'package:mmoney_consumer/pages/loginScreen/login_screen.dart';
import 'package:mmoney_consumer/pages/loginScreen/loginpin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/my_constant.dart';
import '../widgets/show_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //
    FirebaseMessaging.onMessage.listen((message) {
      print('onMessage ===> $message');
    });

    // TODO: implement initState
    super.initState();
    routeService();
  }

  // check shared perferance login
  //***************************************************************** */
  Future<Null> routeService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // set value to shared preferance login
    //***************************************************************** */
    String? token = preferences.getString('token');
    String? deviceToken = preferences.getString('deviceToken');
    print('### userLogin ===> $token');
    print('### deviceToken ===> $deviceToken');

    if (token?.isEmpty ?? true) {
      print('### userLogin is null navigator LoginScreen');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPinScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  Color.fromARGB(255, 255, 0, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: buildImage(size),
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          child: SizedBox(
            width: size * 0.6,
            child: ShowImage(pathImage: MyConstant.imageLogoTranparent),
          ),
        ),
      ],
    );
  }
}
