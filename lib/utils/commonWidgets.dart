import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtb/utils/responsiveUi.dart';

import 'appColors.dart';
import 'interText.dart';

Widget StatusCard(String text, {bool isActive = false}) {
  return Padding(
    padding: EdgeInsets.only(
      left: !isActive && text == 'Introduced' ? Resp.size(11) : 0,
      right: !isActive && text == 'In Effect' ? Resp.size(11) : 0,
    ),
    child: Container(
      decoration: ShapeDecoration(
        color:
        isActive ? AppColors.grey.withOpacity(0.25) : Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Resp.size(5))),
      ),
      padding: isActive
          ? EdgeInsets.symmetric(
          vertical: Resp.size(10), horizontal: Resp.size(8))
          : EdgeInsets.symmetric(vertical: Resp.size(13)),
      margin: EdgeInsets.all(Resp.size(3)),
      child: InterText(
        text: text,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}