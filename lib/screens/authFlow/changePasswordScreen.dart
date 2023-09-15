import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/changePasswordController.dart';
import 'package:mtb/utils/textFormFields.dart';
import '../../utils/appColors.dart';
import '../../utils/commonButton.dart';
import '../../utils/interText.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String emailAddress;

  const ChangePasswordScreen({super.key, required this.emailAddress});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final chPassKey = GlobalKey<FormState>();
  final changePasswordController= Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return SafeArea(
            bottom: true,
            top: true,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Form(
                key: chPassKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  shrinkWrap: true,
                  padding: defaultScreenPadding(),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    customAppBar(
                        title: 'Change Password',
                        isSuffix: false,
                        context: context),
                    Image.asset(
                      'assets/authFlow/changePassword.png',
                      scale: 2.5,
                      height: Resp.size(250),
                    ),
                    const HeightBox(21),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Resp.size(10)),
                      child: InterText(
                        text:
                            'Set new password for your account to login and access all the features.',
                        textOverflow: TextOverflow.clip,
                        color: AppColors.lightGrey,
                        fontSize: Resp.size(14),
                        fontWeight: FontWeight.w400,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const HeightBox(25),
                    AppWidget.getTextField(
                        hintText: "New Password",
                        inputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        textEditingController:
                            controller.newPasswordController.value,
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
                        textEditingController:
                            controller.confirmPasswordController.value,
                        isPassword: true,
                        validationFunction: (val) {
                          if (val.toString().isEmpty) {
                            return "Please Enter Confirm Password";
                          } else if (val.toString().length < 8) {
                            return "Password Length Must Be 8 Or Greater";
                          }
                          return null;
                        }
                        ),
                    CommonButton(
                      text: "Submit",
                      onTap: () {
                        if (chPassKey.currentState!.validate()) {
                          if (controller.newPasswordController.value.text
                                  .toString() !=
                              controller.confirmPasswordController.value.text
                                  .toString()) {
                            showLongToast(
                                "New Password and Confirm Password Doesn't Match");
                          } else if (chPassKey.currentState!.validate()) {
                            controller.changePasswordApiCall(
                                context, widget.emailAddress);
                          }
                        }
                      },
                    ),
                    const HeightBox(25),
                  ],
                ),
              ),
            ),
          );
        });
  }
  @override
  void dispose() {
    super.dispose();
    Get.delete<ChangePasswordController>();
  }
}
