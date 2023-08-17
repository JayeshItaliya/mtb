import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtb/utils/responsiveUi.dart';

class InterText extends StatelessWidget {
  String? text;
  double? fontSize;
  Color? color;
  FontWeight? fontWeight;
  TextDecoration? textDecoration;
  TextAlign? textAlign;
  double? height;
  List<Shadow>? shadow;
  int? maxLines;
  TextOverflow? textOverflow;
  bool? softWrap;
  InterText({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.color,
    this.textAlign,
    this.height,
    this.shadow,
    this.maxLines,
    this.textOverflow,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: softWrap,
      maxLines: maxLines ?? 1,
      overflow: textOverflow,
      style: GoogleFonts.inter(
        height: height,
        shadows: shadow ?? [],
        fontSize: Resp.size(fontSize??10),
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color??Colors.white,
        decoration: textDecoration,
        decorationStyle: TextDecorationStyle.solid,
      ),
    );
  }
}
