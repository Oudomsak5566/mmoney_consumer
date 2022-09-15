import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyConstant {
  //Route
  static String routeHomePage = '/home_page';
  static String routeHomeScreen = '/home_screen';
  static String routeHomeScreen1 = '/home_screen1';

  //
  //loading screen
  //***************************************************************** */
  static String routeLoading = '/loading_sreen';

  //
  //login screen
  //***************************************************************** */
  static String routeLoginScreen = '/pages/loginScreen/login_screen';
  static String routeOTPScreen = '/pages/loginScreen/otp_screen';
  static String routeSetPinScreen = '/pages/loginScreen/setpin_screen';
  static String routeConfirmPinScreen = '/pages/loginScreen/confirmpin_screen';
  static String routeLoginPinScreen = '/pages/loginScreen/loginpin_screen';

  //
  //wallet screen
  //***************************************************************** */
  static String routeWalletScreen = '/pages/walletScreen/wallet_screen';

  //
  //test
  //***************************************************************** */
  static String routeWalletPage = '/pages/wallet_page';
  static String routeHistoryPage = '/pages/history_page';
  static String routeSplash = '/splashscreen';
  static String routeMySplash = '/mysplashscreen';

  //
  //test
  //***************************************************************** */
  static String routeTest = '/test/test';
  static String routeSliver = '/test/sliverappbar';
  static String routeLoginTest = '/pages/loginpage';
  static String routeScrollDate = '/test/scrolldate';
  static String routeMyWidget = '/test/MyWidget';

  //
  // Color
  //***************************************************************** */
  static Color primary = const Color(0xffef3025);
  static Color dark = const Color(0xffb40000);
  static Color light = const Color(0xffff6a50);
  static Color bluePrimary = const Color(0xff269090);
  static Color blueDark = const Color(0xff003D3D);

  //
  // Images
  //***************************************************************** */
  static String image01 = 'images/img01.jpg';
  static String imageLogo = 'images/logo_mmoney.png';
  static String imageLogoTranparent = 'images/logo_money_tranparent.png';
  static String imageOtp = 'images/otp.png';
  static String banner00 = 'images/banner00.jpg';
  static String banner01 = 'images/banner01.jpg';
  static String banner02 = 'images/banner02.jpg';
  static String banner03 = 'images/banner03.jpg';

  //
  // Text Style [h1/24 h2/18 h3/14]
  //***************************************************************** */
  TextStyle h1Style() => GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.bold, color: blueDark);
  TextStyle h2Style() => GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.normal, color: blueDark);
  TextStyle h3Style() => GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.normal, color: blueDark);
  TextStyle h1NotoStyle() => GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.bold, color: blueDark);
  TextStyle h2NotoStyle() => GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.normal, color: blueDark);
  TextStyle h3NotoStyle() => GoogleFonts.notoSansLao(
      fontSize: 14, fontWeight: FontWeight.normal, color: blueDark);
  TextStyle errNotoStyle() => GoogleFonts.notoSansLao(
      fontSize: 12, fontWeight: FontWeight.normal, color: MyConstant.dark);

  //
  // Buttom
  //***************************************************************** */
  ButtonStyle myButtomStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      );

  //
  // TextForm
  //***************************************************************** */
  OutlineInputBorder outlineInputBorder() => OutlineInputBorder(
        borderSide: BorderSide(color: MyConstant.blueDark),
        borderRadius: BorderRadius.circular(30),
      );

  OutlineInputBorder focusOutlineInputBorder() => OutlineInputBorder(
        borderSide: BorderSide(color: MyConstant.bluePrimary),
        borderRadius: BorderRadius.circular(30),
      );

  OutlineInputBorder errOutlineInputBorder() => OutlineInputBorder(
        borderSide: BorderSide(color: MyConstant.light),
        borderRadius: BorderRadius.circular(30),
      );

  //
  // API Address
  //***************************************************************** */
  static String urlAddress = 'http://172.28.14.87:1337';
  static int connectTimeout = 10000;
  static String VersionID = 'LMM DevTeam - version 1.0.0';
}
