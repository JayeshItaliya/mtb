import 'package:flutter/cupertino.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/responsiveUi.dart';

class BorderCommonContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderWidth;
  final Color? borderColor;
  final Widget? containerChild;
  const BorderCommonContainer(
      {super.key, this.width,
      this.height,
      this.borderColor,
      this.borderWidth,
      this.containerChild});
  @override
  Widget build(BuildContext context) {
    Resp.init(context);
    return Container(
      height: height ?? Resp.crosslength*0.07,
      width: width ?? Resp.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Resp.crosslength * 0.02),
          border: Border.all(
            width: borderWidth ?? 2,
            color: borderColor ?? AppColors.black,
          )
      ),
      child: containerChild,
    );
  }
}
