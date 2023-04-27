import 'package:flutter/material.dart';


class DividerH extends StatelessWidget {
  const DividerH({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
