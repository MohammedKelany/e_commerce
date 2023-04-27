import 'package:flutter/material.dart';

import 'custom_text.dart';
import 'divider_horizontal.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    Key? key,
    required this.image,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String image, text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:(){
        onPressed();
      } ,
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        side:const MaterialStatePropertyAll(BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 20,
            width: 20,
          ),
          const DividerH(width: 50),
           CustomText(text: text, size: 14),
        ],
      ),
    );
  }
}
