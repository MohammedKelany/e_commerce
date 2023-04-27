import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    required this.size,
    this.align = Alignment.centerLeft,
    this.color = Colors.black, this.height,
  }) : super(key: key);
  final String text;
  final double size;
  final Alignment align;
  final Color color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: color,
          height: height,
        ),
      ),
    );
  }
}
