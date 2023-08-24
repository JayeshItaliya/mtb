import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/utils.dart';

import 'strings.dart';

class Resp{
  static double h=0,w=0,crosslength=0;
  static double px10=0,px12=0,px14=0,px16=0,px18=0,px24=0,px20=0,px15=0,px11=0;
  static void init(BuildContext context){
    if (cx.read(Keys.crossLength)==null) {
      h=MediaQuery.of(context).size.height;
      w=MediaQuery.of(context).size.width;
      crosslength=pow((h*h)+(w*w),1/2) as double;
      
      cx.write(Keys.crossLength,crosslength);
    }
  }
  static double size(double size){
    if(cx.read(Keys.crossLength)==null){
      h=Get.height;
      w=Get.width;
      crosslength=pow((h*h)+(w*w),1/2) as double;
      cx.write(Keys.crossLength,crosslength);
      double convertValue=size/(cx.read(Keys.crossLength)??crosslength);
      double value=(cx.read(Keys.crossLength)??crosslength)*convertValue;
      return value;
    }
    else{
      double convertValue=size/(cx.read(Keys.crossLength)??crosslength);
      double value=(cx.read(Keys.crossLength)??crosslength)*convertValue;
      return value;
    }
  }
}