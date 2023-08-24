import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/forgotController.dart';
import 'package:mtb/screens/authFlow/verificationScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/textFormFields.dart';

import '../../utils/commonButton.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgetKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotController>(
      init:Get.put(ForgotController()),
        builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Form(
            key: forgetKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: Resp.size(12)),
              physics: const ClampingScrollPhysics(),
              children: [
                customAppBar(title: 'Forgot Password',isSuffix: false,context: context),
                const HeightBox(18),
                Image.asset(
                  'assets/authFlow/forgotPassword.png',
                  scale: 2.5,
                  height: Resp.size(250),
                ),
                const HeightBox(20),
                AppWidget.getTextField(
                    hintText: "Enter Email Address",
                    inputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    textEditingController: controller.emailController.value,
                    validationFunction: (val){
                      if(val.toString().isEmpty){
                        return "Please Enter Register Email";
                      }
                      return null;
                    }
                ),
                const HeightBox(12),
                Padding(
                  padding: EdgeInsets.only(right: Resp.size(20)),
                  child: InterText(
                      text: 'Please enter your email so we can send you a Verification Code',
                      textOverflow: TextOverflow.clip,
                      color: AppColors.lightGrey,
                      fontSize: Resp.size(12),
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                  ),
                ),
                CommonButton(
                  text: "Send",
                  onTap: () {
                     if(forgetKey.currentState!.validate()){
                       controller.forgotPasswordApiCall(context);
                     }
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
