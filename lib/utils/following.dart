import 'package:flutter/material.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'appColors.dart';
import 'interText.dart';

Widget followingBill({
  double? width,
  double? height,
}){
  return Container(
  width: Resp.size(width??75),
  height: Resp.size(height??31),
    decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(Resp.size(5)),
        color: AppColors.primaryColor),
    alignment: Alignment.center,
    child: const InterText(
      text: 'Following',
      fontWeight: FontWeight.w600,
    ),
  );
}