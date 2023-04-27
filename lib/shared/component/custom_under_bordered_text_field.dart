import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'custom_text.dart';

class CustomUnderTextFormField extends StatelessWidget {
  const CustomUnderTextFormField({
    Key? key,
    required this.hint,
    required this.fieldHint,
    this.isPass = false,
    required this.inputType,
    required this.controller,
    this.validator,
  }) : super(key: key);
  final String hint, fieldHint;
  final bool isPass;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: hint,
          size: 14,
          color: Colors.grey.shade600,
        ),
        TextFormField(
          controller: controller,
          cursorColor: primaryColor,
          validator: validator,
          obscureText: isPass,
          keyboardType: inputType,
          style: TextStyle(letterSpacing:isPass?10: 1),
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: fieldHint,
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor)),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
