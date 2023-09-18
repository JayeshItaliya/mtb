import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mtb/main.dart';
import 'package:mtb/screens/authFlow/signInScreen.dart';
import 'package:mtb/services/api_config.dart';
import 'package:mtb/utils/circularLoader.dart';

import '../../screens/authFlow/chooseTopicsScreen.dart';
import '../../screens/authFlow/demographicsScreen.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/strings.dart';
import '../../utils/utils.dart';

class SignUpController extends GetxController {
  RxBool checkValue = false.obs;
  final fullNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  signUpApiCall(BuildContext context) async {
    var data = {
      'name': fullNameController.value.text.toString().trim(),
      'email': emailController.value.text.toString().trim(),
      'password': passwordController.value.text.toString().trim(),
      'c_password': confirmPasswordController.value.text.toString().trim()
    };
    loadingDialog(context);
    try {
      dynamic response = await apiServices.postResponse(
          context: context, url: ApiConfig.signUp, body: data);
      if (response["success"] == true) {
        showSuccessDialog(context, "",showMessage: false);
        Fluttertoast.cancel();

        customPrint("signUp===>${response["data"]["token"]}");

        cx.write(Keys.token, response["data"]["token"]);
        cx.write(Keys.userEmail, emailController.value.text.toString().trim());
        cx.write(
            Keys.password, passwordController.value.text.toString().trim());
        cx.write(Keys.isCompulsoryDemographics, true);

        customPrint("localStorageToken==>${cx.read(
          Keys.token,
        )}");
        customPrint("userId==>${cx.read(
          Keys.userEmail,
        )}");
        customPrint("password===>${cx.read(
          Keys.password,
        )}");

        if (!context.mounted) return;
        offAllNavigator(context: context, pageName: const ChooseTopicsScreen());
      } else if (response["success"] == false) {
        showErrorDialog(context, response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}
