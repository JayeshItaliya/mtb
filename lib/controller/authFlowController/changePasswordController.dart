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


  changePasswordApiCall(BuildContext context,String emailAddress,{bool isFromProfile=false})async{
    var data={
      'email': emailAddress.toString(),
      'old_password': oldPasswordController.value.text.toString().trim(),
      'password': newPasswordController.value.text.toString().trim(),
      'c_password': confirmPasswordController.value.text.toString().trim(),
    };
    loadingDialog(context);
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.changePassword,body: data);
      if(response["success"]){
        showSuccessDialog(context,response["message"]);
        // showLongToast('Password Changed Successfully');
        if(isFromProfile){
          oldPasswordController.value.text='';
          newPasswordController.value.text='';
          confirmPasswordController.value.text='';
          Get.back();
        }
        else{
          if (!context.mounted) return;
          offAllNavigator(context: context, pageName: const SignInScreen());
        }

      }
      else if(response["success"]==false){
        showErrorDialog(context,response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}