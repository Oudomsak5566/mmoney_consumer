// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mmoney_consumer/loading_screen.dart';
import 'package:mmoney_consumer/models/singupModel.dart';
import 'package:mmoney_consumer/pages/loginScreen/otp_screen.dart';
import 'package:mmoney_consumer/utility/my_constant.dart';
import 'package:mmoney_consumer/widgets/show_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/show_sheet.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DateTime dateTime = DateTime.now();

  //text controller
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _msisdn = TextEditingController();
  final _birthday = TextEditingController();

  bool isLoading = false;

  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyConstant.dark,
      body: isLoading == true
          ? const LoadingScreen()
          : SafeArea(
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: GestureDetector(
                          onTap: () =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            children: [
                              buildLogo(),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 10,
                                        offset: Offset(10, 10)),
                                  ],
                                ),
                                child: FormBuilder(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      buildWelcomeText(),
                                      buildTelephone(size),
                                      buildBirthDate(size),
                                      buildLoginButton(size),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(MyConstant.VersionID),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Row buildWelcomeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text(
                'M-Money',
                style: MyConstant().h1Style(),
              ),
              Text(
                'Sing into your digital wallet.',
                style: MyConstant().h3Style(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              height: 200,
              child: Image.asset(
                "images/logo_mmoney.png",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'LAO MOBILE MONEY',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildTelephone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: size * 0.8,
          child: FormBuilderTextField(
            name: 'msisdn',
            controller: _msisdn,
            keyboardType: TextInputType.number,
            // maxLength: 10,
            decoration: InputDecoration(
              labelText: 'ໝາຍເລກໂທລະສັບ',
              labelStyle: MyConstant().h3NotoStyle(),
              prefixIcon: Icon(
                Icons.phone_callback,
                color: MyConstant.blueDark,
              ),
              enabledBorder: MyConstant().outlineInputBorder(),
              focusedBorder: MyConstant().focusOutlineInputBorder(),
              errorStyle: MyConstant().errNotoStyle(),
              errorBorder: MyConstant().errOutlineInputBorder(),
              focusedErrorBorder: MyConstant().errOutlineInputBorder(),
            ),
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.maxLength(10),
                FormBuilderValidators.minLength(10),
                FormBuilderValidators.numeric(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildBirthDate(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: size * 0.8,
          child: FormBuilderTextField(
            name: 'birthday',
            controller: _birthday,
            decoration: InputDecoration(
              labelText: 'ວັນເດືອນປີເກີດ',
              labelStyle: MyConstant().h3NotoStyle(),
              prefixIcon: Icon(
                Icons.cake_outlined,
                color: MyConstant.blueDark,
              ),
              enabledBorder: MyConstant().outlineInputBorder(),
              focusedBorder: MyConstant().focusOutlineInputBorder(),
              errorStyle: MyConstant().errNotoStyle(),
              errorBorder: MyConstant().errOutlineInputBorder(),
              focusedErrorBorder: MyConstant().errOutlineInputBorder(),
            ),
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            readOnly: true,
            onTap: () => showSheet(
              context,
              child: buildDatePicker(),
              onClicked: () {
                final value = DateFormat('yyyy-MM-dd').format(dateTime);
                _birthday.text = value;
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          minimumYear: 1960,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  Row buildLoginButton(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          width: size * 0.8,
          height: 55,
          child: ElevatedButton(
            style: MyConstant().myButtomStyle(),
            onPressed: () {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                print(_formKey.currentState?.value);
                _loginProcess();
              } else {
                print('### validation failed');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'ເຂົ້າສູ່ລະບົບ',
                  style: TextStyle(
                      fontFamily: 'NotoSansLao',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Future<void> _handLogin() async {
  //   var msisdn = _msisdn.text.trim();
  //   var birthday = _birthday.text.trim();
  //   var url = MyConstant.url + '/getBalance/$msisdn/0';

  //   print(url);
  //   final response = await http.get(Uri.parse(url));
  //   // convert response to ut8
  //   String source = const Utf8Decoder().convert(response.bodyBytes);
  //   if (response.statusCode == 200) {
  //     final Balance balanceModel = Balance.fromJson(
  //       convert.jsonDecode(source),
  //     );
  //     print(balanceModel.birthday);
  //     if (birthday == balanceModel.birthday && msisdn == balanceModel.msisdn) {
  //       // Navigator.push(context,
  //       //     MaterialPageRoute(builder: (context) => const SplashScreen()));
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //           MyConstant.routeSplash, (Route<dynamic> route) => false);
  //     } else {
  //       // showFailedAlert(context, 'Login', 'Login Failed');
  //     }
  //   } else {
  //     // showFailedAlert(context, '${response.statusCode}', '${response.body}.');
  //   }
  // }

  Future _loginProcess() async {
    var msisdn = _msisdn.text.trim();
    var birthday = _birthday.text.trim();
    setState(() {
      isLoading = true;
    });
    // set share prderance
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('msisdn', msisdn);

    // call api singup
    var url = '${MyConstant.urlAddress}/signup';
    Response response;
    var dio = Dio();
    dio.options.connectTimeout = MyConstant.connectTimeout;
    try {
      response = await dio.post(
        url,
        data: {
          'msisdn': msisdn,
          'birthday': birthday,
        },
      );
      print(response);
      final singupModel singupmodel = singupModel.fromJson(response.data);
      print(singupmodel.data?.ref);
      var refCode = singupmodel.data?.ref;
      if (singupmodel.resultCode == 0) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreenPage(msisdn, refCode!)));
      } else {
        showFailedAlert(
          context,
          singupmodel.resultCode.toString(),
          singupmodel.resultDesc.toString(),
        );
        setState(() {
          isLoading = false;
        });
      }
    } on DioError catch (e) {
      print(e.message);
      showFailedAlert(
        context,
        'Exception Error',
        e.message,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

//
}
