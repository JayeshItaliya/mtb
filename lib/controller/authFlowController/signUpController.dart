import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  RxBool checkValue=false.obs;

  final fullNameController=TextEditingController().obs;
  final emailController=TextEditingController().obs;
  final passwordController=TextEditingController().obs;
  final confirmPasswordController=TextEditingController().obs;

}