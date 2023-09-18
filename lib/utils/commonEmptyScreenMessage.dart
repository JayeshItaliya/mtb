import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/utils.dart';

import 'appColors.dart';
import 'interText.dart';

class EmptyScreenMessage extends StatefulWidget {
  final double? topHeight;
  final String message;
  const EmptyScreenMessage({super.key,this.topHeight,required this.message});

  @override
  State<EmptyScreenMessage> createState() => _EmptyScreenMessageState();
}

class _EmptyScreenMessageState extends State<EmptyScreenMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: Resp.size(widget.topHeight??(cx.height/2)-(cx.height/6)),
        ),
        InterText(text: widget.message,color: Colors.white,fontSize: Resp.size(16),)
      ],
    );
  }
}
