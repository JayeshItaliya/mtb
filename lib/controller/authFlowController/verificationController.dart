import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/authFlow/changePasswordScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/utils.dart';

class VerificationPasswordController extends GetxController{

  var verificationCode="".obs;

  verificationCodeApiCall(BuildContext context,String emailAddress)async{
    var data={
      'otp': verificationCode.value.toString(),
      'email': emailAddress.toString()
    };
    loadingDialog(context);
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.verifyCode,body: data);
      if(response["success"]==true){
        showSuccessDialog(context,response["message"]);
        if (!context.mounted) return;
        toPushNavigator(context: context, pageName:ChangePasswordScreen(emailAddress:emailAddress.toString(),));
      }
      else if(response["success"]==false){
        showErrorDialog(context,response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}