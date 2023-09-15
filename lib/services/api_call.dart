import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/followingModel/followModel.dart';
import '../model/homeFlowModel/billListModel.dart';
import '../utils/utils.dart';
import 'api_config.dart';

class TaskProvider extends GetConnect {
  Future<List<BillListModel>?> getBillData(BuildContext context) async {
    try {
      dynamic response = await apiServices.getResponse(
          context: context, url: ApiConfig.billdata);
      customPrint("jsonResponse==>>$response");

      if(response["success"]){
        List<BillListModel>? data = BillListModel.getListFromJson(response["data"]);
        customPrint("updatedResponse=>>$data");
        return data;
      }
      else{
        return [];
      }
    } on Exception catch (e) {
      customPrint(e.toString());
    }
    return null;
  }

  Future<List<BillListModel>?> getFilteredData(
      BuildContext context, String params) async {
    try {
      dynamic response = await apiServices.getResponse(
          context: context, url: ApiConfig.filterData + (params.substring(1)));
      customPrint("filtered jsonResponse==>>$response");
      if(response["success"]){
        List<BillListModel>? data = BillListModel.getListFromJson(response["data"]);
        customPrint("updatedResponse=>>$data");
        return data;
      }
      else{
        return [];
      }

    } on Exception catch (e) {
      customPrint(e.toString());
    }
    return null;
  }

  followAPI(String id,String action, BuildContext context) async {
    var data = {
      'bill_id': id,
      'action': action
    };
    try {
      await apiServices.postResponse(
          context: context, url: ApiConfig.follow, body: data);
    } on Exception catch (e) {
      customPrint("Error=>>${e.toString()}");
    }
  }

  Future<List<FollowModel>?> getFollowData(BuildContext context) async {
    try {
      Map<String,dynamic> response = await apiServices.getResponse(
          context: context, url: ApiConfig.follow);
      customPrint("getFollowData jsonResponse==>>$response");

      if (response['success']){
        List<FollowModel>? data = FollowModel.getListFromJson(response['data']);
        customPrint("getFollowData=>>$data");
        return data;
      }
      else{
        customPrint("No follow fills found");
      }

    } on Exception catch (e) {
      customPrint(e.toString());
    }
    return null;
  }

  Future<List<BillListModel>?> getSearchedBillData(BuildContext context,String keyword)async{
    try {
      Map<String,dynamic> response= await apiServices.getResponse(context:context,url: ApiConfig.search+keyword);
      customPrint("non filtered jsonResponse==>>$response");
      if (response['success']){
        List<BillListModel>? data=BillListModel.getListFromJson(response['data']);
        customPrint("getSearchedBillData=>>$data");
        return data;
      }
      else{
        showLongToast('Data Not Found');
      }
    } on Exception catch (e) {
      customPrint(e.toString());
    }
    return null;
  }
}
