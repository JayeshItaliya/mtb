import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationPasswordController extends GetxController{
  RxBool checkValue=false.obs;

  final emailController=TextEditingController().obs;
  final passwordController=TextEditingController().obs;

}