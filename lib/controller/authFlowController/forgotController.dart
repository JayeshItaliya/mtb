import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../screens/authFlow/verificationScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/utils.dart';

class ForgotController extends GetxController{
  final emailController=TextEditingController().obs;


  forgotPasswordApiCall(BuildContext context)async{
    var data={
      'email': emailController.value.text.toString().trim()
    };
    loadingDialog();
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.forgotPassword,body: data);
      if(response["success"]==true){
        showSuccessDialog(response["message"]);
        if (!context.mounted) return;
        toPushNavigator(context: context, pageName:VerificationScreen(emilAddress: emailController.value.text.toString().trim(),));
      }
      else if(response["success"]==false){
        showErrorDialog(response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}