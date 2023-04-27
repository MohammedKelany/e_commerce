import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor, required this.width,
  }) : super(key: key);
  final String text;
  final Function onPressed;
  final Color color, textColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      height: 50,
      minWidth: width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: CustomText(
        text: text,
        size: 16,
        color: textColor,
        align: Alignment.center,
      ),
    );
  }
}
