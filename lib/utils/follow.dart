import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/utils.dart';

import 'interText.dart';

Widget followBill({
  double? width,
  double? height,
  Function? onTapFollow,
}){
  return Container(
    width: Resp.size(width??75),
    height: Resp.size(height??31),
    decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(Resp.size(5)),
        color: AppColors.grey.withOpacity(0.3)),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/common/followIcon.svg',
          width: Resp.size(14),
          height: Resp.size(14),
        ),
        const WidthBox(6),
        const InterText(
          text: 'Follow',
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ],
    ),
  );
}