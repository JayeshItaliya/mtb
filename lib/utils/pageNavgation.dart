import 'package:flutter/material.dart';

/// Get To
toPushNavigator({context, PageName}){
  Navigator.push(context, MaterialPageRoute(builder: (context) => PageName));
}

/// Get offAll
offNavigator({context, PageName}){
  Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => PageName), (Route<dynamic> route) => false,
  );
}

/// onBack
onBack(context){
  Navigator.of(context).pop();
}