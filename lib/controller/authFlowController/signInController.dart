import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/main.dart';
import '../../screens/authFlow/demographicsScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/strings.dart';
import '../../utils/utils.dart';

class SignInController extends GetxController{
  RxBool checkValue=false.obs;
  final emailController=TextEditingController().obs;
  final passwordController=TextEditingController().obs;


  signInApiCall(BuildContext context)async{
    var data={
      'email': emailController.value.text.toString().trim(),
      'password': passwordController.value.text.toString().trim()
    };
    loadingDialog();
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.signIn,body: data);
      if(response["success"]==true){
        showSuccessDialog("Sign in done successfully");
        customPrint("loginToken===>${response["token"]}");
        storage.write(Keys.token, response["token"]);
        customPrint("localStorageToken==>${storage.read(Keys.token,)}");
        if(checkValue.value==true){
          storage.write(Keys.userId, emailController.value.text.toString().trim());
          storage.write(Keys.password, passwordController.value.text.toString().trim());
          customPrint("userId==>${storage.read(Keys.userId,)}");
          customPrint("password===>${storage.read(Keys.password,)}");
        }
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