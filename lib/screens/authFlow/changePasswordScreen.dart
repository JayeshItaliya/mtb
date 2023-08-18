import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/changePasswordController.dart';
import 'package:mtb/screens/authFlow/signInScreen.dart';
import 'package:mtb/screens/authFlow/verificationScreen.dart';
import 'package:mtb/utils/textFormFields.dart';
import '../../utils/appColors.dart';
import '../../utils/commonButton.dart';
import '../../utils/interText.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final changeController = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: Resp.size(12)),
        children: [
          customAppBar(title: 'Change Password',isSuffix: false,context: context),
          Image.asset(
            'assets/authFlow/changePassword.png',
            scale: 2.5,
            height: Resp.size(250),
          ),
          const HeightBox(21),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Resp.size(10)),
            child: InterText(
              text: 'Set new password for your account to login and access all the features.',
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
              textEditingController: changeController.newPasswordController.value,
              isPassword: true
          ),
          const HeightBox(20),
          AppWidget.getTextField(
              hintText: "Confirm Password",
              inputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              textEditingController: changeController.confirmPasswordController.value,
              isPassword: true),
          CommonButton(
            text: "Submit",
            onTap: () {
              toPushNavigator(
                  context: context, PageName: const SignInScreen());
            },
          ),
        ],
      ),
    );  }
}
