import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/api_config.dart';
import '../../utils/utils.dart';

class ChooseTopicController extends GetxController{


  followTopic(BuildContext context,String topicName,String action)async{
    var data={
      'topic_name': topicName,
      'action': action
    };
    try {
      dynamic response=await apiServices.postResponse(context: context,url: ApiConfig.followTopic,body: data);
      if(response["success"]==true){
        customPrint(response["message"]);
      }
      else if(response["success"]==false){
        customPrint(response["message"]);
      }
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }
}