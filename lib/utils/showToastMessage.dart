import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

showToastMessage(
    {required String? msg,
    required context,
    backgroundColor,
    textColor,
    fontSize}) {
  return showToast(
    msg,
    textStyle: TextStyle(
        fontSize: fontSize ?? 15.0,
        fontWeight: FontWeight.w500,
        color: textColor ?? Colors.white),
    context: Get.context,
    animation: StyledToastAnimation.slideFromBottom,
    reverseAnimation: StyledToastAnimation.slideToBottom,
    startOffset: const Offset(0.0, 3.0),
    reverseEndOffset: const Offset(0.0, 3.0),
    position: StyledToastPosition.bottom,
    duration: const Duration(seconds: 3),
    animDuration: const Duration(seconds: 1),
    curve: Curves.elasticOut,
    reverseCurve: Curves.fastOutSlowIn,
    backgroundColor: backgroundColor ?? Colors.black,
    isHideKeyboard: true,
    axis: Axis.vertical,
  );
}
