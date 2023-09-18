import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profileModel/getProfileModel.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/utils.dart';

class GetProfileDataController extends GetxController {
  UserProfileModel userProfileModel = UserProfileModel();
  RxBool isLoading = false.obs;
  final fullNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final locationController = TextEditingController().obs;

  getUserProfileApiCall(BuildContext context) async {
    isLoading.value = true;
    // loadingDialog(context);
    try {
      dynamic response = await apiServices.getResponse(
          context: context, url: ApiConfig.getUserData);

      if (response != null) {
        UserProfileModel data = UserProfileModel.fromJson(response);
        userProfileModel = data;
        customPrint("userData==>$userProfileModel");

        fullNameController.value.text = userProfileModel.name ?? "";
        emailController.value.text = userProfileModel.email ?? "";
        locationController.value.text =
            '${userProfileModel.city ?? ""} ${userProfileModel.state ?? ""}';
        isLoading.value = false;
        update();
      }
      // showSuccessDialog(context,'');
    } on Exception catch (e) {
      isLoading.value = false;
      // showErrorDialog(context,'');
      customPrint(e.toString());
    }
  }

  postUserProfile(BuildContext context, String? imagePath,bool isImage) async {
    var data = {
      'name': fullNameController.value.text,
      'email': emailController.value.text,
      // 'city': locationController.value.text
    };
    loadingDialog(context);
    customPrint('hi image path $imagePath');
    customPrint('hi image path $imagePath');
    try {
      dynamic response = await apiServices.postResponse(
          context: context,
          url: ApiConfig.editProfile,
          body: data,
          isImage: isImage,
          imagePath: imagePath.toString());
      if (response["success"]) {
        showSuccessDialog(context, response["message"]);
      } else if (!response["success"]) {
        showErrorDialog(context, response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}
