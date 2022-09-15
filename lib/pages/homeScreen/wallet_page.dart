// // ignore_for_file: prefer_const_constructors, camel_case_types

// import 'dart:convert';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
// import 'package:mmoney_consumer/pages/homeScreen/scanqr_page.dart';
// import '../../models/balanceModel.dart';
// import '../../utility/my_constant.dart';

// class WallletPage extends StatefulWidget {
//   const WallletPage({Key? key}) : super(key: key);

//   @override
//   State<WallletPage> createState() => _WallletPageState();
// }

// class _WallletPageState extends State<WallletPage> {
//   var contrianerRadius = Radius.circular(30);
//   String? msisdn = '';
//   int? balance = 0;
//   String? birthday = '';
//   String? firstname = '';
//   // String? active = '';
//   bool isShowMoney = false;

//   Future _getBalance() async {
//     final response = await http
//         .get(Uri.parse('http://172.28.14.87:8099/getBalance/2052555999/0'));

//     // convert response to ut8
//     String source = Utf8Decoder().convert(response.bodyBytes);

//     if (response.statusCode == 200) {
//       final Balance balanceModel = Balance.fromJson(
//         convert.jsonDecode(source),
//       );
//       setState(() {
//         msisdn = balanceModel.msisdn;
//         balance = balanceModel.amount;
//         birthday = balanceModel.birthday;
//         firstname = balanceModel.firstname;
//       });
//     } else {
//       throw Exception('${response.statusCode}.');
//     }
//   }

//   //
//   //
//   void _showSuccessAlert(
//       BuildContext context, String title, String desc) async {
//     AwesomeDialog(
//       context: context,
//       animType: AnimType.BOTTOMSLIDE,
//       headerAnimationLoop: false,
//       dialogType: DialogType.SUCCES,
//       showCloseIcon: true,
//       title: title,
//       titleTextStyle: TextStyle(
//         fontFamily: 'NotoSansLao',
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//       ),
//       desc: desc,
//       descTextStyle: TextStyle(
//         fontFamily: 'NotoSansLao',
//       ),
//       btnOkOnPress: () {
//         print('OnClcik');
//       },
//       // btnOkIcon: Icons.check,
//       onDissmissCallback: (type) {
//         print('Dialog Dissmiss from callback $type');
//       },
//     ).show();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getBalance();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double size = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: MyConstant.primary,
//       appBar: AppBar(
//         elevation: 0.0,
//         title: const Text('My Account'),
//         backgroundColor: MyConstant.primary,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: SizedBox(
//               height: 200,
//               child: Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         buildShowAccDescription(),
//                         SizedBox(height: 15),
//                         buildShowBalance(),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: contrianerRadius,
//                   topRight: contrianerRadius,
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Text(
//                       'Promotions',
//                       // style: const TextStyle(
//                       //   fontSize: 18,
//                       //   fontWeight: FontWeight.bold,
//                       //   // fontFamily: 'NotoSansLao',
//                       // ),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView(
//                       children: const <Widget>[],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => const ScanQrPage(),
//           ));
//         },
//         backgroundColor: Colors.grey[900],
//         child: const Icon(
//           Icons.qr_code_scanner_rounded,
//           size: 40,
//         ),
//       ),
//     );
//   }

//   Column buildShowAccDescription() {
//     return Column(
//       children: [
//         Text(
//           firstname!,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   Column buildShowBalance() {
//     return Column(
//       children: [
//         Column(
//           children: [
//             Text(
//               isShowMoney
//                   ? NumberFormat('#,###').format(balance)
//                   : 'x,xxx,xxx', //₭
//               style: const TextStyle(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   isShowMoney = isShowMoney ? false : true;
//                 });
//               },
//               icon: isShowMoney
//                   ? Icon(Icons.visibility_off_rounded)
//                   : Icon(Icons.visibility_rounded),
//               color: Colors.white,
//               iconSize: 30,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class bluidBalanceCard extends StatelessWidget {
//   const bluidBalanceCard({
//     Key? key,
//     required this.sizeDisplay,
//     required this.balanceAcc,
//   }) : super(key: key);
//   final double sizeDisplay;
//   final double balanceAcc;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       height: 130,
//       width: sizeDisplay * 1,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//             colors: [
//               Color.fromARGB(255, 246, 16, 0),
//               Color.fromARGB(136, 233, 28, 28),
//               Color.fromARGB(255, 211, 16, 2),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomCenter,
//             stops: [0, 0.5, 0.9]),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.6),
//             spreadRadius: 7,
//             blurRadius: 7,
//             offset: Offset(5, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             'ຍອດເງິນຂອງທ່ານ',
//             style: const TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.w900,
//               color: Colors.white,
//               fontFamily: 'NotoSansLao',
//             ),
//           ),
//           const Spacer(),
//           Text(
//             '${NumberFormat('#,###').format(balanceAcc)} ₭',
//             style: const TextStyle(
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
