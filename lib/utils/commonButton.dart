import 'package:flutter/material.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/utils.dart';

class CommonButton extends StatefulWidget {
  final String? text;
  final Function onTap;
  final double? width;
  final double? fontSize;
  final Color? color;
  final Widget? child;
  final FontWeight fontWeight;
  const CommonButton(
      {Key? key,
      this.text,
      required this.onTap,
      this.fontSize,
      this.width,
      this.child,
      this.color,
        this.fontWeight= FontWeight.w700
      })
      : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeightBox(40),
        GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: Resp.crosslength * 0.016,
            ),
            width: widget.width,
            decoration: BoxDecoration(
                color: widget.color ?? AppColors.primaryColor,
                borderRadius:
                    BorderRadius.circular(Resp.size(10))),
            child: widget.child??InterText(
              text: widget.text??"",
              color: AppColors.white,
              fontWeight:widget.fontWeight,
              fontSize: widget.fontSize??Resp.size(18),
            ),
          ),
        ),
      ],
    );
  }
}
