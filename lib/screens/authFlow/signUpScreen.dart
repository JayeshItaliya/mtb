import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/demographicsScreen.dart';
import 'package:mtb/screens/authFlow/signInScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/textFormFields.dart';

import '../../controller/authFlowController/signUpController.dart';
import '../../utils/customDivider.dart';
import '../../utils/interText.dart';
import '../../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.put(SignUpController());
  final signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                'assets/authFlow/signUpBackground.png',
              ),
              fit: BoxFit.fill,
            )),
        child: Form(
          key: signUpKey,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Resp.size(12)),
            children: [
              const HeightBox(
                75,
              ),
              SizedBox(
                height: Resp.size(78),
                width: Resp.size(188),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Resp.size(90)),
                  child: Center(
                    child: Image.asset(
                      'assets/common/logo.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              const HeightBox(100),
              AppWidget.getTextField(
                  hintText: "Full Name",
                  inputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController:
                      signUpController.fullNameController.value,
                  validationFunction: (val) {
                    if (val.toString().isEmpty) {
                      return "Please Enter Full Name";
                    }
                    return null;
                  }),
              const HeightBox(20),
              AppWidget.getTextField(
                  hintText: "Email",
                  inputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: signUpController.emailController.value,
                  validationFunction: (val) {
                    if (val.toString().isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  }),
              const HeightBox(20),
              AppWidget.getTextField(
                  hintText: "Password",
                  inputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController:
                      signUpController.passwordController.value,
                  isPassword: true,
                  validationFunction: (val) {
                    if (val.toString().isEmpty) {
                      if (val.toString().length > 8) {
                        return "Password Length Must Be 8 Or Greater";
                      }
                      return "Please Enter Email";
                    }
                    return null;
                  }),
              const HeightBox(20),
              AppWidget.getTextField(
                  hintText: "Confirm Password",
                  inputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController:
                      signUpController.confirmPasswordController.value,
                  isPassword: true,
                  validationFunction: (val) {
                    if (val.toString().isEmpty) {
                      return "Please Enter Confirm Password";
                    }
                    return null;
                  }),
              const HeightBox(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        signUpController.checkValue.value =
                            !signUpController.checkValue.value;
                      },
                      child: Row(
                        children: [
                          signUpController.checkValue.value
                              ? Image.asset(
                                  "assets/authFlow/check.png",
                                  scale: 2.7,
                                )
                              : Image.asset(
                                  "assets/authFlow/unCheck.png",
                                  scale: 2.7,
                                ),
                          const WidthBox(10),
                          const InterText(
                            text:
                                "I agree to the Terms of Service & Privacy Policy",
                            fontSize: 13,
                            color: AppColors.lightGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              CommonButton(
                text: "Sign Up",
                onTap: () {
                  if (signUpKey.currentState!.validate()) {
                    if (signUpController.checkValue.value == true) {
                      signUpController.signUpApiCall(context);
                    } else {
                      showLongToast("Please selected terms and condition");
                    }
                  }
                },
              ),
              HeightBox(
                Resp.size(40),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDivider(),
                  InterText(
                    text: "Or Continue With",
                    fontSize: 13,
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomDivider(),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      color: AppColors.lightBlack,
                      onTap: () {
                        toPushNavigator(
                            context: context,
                            pageName: const DemoGraphicsScreen());
                      },
                      child: Image.asset(
                        "assets/authFlow/facebook.png",
                        scale: 2.7,
                      ),
                    ),
                  ),
                  const WidthBox(15),
                  Expanded(
                    child: CommonButton(
                      color: AppColors.lightBlack,
                      onTap: () {
                        toPushNavigator(
                            context: context,
                            pageName: const DemoGraphicsScreen());
                      },
                      child: Image.asset(
                        "assets/authFlow/twitter.png",
                        scale: 2.7,
                      ),
                    ),
                  ),
                ],
              ),
              const HeightBox(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const InterText(
                    text: "Don’t have an Account?",
                    color: AppColors.lightGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      offNavigator(
                          context: context, pageName: const SignInScreen());
                    },
                    child: const InterText(
                      text: " Sign In",
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const HeightBox(25),
            ],
          ),
        ),
      ),
    );
  }
}
