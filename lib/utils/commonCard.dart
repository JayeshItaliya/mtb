import 'package:flutter/material.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/responsiveUi.dart';

class CommonCard extends StatelessWidget {
  double? height;
  double? width;
  Widget? cardChild;
  CommonCard({super.key, this.height, this.width, this.cardChild});

  @override
  Widget build(BuildContext context) {
    Resp.init(context);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Resp.crosslength*0.01),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(182, 179, 179, 0.5),
            blurRadius: 7.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: cardChild,
    );
  }
}
