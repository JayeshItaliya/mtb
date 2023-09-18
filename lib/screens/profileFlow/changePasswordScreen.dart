import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/changePasswordController.dart';
import 'package:mtb/main.dart';
import 'package:mtb/utils/textFormFields.dart';

import '../../utils/commonButton.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/strings.dart';
import '../../utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final changeController = Get.put(ChangePasswordController());
  final chPassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: chPassKey,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: defaultScreenPadding(),
            children: [
              customAppBar(title: 'Change Password',isSuffix: false,context: context),

              const HeightBox(38),
              AppWidget.getTextField(
                hintText: "Enter Old Password",
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textEditingController: changeController.oldPasswordController.value,
                validationFunction: (val){
                  if (val.toString().isEmpty) {
                    return "Please Enter Old Password";
                  }
                  else if (val.toString().length < 8) {
                    return "Password Length Must Be 8 Or Greater";
                  }
                }
              ),
              const HeightBox(20),
              AppWidget.getTextField(
                  hintText: "Enter New Password",
                  inputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  textEditingController: changeController.newPasswordController.value,
                  isPassword: true,
                  validationFunction: (val) {
                    if (val.toString().isEmpty) {
                      return "Please Enter New Password";
                    } else if (val.toString().length < 8) {
                      return "Password Length Must Be 8 Or Greater";
                    }
                    return null;
                  }
              ),
              const HeightBox(20),
              AppWidget.getTextField(
                  hintText: "Confirm Password",
                  inputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  textEditingController: changeController.confirmPasswordController.value,
                  isPassword: true,
                  validationFunction: (val) {
                    if (val.toString().isEmpty) {
                      return "Please Enter Confirm Password";
                    } else if (val.toString().length < 8) {
                      return "Password Length Must Be 8 Or Greater";
                    } else if (changeController
                        .confirmPasswordController.value.text
                        .toString() !=
                        changeController
                            .newPasswordController.value.text
                            .toString()) {
                      return "Password Doesn't Match";
                    }else if (changeController
                        .oldPasswordController.value.text
                        .toString() ==
                        changeController
                            .newPasswordController.value.text
                            .toString()) {
                      return "New Password Cannot Be Same As Old Password";
                    }
                    return null;
                  }
              ),
              const HeightBox(250),
              CommonButton(
                text: "Change Password",
                onTap: () {
                    if (chPassKey.currentState!.validate()) {
                      if (changeController.newPasswordController.value.text
                          .toString() !=
                          changeController.confirmPasswordController.value.text
                              .toString()) {
                        showLongToast(
                            "New Password and Confirm Password Doesn't Match");
                      } else if (chPassKey.currentState!.validate()) {
                        changeController.changePasswordApiCall(context, cx.read(Keys.userEmail),isFromProfile: true);
                      }
                    }
                },
              ),
              const HeightBox(25)
            ],
          ),
        ),
      ),
    );  }
}
