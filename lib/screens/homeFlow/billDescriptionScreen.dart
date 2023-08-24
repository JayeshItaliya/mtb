import 'package:flutter/material.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/utils.dart';

import '../../utils/responsiveUi.dart';

class BillDescriptionScreen extends StatefulWidget {
  const BillDescriptionScreen({super.key});

  @override
  State<BillDescriptionScreen> createState() => _BillDescriptionScreenState();
}

class _BillDescriptionScreenState extends State<BillDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const HeightBox(35),
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
              margin: EdgeInsets.symmetric(horizontal: Resp.size(12)),
              child: SingleChildScrollView(
                  child: InterText(
                text: demoText,
                maxLines: demoText.length,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.white,
                height: 1.5,
              )),
            ),
          ),
          const HeightBox(12),
        ],
      ),
    );
  }
}
