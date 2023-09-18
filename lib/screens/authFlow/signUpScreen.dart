import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/signInScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/textFormFields.dart';
import 'package:twitter_login/twitter_login.dart';

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
  Map userObj = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: GlowingOverscrollIndicator(
              showLeading: false,
              showTrailing: false,
              axisDirection: AxisDirection.down,
              color: Colors.transparent,
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: defaultScreenPadding(),
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
                      keyboardType: TextInputType.text,
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                      ],
                      textEditingController:
                          signUpController.fullNameController.value,
                      maxLength: 30,
                      validationFunction: (val) {
                        if (val.toString().isEmpty) {
                          return "Please Enter Full Name";
                        } else if (val.toString().length < 8) {
                          return "Full Name Length Must Be 8 Or Greater";
                        }
                        return null;
                      }
                      ),
                  const HeightBox(20),
                  AppWidget.getTextField(
                      hintText: "Email",
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      textEditingController:
                          signUpController.emailController.value,
                      validationFunction: (val) {
                        if (val.toString().isEmpty) {
                          return "Please Enter Email";
                        } else if (!isValid(val.toString())) {
                          return "Please Enter Valid Email";
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
                          return "Please Enter Password";
                        } else if (val.toString().length < 8) {
                          return "Password Length Must Be 8 Or Greater";
                        }
                        return null;
                      }),
                  const HeightBox(20),
                  AppWidget.getTextField(
                      hintText: "Confirm Password",
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textEditingController:
                          signUpController.confirmPasswordController.value,
                      isPassword: true,
                      validationFunction: (val) {
                        if (val.toString().isEmpty) {
                          return "Please Enter Confirm Password";
                        } else if (val.toString().length < 8) {
                          return "Password Length Must Be 8 Or Greater";
                        }
                        else if (signUpController
                            .passwordController.value.text
                            .toString() !=
                            signUpController
                                .confirmPasswordController.value.text
                                .toString()){
                          return "Password Doesn't Match";
                        }
                        return null;
                      }),
                  const HeightBox(15),
                  SizedBox(
                    width: cx.width - Resp.size(26),
                    child: Obx(
                      () => GestureDetector(
                        onTap: () {
                          signUpController.checkValue.value =
                              !signUpController.checkValue.value;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 0,
                              child: signUpController.checkValue.value
                                  ? Image.asset(
                                      "assets/authFlow/check.png",
                                      scale: 2.7,
                                    )
                                  : Image.asset(
                                      "assets/authFlow/unCheck.png",
                                      scale: 2.7,
                                    ),
                            ),
                            const Expanded(flex: 0, child: WidthBox(10)),
                            const Expanded(
                              flex: 1,
                              child: InterText(
                                text:
                                    "I agree to the Terms of Service & Privacy Policy",
                                fontSize: 13,
                                color: AppColors.lightGrey,
                                fontWeight: FontWeight.w400,
                                maxLines: 2,
                                textOverflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CommonButton(
                    text: "Sign Up",
                    onTap: () {
                      if (signUpKey.currentState!.validate()) {
                        if (!signUpController.checkValue.value) {
                          showLongToast("Please select Terms of Service & Privacy Policy");
                        } else if (signUpController
                                .passwordController.value.text
                                .toString() !=
                            signUpController
                                .confirmPasswordController.value.text
                                .toString()) {
                          showLongToast(
                              "Password and Confirm Password Doesn't Match");
                        } else {
                          signUpController.signUpApiCall(context);
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
                            // FacebookAuth.instance.login(permissions: [
                            //   "public_profile",
                            //   "email"
                            // ]).then((value) {
                            //   FacebookAuth.instance
                            //       .getUserData()
                            //       .then((userData) async {
                            //     setState(() {
                            //       userObj = userData;
                            //       print(userObj);
                            //     });
                            // TaskProvider.facebookSignInAPI(
                            //     image: _userObj['picture']['data']['url'],
                            //     name: _userObj['name'],
                            //     email: _userObj['email'],
                            //     uid: _userObj['id'],
                            //     context: context,
                            //     curIndex: widget.curIndex,
                            //     noOfPopTime: widget.noOfPopTime);
                            //   });
                            // });
                            // toPushNavigator(
                            //     context: context,
                            //     pageName: const DemoGraphicsScreen());
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
                          onTap: () async {
                            // final twitterLogin = TwitterLogin(
                            //     apiKey: "d45avplzLP7BDWRc7YOaRSBg7",
                            //     apiSecretKey:
                            //         "0v4sgr8iiI5VpgNPYOXGIto1fIBwZCujYhU1q0lrwNix3zmubN",
                            //     redirectURI: 'https://mind-the-bill.firebaseapp.com/__/auth/handler');
                            // final authResult = twitterLogin.login();
                            // customPrint(authResult.toString());
                            // switch (authResult.) {
                            //   case TwitterLoginStatus.loggedIn:
                            //   // success
                            //     break;
                            //   case TwitterLoginStatus.cancelledByUser:
                            //   // cancel
                            //     break;
                            //   case TwitterLoginStatus.error:
                            //   // error
                            //     break;
                            // }
                            // await twitterLogin.login().then((value) async {
                            //   final twitterAuthCredentials =
                            //       TwitterAuthProvider.credential(
                            //           accessToken:value.authToken.toString(),
                            //           secret:value.authTokenSecret.toString(),);
                            //   await FirebaseAuth.instance.signInWithCredential(twitterAuthCredentials);
                            // });

                            // toPushNavigator(
                            //     context: context,
                            //     pageName: const DemoGraphicsScreen());
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
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          offAllNavigator(
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SignUpController>();
  }
}
