import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../model/followingModel/followModel.dart';
import '../../model/trendingModel/ForYouModel.dart';
import '../../screens/authFlow/demographicsScreen.dart';
import '../../services/api_call.dart';
import '../../services/api_config.dart';
import '../../utils/circularLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/utils.dart';

class FollowingController extends GetxController{
  RxBool upValue=false.obs;
  RxBool downValue=false.obs;
  List<FollowModel> followList=List<FollowModel>.empty(growable: true).obs;
  var forYouData=ForYouModel().obs;

  getFollowDataAPI(BuildContext context){

    TaskProvider().getFollowData(context).then((value) {
      customPrint(value);
      if(value!=null){
        followList.clear();
        followList.addAll(value);
        customPrint(followList);
        update();
      }
      else{
        customPrint('Data not found');
      }
    });
  }

  Future<ForYouModel?> getForYouData(BuildContext context,)async{

    try {
      dynamic response= await apiServices.getResponse(context:context,url: ApiConfig.forYou);
      customPrint("non forYou jsonResponse==>>$response");

      ForYouModel? data=ForYouModel.fromJson(response);
      customPrint("updatedResponse=>>$data");
      return data;
    } on Exception catch (e) {
      customPrint(e.toString());
    }

    return null;
  }
}