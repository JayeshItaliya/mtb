import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/demographicsScreen.dart';
import 'package:mtb/screens/authFlow/signUpScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/textFormFields.dart';

import '../../controller/authFlowController/signInController.dart';
import '../../utils/customDivider.dart';
import '../../utils/interText.dart';
import '../../utils/utils.dart';
import 'forgotPasswordScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final signInKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      init:Get.put(SignInController()) ,
      builder: (controller) {
        return Scaffold(
          backgroundColor:Colors.black,
          body: Form(
            key: signInKey,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/authFlow/signInBackground.png',
                    ),
                    fit: BoxFit.fill,
                  )),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: Resp.size(12)),
                children: [
                  const HeightBox(75),
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
                  // HeightBox(110),
                  const HeightBox(100,),
                  AppWidget.getTextField(
                    hintText: "Email",
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    textEditingController: controller.emailController.value,
                    validationFunction: (val){
                      if(val.toString().isEmpty){
                        return "Please Enter Email";
                      }
                      return null;
                    }
                  ),
                  const HeightBox(20),
                  AppWidget.getTextField(
                      hintText: "Password",
                      inputAction: TextInputAction.done,
                      textEditingController: controller.passwordController.value,
                      isPassword: true,
                      validationFunction: (val){
                        if(val.toString().isEmpty){
                          return "Please Enter Password";
                        }
                        return null;
                      }
                  ),
                  const HeightBox(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.checkValue.value =
                                !controller.checkValue.value;
                          },
                          child: Row(
                            children: [
                              controller.checkValue.value
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
                                text: "Remember me",
                                fontSize:13,
                                color: AppColors.lightGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          toPushNavigator(context: context,pageName:const ForgotPassword());
                        },
                        child: const InterText(
                          text: "Forgot Password?",
                          fontSize:13,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  CommonButton(
                    text: "Sign In",
                    onTap: () {
                      if(signInKey.currentState!.validate()){
                        controller.signInApiCall(context);
                      }
                    },
                  ),
                  const HeightBox(40),
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
                         text:"Don’t have an Account?",
                        color: AppColors.lightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        onTap: (){
                          offNavigator(context: context,pageName:const SignUpScreen());
                        },
                        child: const InterText(
                            text:" Sign up",
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
    );
  }
  @override
  void dispose() {
    super.dispose();
    Get.delete<SignInController>();
  }
}
