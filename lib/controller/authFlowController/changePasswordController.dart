import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../screens/authFlow/signInScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/utils.dart';

class ChangePasswordController extends GetxController{
  final oldPasswordController=TextEditingController().obs;
  final newPasswordController=TextEditingController().obs;
  final confirmPasswordController=TextEditingController().obs;


  changePasswordApiCall(BuildContext context,String emailAddress)async{
    var data={
      'password': newPasswordController.value.text.toString().trim(),
      'c_password': confirmPasswordController.value.text.toString().trim(),
      'email': emailAddress.toString()
    };
    loadingDialog();
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.changePassword,body: data);
      if(response["success"]==true){
        showSuccessDialog(response["message"]);
        if (!context.mounted) return;
        offNavigator(context: context, pageName: const SignInScreen());
      }
      else if(response["success"]==false){
        showErrorDialog(response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}