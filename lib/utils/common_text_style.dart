import 'package:annapurna_finance/utils/strings.dart';
import 'package:annapurna_finance/utils/theme_config.dart';
import 'package:flutter/material.dart';

class CommonTextStyle{

  static TextStyle titleTextStyle = TextStyle(
      fontFamily: Strings.proximaNovaFont,
      fontSize: 16,
      letterSpacing: 0.5,
      color: const Color(0xff585858),
      fontWeight: FontWeight.w600);

  static TextStyle subTitleTextStyle({Color? color}) {
    return TextStyle(
        fontFamily: Strings.proximaNovaFont,
        fontSize: 13,
        color: color,
        fontWeight: FontWeight.normal);
  }

  static TextStyle headerText(){
    return TextStyle(
        fontFamily: Strings.proximaNovaFont,
        fontWeight: FontWeight.w600,
        height: 1.36,
        fontSize: 18.0,
        color: Colors.black);
  }

}


