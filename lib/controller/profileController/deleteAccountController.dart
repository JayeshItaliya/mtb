import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/signUpScreen.dart';

import '../../screens/authFlow/signInScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/utils.dart';

class DeleteAccountController extends GetxController{
  deleteAccountApiCall(BuildContext context)async{
    try {
      loadingDialog();
      dynamic response= await apiServices.deleteResponse(context:context,url: ApiConfig.deleteAccount);
      if(response["success"]==true){
        showSuccessDialog(response["message"]);
        if (!context.mounted) return;
        offNavigator(context: context,pageName:const SignUpScreen());
      }
      else if(response["success"]==false){
        showSuccessDialog(response["message"]);
      }
    } on Exception catch (e) {
      customPrint(e.toString());
      showSuccessDialog("OOPS!");
    }
  }
}