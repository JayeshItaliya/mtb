import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/forgotController.dart';
import 'package:mtb/utils/interText.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../controller/authFlowController/verificationController.dart';
import '../../utils/appColors.dart';
import '../../utils/commonButton.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';


class VerificationScreen extends StatefulWidget {
 final String emilAddress;
 const VerificationScreen({Key? key,required this.emilAddress}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String signature = "{{ app signature }}";
  final verificationController=Get.put(VerificationPasswordController());
  final forgotController=Get.put(ForgotController());


  //
  // @override
  // void dispose() {
  //   SmsAutoFill().unregisterListener();
  //   debugPrint("Unregistered Listener");
  //   super.dispose();
  // }
  //
  // void _listenOtp() async {
  //   await SmsAutoFill().listenForCode();
  //   debugPrint("OTP Listen is called");
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationPasswordController>(
      builder: (controller) {
        return SafeArea(
          bottom: true,
          top: true,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: ListView(
              padding: defaultScreenPadding(),
              children: [
                customAppBar(title: 'Verification',isSuffix: false,context: context),
                Image.asset(
                  'assets/authFlow/verification.png',
                  scale: 2.5,
                  height: Resp.size(250),
                ),
                const InterText(
                  text: 'Enter Verification Code',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
                HeightBox(Resp.size(25)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Resp.size(39)),
                  child: SizedBox(
                    height: Resp.size(52),
                    width: Resp.size(52),
                    child: PinFieldAutoFill(
                      // currentCode: authService.loginMobileOTP,
                      decoration: BoxLooseDecoration(
                        gapSpace: Resp.size(30),
                        radius: Radius.circular(Resp.size(10)),
                        strokeWidth: 1,
                        textStyle: TextStyle(
                            fontSize: Resp.size(18),
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        strokeColorBuilder: PinListenColorBuilder(
                            AppColors.lightGrey, Colors.transparent),
                        bgColorBuilder: const FixedColorBuilder(AppColors.lightBlack),
                      ),
                      cursor: Cursor(
                        color: Colors.white,
                        height: Resp.size(26),
                        width: Resp.size(1),
                        enabled: true,
                      ),
                      codeLength: 4,
                      currentCode: controller.verificationCode.value,
                      onCodeSubmitted: (code) {
                        debugPrint("On Code Submitted : $code");
                      },
                      keyboardType: TextInputType.number,
                      onCodeChanged: (code) {
                        controller.verificationCode.value=code.toString();
                        if (code!.length == 4) {
                          controller.verificationCode.value=code.toString();
                          FocusScope.of(context).requestFocus(FocusNode());
                        } else if (code.isEmpty) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
                  ),
                ),
                HeightBox(Resp.size(25)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InterText(
                      text: 'If you didn’t receive a code, ',
                      fontWeight: FontWeight.w400,
                      fontSize: Resp.size(14),
                      textAlign: TextAlign.center,
                      color: AppColors.lightGrey,
                    ),
                    InkWell(
                      onTap: (){
                        forgotController.forgotPasswordApiCall(context,shouldNavigate: false);
                      },
                      child: InterText(
                        text: 'Resend',
                        fontWeight: FontWeight.w500,
                        fontSize: Resp.size(14),
                        textAlign: TextAlign.center,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                CommonButton(
                  text: "Submit",
                  onTap: () {
                    controller.verificationCodeApiCall(context,widget.emilAddress);
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
  @override
  void dispose() {
    super.dispose();
    Get.delete<VerificationPasswordController>();
  }
}
