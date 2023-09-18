import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../model/homeFlowModel/billListModel.dart';
import '../../services/api_call.dart';
import '../../services/api_config.dart';
import '../../utils/utils.dart';

class HomeController extends GetxController{
  RxBool upValue=false.obs;
  RxBool downValue=false.obs;
  List<BillListModel> billDataList=List<BillListModel>.empty(growable: true).obs;
  List<BillListModel> filteredDataList=List<BillListModel>.empty(growable: true).obs;


  RxBool isLoading=false.obs;
  RxBool isFilterLoading=false.obs;

  Future<void> getBillDataAPI(BuildContext context) async {
    isLoading.value=true;
    await TaskProvider().getBillData(context).then((value) {
      customPrint(value);
      if(value!=null){
        billDataList.clear();
        billDataList.addAll(value);
        customPrint("billDataList");
        customPrint(billDataList);
        customPrint(billDataList.length);
        isLoading.value=false;
        update();
      }
      else{
        isLoading.value=false;
        customPrint('Data not found');
      }
    });
  }

  getFilteredDataAPI(BuildContext context,String metaData){
    isFilterLoading.value=true;
    TaskProvider().getFilteredData(context,metaData).then((value) {
      customPrint(value);
      if(value!=null){
        filteredDataList.clear();
        filteredDataList.addAll(value);
        customPrint(filteredDataList);
        isFilterLoading.value=false;
        update();
      }
      else{
        isFilterLoading.value=false;
        customPrint('Data not found');
      }
    });
  }

}