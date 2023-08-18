import 'package:get/get.dart';

class FilterTopicsController extends GetxController {
  var dropDownIndex = 99.obs;


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
    ['IR',0].obs
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
