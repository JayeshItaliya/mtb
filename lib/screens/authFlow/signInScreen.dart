import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/signInController.dart';
import 'package:mtb/screens/authFlow/demographicsScreen.dart';
import 'package:mtb/screens/authFlow/signUpScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/textFormFields.dart';

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
  final signInController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body: Container(
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
          padding: EdgeInsets.symmetric(horizontal: Resp.size(4)),
          children: [
            // HeightBox(88),
            SizedBox(
              height: Resp.size(88),
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
            // HeightBox(110),
            SizedBox(
              height: Resp.size(110),
            ),
            AppWidget.getTextField(
              hintText: "Email",
              inputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              textEditingController: signInController.emailController.value,
            ),
            AppWidget.getTextField(
                hintText: "Password",
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                textEditingController: signInController.emailController.value,
                isPassword: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      signInController.checkValue.value =
                          !signInController.checkValue.value;
                    },
                    child: Row(
                      children: [
                        signInController.checkValue.value
                            ? Image.asset(
                                "assets/authFlow/check.png",
                                scale: 2.7,
                              )
                            : Image.asset(
                                "assets/authFlow/unCheck.png",
                                scale: 2.7,
                              ),
                        WidthBox(Resp.size(10)),
                        InterText(
                          text: "Remember me",
                          fontSize: Resp.size(13),
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    toPushNavigator(context: context,PageName:const ForgotPassword());
                  },
                  child: InterText(
                    text: "Forgot Password?",
                    fontSize: Resp.size(13),
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            CommonButton(
              text: "Sign In",
              onTap: () {
                toPushNavigator(
                    context: context, PageName: const DemoGraphicsScreen());
              },
            ),
            HeightBox(
              Resp.size(40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomDivider(),
                InterText(
                  text: "Or Continue With",
                  fontSize: Resp.size(13),
                  color: AppColors.lightGrey,
                  fontWeight: FontWeight.w400,
                ),
                const CustomDivider(),
              ],
            ),
            HeightBox(
              Resp.size(20),
            ),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: AppColors.lightBlack,
                    onTap: () {
                      toPushNavigator(
                          context: context,
                          PageName: const DemoGraphicsScreen());
                    },
                    child: Image.asset(
                      "assets/authFlow/facebook.png",
                      scale: 2.7,
                    ),
                  ),
                ),
                WidthBox(Resp.size(15)),
                Expanded(
                  child: CommonButton(
                    color: AppColors.lightBlack,
                    onTap: () {
                      toPushNavigator(
                          context: context,
                          PageName: const DemoGraphicsScreen());
                    },
                    child: Image.asset(
                      "assets/authFlow/twitter.png",
                      scale: 2.7,
                    ),
                  ),
                ),
              ],
            ),
            HeightBox(
              Resp.size(40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InterText(
                   text:"Don’t have an Account?",
                  color: AppColors.lightGrey,
                  fontSize: Resp.size(14),
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: (){
                    offNavigator(context: context,PageName:const SignUpScreen());
                  },
                  child: InterText(
                      text:" Sign up",
                    color: AppColors.primaryColor,
                    fontSize: Resp.size(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            HeightBox(
              Resp.size(25),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    Get.delete<SignInController>();
  }
}
