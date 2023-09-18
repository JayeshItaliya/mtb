import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/services/api_call.dart';

import '../../model/homeFlowModel/billListModel.dart';
import '../../services/api_config.dart';
import '../../utils/utils.dart';

class SearchControllers extends GetxController{
  RxBool isSearch=false.obs;
  RxBool isLoading=false.obs;
  var searchbarController = TextEditingController().obs;
  var billDataList=List<BillListModel>.empty(growable: true).obs;

  void setSearchMode(bool isSearch){
    this.isSearch.value=isSearch;
    update();
  }

  Future<void> getSearchedBillDataAPI(BuildContext context,String keyword)async {
    isLoading.value=true;
   await TaskProvider().getSearchedBillData(context,keyword).then((value) {
      customPrint(value);
      if(value!=null){

        billDataList.clear();
        billDataList.addAll(value);
        customPrint(billDataList);
        isLoading.value=false;
        update();
      }
      else{
        isLoading.value=false;
        customPrint('Data not found');
      }
    });
  }


}