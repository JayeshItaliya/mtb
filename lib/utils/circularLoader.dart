import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/utils.dart';

loadingDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => WillPopScope(
    onWillPop: ()=>Future(() => false),
    child: Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),),
  ),);
}

showSuccessDialog(BuildContext context,String message, {bool showMessage = true}) {
  Get.back();
  if(showMessage){
    showLongToast(message);
  }
}

showErrorDialog(BuildContext context,String error) {
  Get.back();
  showLongToast(error);
}