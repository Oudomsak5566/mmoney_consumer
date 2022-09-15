import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mmoney_consumer/models/balanceModel.dart';
import 'package:mmoney_consumer/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

//
// test Announcement
class Announcement {
  String image;
  String detail;
  Announcement({required this.image, required this.detail});
}

class _WalletScreenState extends State<WalletScreen> {
  bool isShowName = false;
  bool isShowBalance = false;
  String? _msisdn = "";
  String? _fullname = "";
  int? _balance;

  @override
  void initState() {
    super.initState();
    _getBalance();
  }

  // get Money
  //***************************************************************** */
  Future _getBalance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    balanceModel balancemodel = balanceModel();

    String? msisdn = preferences.getString('msisdn');

    setState(() {});

    Response response;
    var dio = Dio();
    dio.options.connectTimeout = MyConstant.connectTimeout;
    try {
      response = await dio.post(
        '${MyConstant.urlAddress}/getBalance',
        data: {
          "msisdn": msisdn.toString(),
        },
      );
      print('### res _getBalance ===> ${response.data}');

      final balanceModel balancemodel = balanceModel.fromJson(response.data);
      if (balancemodel.resultCode == 0) {
        setState(() {
          _msisdn = msisdn;
          _balance = balancemodel.data?.amount;
          _fullname = balancemodel.data?.firstname;
        });
      } else {}
    } on DioError catch (e) {
      print('### exception ===> $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    // Add Lists Announcement
    List<Announcement> announcements = [
      Announcement(image: "images/banner00.jpg", detail: "ລາຍລະອຽດ ໂຄສະນາ"),
      Announcement(image: "images/banner01.jpg", detail: "ລາຍລະອຽດ ໂຄສະນາ"),
      Announcement(image: "images/banner02.jpg", detail: "ລາຍລະອຽດ ໂຄສະນາ"),
      Announcement(image: "images/banner03.jpg", detail: "ລາຍລະອຽດ ໂຄສະນາ"),
    ];

    //
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            bluidWalletDetail(),
            buildAnnouncement(announcements),
          ],
        ),
      ),
    );
  }

  Container bluidWalletDetail() {
    return Container(
      height: 220,
      child: Stack(
        children: [
          ClipRRect(
            child: Image.asset(
              'images/bg.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 80,
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 20,
                    offset: Offset(5, 15),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  // Profile Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'images/img01.jpg',
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                  ),
                  //
                  // Account Detail Column
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      isShowName ? _fullname! : '❈❈❈❈❈❈❈❈❈❈',
                                      style: GoogleFonts.notoSansLao(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isShowName = isShowName ? false : true;
                                    });
                                  },
                                  icon: isShowName
                                      ? const Icon(Icons.visibility_off_rounded)
                                      : const Icon(Icons.visibility_rounded),
                                  color: MyConstant.primary,
                                  iconSize: 24,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                isShowBalance
                                    ? '₭ ${NumberFormat('#,###').format(_balance)}'
                                    : '₭ ❈❈❈❈❈❈❈',
                                style: GoogleFonts.notoSansLao(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: MyConstant.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShowBalance =
                                        isShowBalance ? false : true;
                                  });
                                },
                                icon: isShowBalance
                                    ? const Icon(Icons.visibility_off_rounded)
                                    : const Icon(Icons.visibility_rounded),
                                color: MyConstant.primary,
                                iconSize: 24,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildAnnouncement(List<Announcement> announcements) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Text(
                ' Announcement',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 150,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: announcements.map((announcement) {
                return box(announcement.detail, announcement.image);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget box(String title, String imageURL) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageURL),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 5),
                  child: Text(
                    title,
                    style: GoogleFonts.notoSansLao(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
