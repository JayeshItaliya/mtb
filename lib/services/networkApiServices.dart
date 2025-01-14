import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/strings.dart';
import '../utils/utils.dart';

class NetWorkApiServices{
  /// get Response
  Future getResponse({String? url, context}) async {
    dynamic userLoginToken = cx.read(Keys.token);

    var headers = {'Authorization': 'Bearer ${userLoginToken.toString()}'};
    customPrint("Header=>${headers.toString()}");
    customPrint("URL=>$url");
    dynamic responseJson;
    try {
      if (userLoginToken != null) {
        var request = http.Request('GET', Uri.parse(url ?? ""));
        request.headers.addAll(headers);
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        customPrint("response ---- ${response.toString()}");

        responseJson = returnResponse(response, context);

        customPrint("----- Api Called Successfully -----");
        customPrint("response json ---- $responseJson");
      } else {
        showLongToast("Token is Null");
      }
    } on SocketException {
      showLongToast( "No Internet Connection");
    } on TimeoutException {
      showLongToast( "Connection Time Out");
    } on Error catch (e) {
      customPrint(e.stackTrace.toString());
      customPrint( "Oops Exception Occurred");
    }
    return responseJson;
  }

  Future postResponse({String? url, dynamic body, context,bool isImage=false,String imagePath=''}) async {
    dynamic responseJson;
    dynamic userLoginToken = cx.read(Keys.token);

    customPrint("post apiUrl==>>$url");
    customPrint("post postData==>>${body.toString()}");
    customPrint("post header==>>${userLoginToken.toString()}");
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url ?? ""),);
      request.headers.addAll({'Authorization': 'Bearer ${userLoginToken.toString()}'});
      if(isImage){
        request.files
            .add(await http.MultipartFile.fromPath('image', imagePath));
        customPrint("request.files");
        customPrint(request.files);
      }
      if(body!=null){
        request.fields.addAll(body);
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      responseJson = returnResponse(response, context);
      customPrint(responseJson.toString());
    } on SocketException {
      showLongToast("No Internet Connection");
    } on TimeoutException {
      showLongToast("Connection Time Out");
    } on Error catch (e) {
      customPrint(e.stackTrace.toString());
      showLongToast( "Something Went Wrong");
    }
    return responseJson;
  }

  Future deleteResponse({String? url,  context}) async {
    dynamic responseJson;
    dynamic userLoginToken = cx.read(Keys.token);
    customPrint("post apiUrl==>>$url");
    customPrint("post header==>>${userLoginToken.toString()}");
    try {
      var request = http.MultipartRequest(
        'DELETE',
        Uri.parse(url ?? ""),
      );
      request.headers.addAll({'Authorization': 'Bearer ${userLoginToken.toString()}'});
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      responseJson = returnResponse(response, context);
      customPrint(responseJson.toString());
    } on SocketException {
      showLongToast( "No Internet Connection");
    } on TimeoutException {
      showLongToast( "Connection Time Out");
    } on Error catch (e) {
      customPrint(e.stackTrace.toString());
      showLongToast( "Something Went Wrong");
    }
    return responseJson;
  }

  /// Api Response
  dynamic returnResponse(http.Response response, context) {
    customPrint("statusCode=>>${response.statusCode}");
    customPrint("statusCode=>>${response.body}");
    // showErrorDialog(context, '');
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        throw showLongToast("Unauthorised error!");
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 500:
        throw showLongToast("Server Error");
      default:
        showLongToast("Error occurred while communication with server with status Ced${response.statusCode}");
    }
  }
}
