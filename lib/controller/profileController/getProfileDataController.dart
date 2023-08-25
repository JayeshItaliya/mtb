import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profileModel/getProfileModel.dart';
import '../../services/api_config.dart';
import '../../utils/utils.dart';

class GetProfileDataController extends GetxController{

  UserProfileModel userProfileModel=UserProfileModel();
  RxBool isLoading=false.obs;


    getUserProfileApiCall(BuildContext context)async{
    isLoading.value=true;
    try {
      dynamic response= await apiServices.getResponse(context:context,url: ApiConfig.getUserData);
        UserProfileModel  data=UserProfileModel.fromJson(response);
        userProfileModel=data;
        print("userData==>$userProfileModel");
        isLoading.value=false;
        update();
    } on Exception catch (e) {
      isLoading.value=false;
      customPrint(e.toString());
    }
  }
}