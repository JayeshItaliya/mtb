import 'package:flutter/material.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/utils.dart';

import '../../utils/responsiveUi.dart';

class BillDescriptionScreen extends StatefulWidget {
  final String demoText;
  const BillDescriptionScreen({super.key,required this.demoText});

  @override
  State<BillDescriptionScreen> createState() => _BillDescriptionScreenState();
}

class _BillDescriptionScreenState extends State<BillDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: defaultScreenPadding(),
          child: Column(
            children: [
              customAppBar(
                  title: 'Bill Description',
                  context: context,
                  fontWeight: FontWeight.w400,
                  isSuffix: false),
              const HeightBox(20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBlack,
                    borderRadius: BorderRadius.circular(Resp.size(12)),
                  ),
                  padding: EdgeInsets.all(Resp.size(14)),
                  child: SingleChildScrollView(
                      child: InterText(
                    text: widget.demoText,
                    maxLines: widget.demoText.length,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.justify,
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.3),
                    height: 1.5,
                  )),
                ),
              ),
              const HeightBox(12),
            ],
          ),
        ),
      ),
    );
  }
}
