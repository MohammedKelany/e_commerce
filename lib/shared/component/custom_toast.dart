import 'package:e_commerce/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates {
  ERROR,
  EDIT,
  SUCCESS,
}

Color getToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return primaryColor;
    case ToastStates.EDIT:
      return Colors.amberAccent;
    default:
      return Colors.red;
  }
}

void showToast({required text, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: getToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}
