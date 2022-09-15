import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_consumer/loading_screen.dart';
import 'package:mmoney_consumer/pages/loginScreen/loginpin_screen.dart';
import 'package:mmoney_consumer/pages/loginScreen/setpin_screen.dart';
import 'package:pinput/pinput.dart';
import '../../utility/my_constant.dart';
import '../../widgets/show_image.dart';

class OtpScreenPage extends StatefulWidget {
  final String _msisdn;
  final String _refCode;
  OtpScreenPage(this._msisdn, this._refCode);

  @override
  State<OtpScreenPage> createState() => _OtpScreenPageState();
}

class _OtpScreenPageState extends State<OtpScreenPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  bool isLoading = false;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    const length = 6;
    final borderColor = MyConstant.bluePrimary;
    final fillColor = Colors.grey.shade50;
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 65,
      textStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: MyConstant.dark,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyConstant.bluePrimary),
      ),
    );
    return Scaffold(
      backgroundColor: MyConstant.dark,
      body: isLoading == true
          ? LoadingScreen()
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildImage(size),
                    Text(
                      'Verification',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Code sent to the number ${widget._msisdn}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'refCode : ${widget._refCode}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: Pinput(
                        length: length,
                        controller: controller,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        onCompleted: (pin) {
                          _otpProcess(pin);
                        },
                        focusedPinTheme: defaultPinTheme.copyWith(
                          height: 68,
                          width: 64,
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(color: borderColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: size * 0.5,
            child: ShowImage(pathImage: MyConstant.imageOtp),
          ),
        ),
      ],
    );
  }

  Future<Null> _otpProcess(String otpCode) async {
    setState(() {
      isLoading == true;
    });
    var url = '${MyConstant.urlAddress}/confirmOTP';
    Response response;
    var dio = Dio();
    dio.options.connectTimeout = MyConstant.connectTimeout;
    try {
      response = await dio.post(
        url,
        data: {
          "otp": otpCode,
          "ref": widget._refCode,
        },
      );
      print('### res check OTP  ===> ${response.data}');
      if (response.data['resultCode'] == 0) {
        //
        //check is have pin code?
        response = await dio.post(
          '${MyConstant.urlAddress}/verify',
          data: {
            "msisdn": widget._msisdn,
          },
        );
        print('### res check Verify  ===> ${response.data}');
        if (response.data['resultCode'] == 0) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPinScreen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SetPinScreen()));
        }
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
          isLoading == false;
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
