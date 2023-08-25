import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../screens/authFlow/demographicsScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/utils.dart';

class BillDetailsController extends GetxController{
  RxBool upValue=false.obs;
  RxBool downValue=false.obs;

  postTrending(BuildContext context,String billId,String status)async{
    var data={
      'bill_id': billId,
      'status': status
    };
    loadingDialog();
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.likeBill,body: data);
      if(response["success"]==true){
        showSuccessDialog("Sign in done successfully");
        customPrint("loginToken===>${response["token"]}");
        if (!context.mounted) return;
        offNavigator(context: context, pageName: const DemoGraphicsScreen());
      }
      else if(response["success"]==false){
        showErrorDialog(response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}