import 'package:flutter/material.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/responsiveUi.dart';

class RadioButtonCommon{
  static Widget radio_btn(String label,bool selected,Function ontap) {
    return InkWell(
      onTap: (){
        ontap();
      },
      child: Row(
        children: [
          Container(
              height: Resp.crosslength*0.025,
              width: Resp.crosslength*0.025,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.appMainColors,width: 2)),
              child: selected?Container(
                height: Resp.crosslength*0.015,
                width: Resp.crosslength*0.015,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.redAccents,
                ),

              ):SizedBox()),
          InterText(text: '  $label',color: AppColors.gray,fontSize: Resp.crosslength*0.018,fontWeight: FontWeight.w400,)
        ],
      ),
    );
  }
}