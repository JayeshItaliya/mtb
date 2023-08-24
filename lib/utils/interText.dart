import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtb/utils/responsiveUi.dart';

class InterText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final double? height;
  final List<Shadow>? shadow;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  const InterText({
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
