import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchControllers extends GetxController{
  RxBool isSearch=false.obs;

  void setSearchMode(bool isSearch){
    this.isSearch.value=isSearch;
    update();
  }
}