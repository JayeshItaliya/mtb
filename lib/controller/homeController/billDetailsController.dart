import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtb/model/homeFlowModel/relatedBillModel.dart';

import '../../screens/authFlow/demographicsScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/utils.dart';

class BillDetailsController extends GetxController{

  var relatedModel=RelatedBillModel().obs;
  var isLoading=false.obs;

  postTrending(BuildContext context,String billId,String status)async{
    var data={
      'bill_id': billId,
      'status': status
    };
    try {
      dynamic response=await apiServices.postResponse(url: ApiConfig.likeBill,body: data);
      customPrint(response["message"]);
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }

  Future<RelatedBillModel?> relatedBillApi(BuildContext context,String billNumber,String type)async{
    isLoading.value=true;
    var data={
      'bill_number': billNumber,
      'type': type
    };
    try {
      dynamic response= await apiServices.postResponse(url: ApiConfig.relatedBill,body: data);
      customPrint('related bill data $response');
      isLoading.value=false;
      RelatedBillModel model=RelatedBillModel.fromJson(response);
      return model;
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
      isLoading.value=false;
    }
    return null;
  }
}