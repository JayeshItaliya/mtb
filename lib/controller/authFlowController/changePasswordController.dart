import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController{
  RxBool checkValue=false.obs;

  final oldPasswordController=TextEditingController().obs;
  final newPasswordController=TextEditingController().obs;
  final confirmPasswordController=TextEditingController().obs;
}