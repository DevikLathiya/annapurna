import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/theme_config.dart';

class PBButtonSecond extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final Color? color;
  final double? height;

  const PBButtonSecond({
    Key? key,
    required this.onPressed,
    required this.child,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 48.0.h,
      minWidth: MediaQuery.of(context).size.width - 32,
      onPressed: onPressed,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0.r),
        side: BorderSide(color: ThemeColor.grey),
      ),
      textColor: Colors.black,
      color: color ?? Colors.white,
      splashColor: ThemeColor.hintColor,
      child: child,
    );
  }
}
