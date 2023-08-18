import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  int i =-1.obs;

  List<dynamic> partyList = [
    ['Democrat',0],
    ['Republican',0],
    ['Independent',0],
    ['Bipartisan',0],
  ].obs;

  List<dynamic> topicList = [
    ['Topic 1',0],
    ['Topic 2',0],
    ['Topic 3',0]
  ].obs;

  List<dynamic> dateList = [
    ['Date 1',0],
    ['Date 2',0],
    ['Date 3',0]
  ].obs;

  List<dynamic> actionList = [
    ['Action 1',0],
    ['Action 2',0],
    ['Action 3',0]
  ].obs;

  List<dynamic> statusList = [
    ['Status 1',0],
    ['Status 2',0],
    ['Status 3',0]
  ].obs;

  void selectData(List<dynamic> list,int index){
    if(list[index][1]==0){
      list[index][1]=1;
    }else{
      list[index][1]=0;
    }
    update();
  }
}
