import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/main.dart';
import 'package:mtb/mainPage.dart';
import '../../screens/authFlow/demographicsScreen.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/strings.dart';
import '../../utils/utils.dart';

class SignInController extends GetxController{
  RxBool checkValue=(cx.read(Keys.rememberMe)??false?true:false).obs;
  final emailController=TextEditingController(text: cx.read(Keys.rememberMeEmail) ?? '').obs;
  final passwordController=TextEditingController(text: cx.read(Keys.rememberMePassword) ?? '').obs;


  signInApiCall(BuildContext context)async{
    var data={
      'email': emailController.value.text.toString().trim(),
      'password': passwordController.value.text.toString().trim()
    };
    loadingDialog(context);
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.signIn,body: data);
      if(response["success"]==true){
        if (!context.mounted) return;
        showSuccessDialog(context,"Sign in done successfully");
        customPrint("loginToken===>${response["token"]}");
        cx.write(Keys.token, response["token"]);
        customPrint("localStorageToken==>${cx.read(Keys.token,)}");
        if(checkValue.value){
          cx.write(Keys.rememberMeEmail, emailController.value.text.toString().trim());
          cx.write(Keys.rememberMePassword, passwordController.value.text.toString().trim());
          customPrint("rememberMeEmail==>${cx.read(Keys.rememberMeEmail,)}");
          customPrint("rememberMePassword===>${cx.read(Keys.rememberMePassword,)}");
        }
        else{
          cx.write(Keys.rememberMeEmail,'');
          cx.write(Keys.rememberMePassword,'');
        }
        cx.write(Keys.userEmail, emailController.value.text.toString().trim());
        cx.write(Keys.password, passwordController.value.text.toString().trim());
        cx.write(Keys.rememberMe,checkValue.value );
        // Get.offAll(() => DemoGraphicsScreen());
        if (!context.mounted) return;
          offAllNavigator(context: context, pageName: const MainPageScreen());
      }
      else if(response["success"]==false){
        if (!context.mounted) return;
        showErrorDialog(context,response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}