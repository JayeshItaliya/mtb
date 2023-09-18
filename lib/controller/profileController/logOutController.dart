import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/signInScreen.dart';
import 'package:mtb/screens/authFlow/signUpScreen.dart';
import 'package:mtb/services/api_config.dart';
import 'package:mtb/utils/circularLoader.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/utils.dart';

import '../../utils/strings.dart';

class LogOutController extends GetxController{

  logOutApiCall(BuildContext context)async{
    try {
      dynamic response= await apiServices.postResponse(context:context,url: ApiConfig.logout);
      if(response["success"]){
        showLongToast("User Logged Out Successfully");
        cx.write(Keys.token, '');
        cx.write(Keys.userEmail, '');
        cx.write(Keys.password, '');
        cx.write(Keys.isCompulsoryDemographics, false);
        if (!context.mounted) return;
        offAllNavigator(context: context,pageName:const SignInScreen());
      }
      else if(response["success"]==false){
      }
    } on Exception catch (e) {
      print(e.toString());
      showSuccessDialog(context,"OOPS!");
    }
  }
}