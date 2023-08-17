import 'package:flutter/material.dart';
import 'package:mtb/utils/responsiveUi.dart';

import 'appColors.dart';

class CustomDivider extends StatelessWidget {
  final double width;
  final double? start;

  const CustomDivider({super.key, this.width = 50, this.start});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: start??8.0),
      child: SizedBox(
        height: Resp.size(1),
        width: Resp.size(width),
        child: Center(
          child: Container(
            margin: EdgeInsetsDirectional.only(start: start??1.0, end: 1.0),
            height: 5.0,
            color: AppColors.lightGrey,
          ),
        ),
      ),
    );
  }
}
