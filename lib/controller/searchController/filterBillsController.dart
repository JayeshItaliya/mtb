import 'package:get/get.dart';

import '../../utils/appColors.dart';

class FilterBillsController extends GetxController {
  var dropDownIndex = 99.obs;

  var partyList = [
    ['Democrat',0].obs,
    ['Republican',0].obs,
    ['Independent',0].obs,
    ['Bipartisan',0].obs,
  ].obs;

  var buttonColor=AppColors.lightGrey.obs;
  var topicList = [
    ['Agriculture',0].obs,
    ['Army',0].obs,
    ['Civil Rights',0].obs,
    ['Policing',0].obs,
    ['Economics',0].obs,
    ['Education',0].obs,
    ['Immigration',0].obs,
    ['Environment & Energy',0].obs,
    ['Government',0].obs,
    ['Welfare',0].obs,
    ['Labor',0].obs,
    ['Tech',0].obs,
    ['Taxes',0].obs,
    ['Health',0].obs,
    ['IR',0].obs,
    ['Infrastructure',0].obs,
    ['Miscellaneous',0].obs
  ].obs;

  var dateList = [
    ['Least Recent',0].obs,
    ['Most Recent',0].obs,
  ].obs;

  var actionList = [
    ['Introduced',0].obs,
    ['Passed House',0].obs,
    ['Passed Senate',0].obs,
    ['In Effect',0].obs,
  ].obs;

  var statusList = [
    ['Following',0].obs,
    ['Not Following',0].obs,
  ].obs;

  void selectData(var list,int index){
    if(list[index][1]==0){
      list[index][1]=1;
    }else{
      list[index][1]=0;
    }
    update();
  }
}
