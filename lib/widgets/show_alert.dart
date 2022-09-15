import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utility/my_constant.dart';

void showSuccessAlert(BuildContext context, String title, String desc) async {
  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    headerAnimationLoop: false,
    dialogType: DialogType.SUCCES,
    showCloseIcon: true,
    dismissOnTouchOutside: false,
    title: title,
    titleTextStyle:
        GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
    desc: desc,
    descTextStyle: GoogleFonts.poppins(),
    btnOkOnPress: () {},
  ).show();
}

void showFailedAlert(BuildContext context, String title, String desc) async {
  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    headerAnimationLoop: false,
    dialogType: DialogType.NO_HEADER,
    showCloseIcon: true,
    dismissOnTouchOutside: false,
    btnOkColor: MyConstant.dark,
    title: title,
    titleTextStyle:
        GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
    desc: desc,
    descTextStyle: GoogleFonts.poppins(),
    btnOkOnPress: () {},
  ).show();
}
