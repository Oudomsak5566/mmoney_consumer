import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mmoney_consumer/Loading_screen.dart';
import 'package:mmoney_consumer/home_screen.dart';
import 'package:mmoney_consumer/home_screen1.dart';
import 'package:mmoney_consumer/pages/homeScreen/history_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/setting_page.dart';
import 'package:mmoney_consumer/pages/homeScreen/wallet_page.dart';
import 'package:mmoney_consumer/pages/loginScreen/confirmpin_screen.dart';
import 'package:mmoney_consumer/pages/loginScreen/login_screen.dart';
import 'package:mmoney_consumer/pages/loginScreen/loginpin_screen.dart';
import 'package:mmoney_consumer/pages/loginScreen/otp_screen.dart';
import 'package:mmoney_consumer/pages/loginScreen/setpin_screen.dart';
import 'package:mmoney_consumer/pages/splashscreen.dart';
import 'package:mmoney_consumer/pages/test/scrollDate.dart';
import 'package:mmoney_consumer/pages/test/sliverappbar.dart';
import 'package:mmoney_consumer/pages/test/test.dart';
import 'package:mmoney_consumer/pages/walletScreen/wallet_screen.dart';
import 'package:mmoney_consumer/utility/my_constant.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
  print('Handling a background message  ==> ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

late int _totalNotifications;
late final FirebaseMessaging _messaging;
// PushNotification? _notification;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set Display rotate
  //***************************************************************** */
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 1 set firebase init
  //***************************************************************** */
  await Firebase.initializeApp();

  // 2 instance firebase messaging
  //***************************************************************** */
  _messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

  // 3 on iOS, this helps to take user permission
  //***************************************************************** */
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permisstion');
    String? token = await _messaging.getToken();
    print('Device token ===> $token');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    // set value Device Token
    //***************************************************************** */
    preferences.setString('deviceToken', token!);
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisinal permission');
  } else {
    print('User declined or has not accepted permission');
  }

  // run app
  //***************************************************************** */

  runApp(const MyApp());
}

// Future<Null> main() async {
//   // set Display rotate
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);

//   //
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   String? msisdnWallet = preferences.getString('msisdnType');
//   print('### msisdnWallet ==> $msisdnWallet');
//   if (msisdnWallet?.isEmpty ?? true) {
//     runApp(const MyApp());
//   } else {}
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ຕ້ອງໃຫ້ຄ່າເລີ່ມຕົ້ນວ່າຈະ Route ໄປໃສ ໃນກໍລະນີເປີດ App ຂຶ້ນມາທຳອິດ
      // initialRoute: '/',
      initialRoute: MyConstant.routeSplash,
      routes: {
        //splach screen
        //***************************************************************** */
        MyConstant.routeSplash: (context) => const SplashScreen(),
        //loading screen
        //***************************************************************** */
        MyConstant.routeLoading: (context) => const LoadingScreen(),
        //login screen
        //***************************************************************** */
        MyConstant.routeLoginScreen: (context) => const LoginScreen(),
        // MyConstant.routeOTPScreen: (context) => const OtpScreenPage(),
        MyConstant.routeSetPinScreen: (context) => const SetPinScreen(),
        // MyConstant.routeConfirmPinScreen: (context) => const ConfirmPinScreen(),
        MyConstant.routeLoginPinScreen: (context) => const LoginPinScreen(),

        //home screen - bottom bar control
        //***************************************************************** */
        MyConstant.routeHomePage: (context) => const HomePage(),
        MyConstant.routeHomeScreen: (context) => const HomeScreen(),
        MyConstant.routeHomeScreen1: (context) => const HomeScreen1(),

        //
        //wallet screen
        //***************************************************************** */
        MyConstant.routeWalletScreen: (context) => const WalletScreen(),
        //ivwhoeofdifiejkiuigdikfgek
        //SECOND SCREEN
        // MyConstant.routeMySplash: (context) => const MySplashScreen(),
        // MyConstant.routeWalletPage: (context) => const WallletPage(),
        MyConstant.routeHistoryPage: (context) => const HistoryPage(),

        // test
        //***************************************************************** */
        MyConstant.routeTest: (context) => const TestPage(),
        MyConstant.routeSliver: (context) => const SliverApp(),
        MyConstant.routeSplash: (context) => const SplashScreen(),
        MyConstant.routeScrollDate: (context) => const ScrollDate(),
      },

      //form bulider validated
      supportedLocales: [...FormBuilderLocalizations.delegate.supportedLocales],
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
