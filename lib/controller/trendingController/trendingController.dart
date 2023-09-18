import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/model/trendingModel/ForYouModel.dart';
import 'package:mtb/model/trendingModel/ForYouModel.dart';

import '../../model/trendingModel/TopIssuesModel.dart';
import '../../model/trendingModel/topTrendingBillsModel.dart';
import '../../services/api_config.dart';
import '../../utils/utils.dart';

class TrendingController extends GetxController {
  var index = 0.obs;
  var billData=TopTrendingBillsModel().obs;
  var forYouData=ForYouModel().obs;
  var topIssuesData=TopIssuesModel().obs;
  RxBool isTrendingLoading=false.obs;
  RxBool isForYouLoading=false.obs;
  RxBool isTopIssueLoading=false.obs;
  /*getSearchedBillDataAPI(BuildContext context,String keyword){

    getSearchedBillData(context,keyword).then((value) {
      customPrint(value);
      if(value!=null){
        billDataList.value=[];
        billDataList.value.addAll(value);
        customPrint(billDataList.value);

        update();
      }
      else{

        customPrint('Data not found');
      }
    });
  }*/

  Future<TopTrendingBillsModel?> getTrendingBillData(BuildContext context)async{
    isTrendingLoading(true);
    try {
      dynamic response= await apiServices.getResponse(context:context,url: ApiConfig.newestBills);
      customPrint("non TrendingBill jsonResponse==>>$response");

      TopTrendingBillsModel? data=TopTrendingBillsModel.fromJson(response);
      customPrint("updatedResponse=>>$data");
      isTrendingLoading(false);
      return data;
    } on Exception catch (e) {
      isTrendingLoading(false);
      customPrint(e.toString());
    }
    isTrendingLoading(false);
    return null;
  }

  Future<ForYouModel?> getForYouData(BuildContext context,)async{
    isForYouLoading(true);
    try {
      dynamic response= await apiServices.getResponse(context:context,url: ApiConfig.forYou);
      customPrint("non forYou jsonResponse==>>$response");

      ForYouModel? data=ForYouModel.fromJson(response);
      customPrint("updatedResponse=>>$data");
      isForYouLoading(false);
      return data;
    } on Exception catch (e) {
      isForYouLoading(false);
      customPrint(e.toString());
    }
    isForYouLoading(false);
    return null;
  }

  Future<TopIssuesModel?> getTopIssuesData(BuildContext context)async{
    isTopIssueLoading(true);
    try {
      dynamic response= await apiServices.getResponse(context:context,url: ApiConfig.topIssues);
      customPrint("non topIssues jsonResponse==>>$response");

      TopIssuesModel? data=TopIssuesModel.fromJson(response);
      customPrint("updatedResponse=>>$data");
      isTopIssueLoading(false);
      return data;
    } on Exception catch (e) {
      isTopIssueLoading(false);
      customPrint(e.toString());
    }
    isTopIssueLoading(false);
    return null;
  }
}