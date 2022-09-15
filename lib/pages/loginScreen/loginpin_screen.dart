// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_consumer/home_screen1.dart';
import 'package:mmoney_consumer/models/loginModel.dart';
import 'package:mmoney_consumer/pages/loginScreen/login_screen.dart';
import 'package:mmoney_consumer/widgets/show_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Loading_screen.dart';
import '../../utility/my_constant.dart';

class LoginPinScreen extends StatefulWidget {
  const LoginPinScreen({Key? key}) : super(key: key);

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  String _msisdn = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getDataSharedpreferance();
  }

  // check shared perferance
  //***************************************************************** */
  Future getDataSharedpreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? msisdn = preferences.getString('msisdn');
    setState(() {
      _msisdn = msisdn!;
    });
  }

  String text = '';
  String pin = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: isLoading == true
                    ? const LoadingScreen()
                    : Column(
                        children: [
                          buildLogoMsisdn(height),
                          buildValueNumPad(height),
                          buildNumPad(),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildValueNumPad(double height) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: height * 0.1,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            pin,
            style:
                GoogleFonts.poppins(fontSize: 42, color: MyConstant.blueDark),
          ),
        ],
      ),
    );
  }

  Expanded buildNumPad() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: MyConstant.dark,
              rightButtonFn: () {
                if (text.isNotEmpty) {
                  setState(() {
                    text = text.substring(0, text.length - 1);
                    pin = pin.substring(0, pin.length - 1);
                  });
                }
              },
              rightIcon: const Icon(
                Icons.backspace_outlined,
                color: Color(0xffb40000),
                size: 45,
              ),
              leftIcon: const Icon(
                Icons.center_focus_weak_rounded,
                color: Color(0xffb40000),
                size: 45,
              ),
              leftButtonFn: () {
                print('left button clicked');
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildLogoMsisdn(double height) {
    return Container(
      height: 330,
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: MyConstant.dark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
        ),
        image: DecorationImage(
          image: AssetImage('images/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Image.asset(
          //   'images/bg.jpg',
          //   height: 150,
          //   width: double.infinity,
          //   fit: BoxFit.cover,
          // ),
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.wallet,
            color: Colors.white,
            size: 100,
          ),
          Text(
            'Wallet Account',
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _msisdn.toString(),
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          buildSwitchAccButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: TextButton(
                  child: Text(
                    'ລືມລະຫັດ PIN',
                    style: GoogleFonts.notoSansLao(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _fotgotPIN();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onKeyboardTap(String value) {
    if (text.length <= 5) {
      setState(() {
        text = text + value;
        pin = pin + '✱';
      });
    }
    if (text.length == 6) {
      _loginPIN(text);
    }
  }

  Row buildSwitchAccButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: 30,
          child: ElevatedButton(
            style: MyConstant().myButtomStyle(),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ປ່ຽນບັນຊີກະເປົ໋າເງິນ',
                  style: GoogleFonts.notoSansLao(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> _fotgotPIN() async {
    setState(() {
      isLoading == true;
    });
    var url = '${MyConstant.urlAddress}/delete';
    Response response;
    var dio = Dio();
    dio.options.connectTimeout = MyConstant.connectTimeout;
    try {
      response = await dio.post(
        url,
        data: {"msisdn": _msisdn},
      );
      if (response.data['resultCode'] == 0) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.remove('token');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        showFailedAlert(
          context,
          response.data['resultCode'],
          response.data['resultDesc'],
        );
        setState(() {
          isLoading == false;
        });
      }
    } on DioError catch (e) {
      print('### exception ===> $e');
      // var snackBar = SnackBar(
      //   elevation: 0,
      //   behavior: SnackBarBehavior.floating,
      //   backgroundColor: Colors.transparent,
      //   content: AwesomeSnackbarContent(
      //     title: 'Exception Error',
      //     message: e.message,
      //     contentType: ContentType.failure,
      //   ),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      showFailedAlert(context, 'Exception Error', e.message);
      setState(() {
        isLoading == false;
      });
    }
  }

  Future _loginPIN(String PIN) async {
    setState(() {
      isLoading == true;
    });
    var url = '${MyConstant.urlAddress}/login';
    Response response;
    var dio = Dio();
    dio.options.connectTimeout = MyConstant.connectTimeout;
    try {
      response = await dio.post(
        url,
        data: {
          "msisdn": _msisdn,
          "pin": PIN,
        },
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      final loginModel loginmodel = loginModel.fromJson(response.data);
      if (response.data['resultCode'] == 0) {
        var token = loginmodel.data?.token;
        preferences.setString('token', token!);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen1()));
      } else {
        showFailedAlert(context, '${response.data['resultCode']}',
            response.data['resultDesc']);
        setState(() {
          isLoading == false;
        });
        Timer(const Duration(milliseconds: 100), () {
          setState(() {
            text = '';
            pin = '';
          });
        });
      }
    } on DioError catch (e) {
      showFailedAlert(context, 'Exception Error', e.message);
      setState(() {
        isLoading == false;
      });
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          text = '';
          pin = '';
        });
      });
    }
  }
}

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  final Color textColor;
  final Icon? rightIcon;
  final Function()? rightButtonFn;
  final Icon? leftIcon;
  final Function()? leftButtonFn;
  final KeyboardTapCallback onKeyboardTap;
  final MainAxisAlignment mainAxisAlignment;

  const NumericKeyboard(
      {Key? key,
      required this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1', width, height),
              _calcButton('2', width, height),
              _calcButton('3', width, height),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('4', width, height),
              _calcButton('5', width, height),
              _calcButton('6', width, height),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('7', width, height),
              _calcButton('8', width, height),
              _calcButton('9', width, height),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: widget.leftButtonFn,
                child: Container(
                    alignment: Alignment.center,
                    width: width * 0.21,
                    height: height * 0.1,
                    child: widget.leftIcon),
              ),
              _calcButton('0', width, height),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.white,
                onTap: widget.rightButtonFn,
                child: Container(
                    alignment: Alignment.center,
                    width: width * 0.21,
                    height: height * 0.1,
                    child: widget.rightIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value, double width, double height) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: Colors.white,
      onTap: () {
        // print(value.length);
        widget.onKeyboardTap(value);
      },
      child: Container(
        alignment: Alignment.center,
        width: width * 0.25,
        height: height * 0.1,
        child: Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: 55,
            color: widget.textColor,
          ),
        ),
      ),
    );
  }
}
