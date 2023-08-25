import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/signInScreen.dart';
import 'package:mtb/screens/authFlow/signUpScreen.dart';
import 'package:mtb/services/api_config.dart';
import 'package:mtb/utils/circularLoader.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/utils.dart';

class LogOutController extends GetxController{

  logOutApiCall(BuildContext context)async{
    try {
      loadingDialog();
      dynamic response= await apiServices.postResponse(context:context,url: ApiConfig.logout);
      if(response["success"]==true){
        showSuccessDialog(response["message"]);
        if (!context.mounted) return;
        offNavigator(context: context,pageName:const SignInScreen());
      }
      else if(response["success"]==false){
        showSuccessDialog(response["message"]);
      }
    } on Exception catch (e) {
      print(e.toString());
      showSuccessDialog("OOPS!");
    }
  }
}