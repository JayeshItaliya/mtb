import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/main.dart';
import 'package:mtb/screens/authFlow/signInScreen.dart';
import 'package:mtb/services/api_config.dart';
import 'package:mtb/utils/circularLoader.dart';

import '../../screens/authFlow/demographicsScreen.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/strings.dart';
import '../../utils/utils.dart';

class SignUpController extends GetxController{
  RxBool checkValue=false.obs;
  final fullNameController=TextEditingController().obs;
  final emailController=TextEditingController().obs;
  final passwordController=TextEditingController().obs;
  final confirmPasswordController=TextEditingController().obs;

  signUpApiCall(BuildContext context)async{
    var data={
      'name': fullNameController.value.text.toString().trim(),
      'email': emailController.value.text.toString().trim(),
      'password': passwordController.value.text.toString().trim(),
      'c_password': confirmPasswordController.value.text.toString().trim()
    };
    loadingDialog();
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.signUp,body: data);
      if(response["success"]==true){
        showSuccessDialog("Sign up done successfully");
        if (!context.mounted) return;
        offNavigator(context: context, pageName:   const SignInScreen());
      }
     else if(response["success"]==false){
        showErrorDialog(response["message"]);
      }
    } on Exception catch (e) {
     customPrint("Error=>>${e.toString()}");
    }
  }
}