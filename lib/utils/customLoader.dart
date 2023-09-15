import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/utils.dart';

import 'appColors.dart';

class CustomLoader extends StatefulWidget {
  final double? topHeight;
  const CustomLoader({super.key,this.topHeight});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: Resp.size(widget.topHeight??(cx.height/2)-(cx.height/6)),
        ),
        const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
