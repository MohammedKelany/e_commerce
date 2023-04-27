import 'package:flutter/material.dart';

class DividerV extends StatelessWidget {
  const DividerV({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
