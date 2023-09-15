import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/utils.dart';

Widget commonDropDown(
    {required BuildContext context,
      required List<String> list,
      required RxString mycontrollerValue,
      Color? color,
      EdgeInsetsGeometry? padding,
      String hint = 'Select',
      Function? onTap,
      Border? border,
      Color? hintColor,
      double? fontSize,
      FontWeight? fontWeight,
      bool isHeightBox=true
    }) {
  return Obx(() => Container(
    margin: EdgeInsets.only(bottom: isHeightBox?Resp.size(20):0),
    child: DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        value: list.contains(mycontrollerValue.value)
            ? mycontrollerValue.value
            : null,
        hint: Padding(
          padding: EdgeInsets.only(left: Resp.size(20),),
          child: Row(
            children: [
              Expanded(
                child: InterText(
                  text: hint,
                  fontSize:14,
                  fontWeight:FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        items: list
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: EdgeInsets.only(left: Resp.size(20),),
            child: Text(
              item,
              style: TextStyle(
                fontSize: Resp.size(14),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        )).toList(),

        //value:createReminderController.selectedValue.value,
        onChanged: (value) {
          mycontrollerValue.value = value as String;
          customPrint("dropDownValue==${mycontrollerValue.value.toString()}");
        },
        buttonStyleData: ButtonStyleData(
          width: Resp.w,
          height: Resp.size(52),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Resp.size(10)),
            color: color ?? AppColors.lightBlack,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: EdgeInsets.only( right: Resp.size(15)),
            child: Image.asset("assets/common/dropDown.png",scale:3),
          ),
          openMenuIcon: Padding(
            padding: EdgeInsets.only( right: Resp.size(15)),
            child: Image.asset("assets/common/dropUp.png",scale:3),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: Resp.size(200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Resp.size(10)),
            color: const Color(0xFF363535),
            // color: const Color(0xFF555555),
            // color: AppColors.grey,
          ),
          elevation: 0,
          scrollbarTheme: ScrollbarThemeData(
            radius: Radius.circular(Resp.size(40)),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: Resp.size(40),
        
        //   padding: EdgeInsets.only(left: Resp.size(14), right: Resp.size(14),
        // ),
      ),
    )),
  ));
}
