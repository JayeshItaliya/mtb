import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/signUpScreen.dart';

import '../../screens/authFlow/signInScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/strings.dart';
import '../../utils/utils.dart';

class DeleteAccountController extends GetxController{
  deleteAccountApiCall(BuildContext context)async{
    try {
      loadingDialog(context);
      dynamic response= await apiServices.deleteResponse(context:context,url: ApiConfig.deleteAccount);
      if(response["success"]==true){
        showSuccessDialog(context,response["message"]);


        cx.write(Keys.token, '');
        cx.write(Keys.userEmail, '');
        cx.write(Keys.password, '');
        cx.write(Keys.isCompulsoryDemographics, false);
        if (!context.mounted) return;
        offAllNavigator(context: context,pageName:const SignInScreen());
        // if (!context.mounted) return;
        // offAllNavigator(context: context,pageName:const SignUpScreen());
      }
      else if(response["success"]==false){
        showSuccessDialog(context,response["message"]);
      }
    } on Exception catch (e) {
      customPrint(e.toString());
      showSuccessDialog(context,"OOPS!");
    }
  }
}