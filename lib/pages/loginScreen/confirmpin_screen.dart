import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mmoney_consumer/loading_screen.dart';
import 'package:mmoney_consumer/models/registerModel.dart';
import 'package:mmoney_consumer/pages/loginScreen/loginpin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utility/my_constant.dart';

class ConfirmPinScreen extends StatefulWidget {
  final String _pin;
  ConfirmPinScreen(this._pin);

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print('### set pin value ===> ${widget._pin}');
  }

  String text = '';
  String pin = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyConstant.dark,
      body: isLoading == true
          ? const LoadingScreen()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SizedBox(
                      height: height * 0.3,
                      child: Lottie.asset(
                        'images/lottie/otp.json',
                        repeat: false,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Your PIN code again.',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: height * 0.1,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pin,
                                style: GoogleFonts.poppins(
                                    fontSize: 32, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 30),
                        NumericKeyboard(
                          onKeyboardTap: _onKeyboardTap,
                          textColor: Colors.white,
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
                            color: Colors.white,
                            size: 45,
                          ),
                          leftButtonFn: () {
                            print('left button clicked');
                          },
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
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
      if (text == widget._pin) {
        _registerPIN(text);
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'PIN does not match',
            message: 'Please re-check your PIN.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          text = '';
          pin = '';
        });
      }
    }
  }

  Future<Null> _registerPIN(String pincode) async {
    setState(() {
      isLoading = true;
    });
    // get data share prderance
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var msisdn = preferences.getString('msisdn');

    Response response;
    var dio = Dio();
    dio.options.connectTimeout = MyConstant.connectTimeout;
    try {
      response = await dio.post(
        '${MyConstant.urlAddress}/register',
        data: {
          "msisdn": msisdn.toString(),
          "pin": pincode,
        },
      );
      print('### res register PIN ===> ${response.data}');

      final registerModel registermodel = registerModel.fromJson(response.data);

      if (registermodel.resultCode == 0) {
        // var token = registermodel.data?.token;
        // preferences.setString('token', token!);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPinScreen()));
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'errCode: ${response.data['resultCode']}',
            message: response.data['resultDesc'],
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      }
    } on DioError catch (e) {
      print('### exception ===> $e');
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Exception Error',
          message: e.message,
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
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
