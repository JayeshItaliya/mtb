import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/changePasswordController.dart';
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
          const HeightBox(40),
          customAppBar(title: 'Change Password',isSuffix: false,context: context),

          const HeightBox(38),
          AppWidget.getTextField(
            hintText: "Enter Old Password",
            inputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            textEditingController: changeController.oldPasswordController.value,
          ),
          HeightBox(20),
          AppWidget.getTextField(
              hintText: "Enter New Password",
              inputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              textEditingController: changeController.newPasswordController.value,
              isPassword: true
          ),
          HeightBox(20),
          AppWidget.getTextField(
              hintText: "Confirm Password",
              inputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              textEditingController: changeController.confirmPasswordController.value,
              isPassword: true),
          const HeightBox(250),
          CommonButton(
            height: Resp.size(54),
            text: "Change Password",
            onTap: () {
              // toPushNavigator(
              //     context: context, PageName: const VerificationScreen());
            },
          ),
        ],
      ),
    );  }
}
