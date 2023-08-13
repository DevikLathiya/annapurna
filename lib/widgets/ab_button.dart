import 'package:flutter/material.dart';

class ABButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingLeft;
  final double? paddingRight;

  const ABButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: paddingTop!,
          bottom: paddingBottom!,
          left: paddingLeft!,
          right: paddingRight!),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          minimumSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.055),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onPressed: onPressed,
        child: Text(text!,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
