import 'package:flutter/material.dart';

/// Get To
toPushNavigator({context, pageName,onBack}){
  // Navigator.push(context, MaterialPageRoute(builder: (context) => pageName));
  Navigator.push(context, MaterialPageRoute(builder: (context) => pageName)).then((value) => onBack!=null?onBack(value):null);
}

/// Get offAll
offAllNavigator({context, pageName}){
  Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => pageName), (Route<dynamic> route) => false,
  );
}

/// onBack
onBack(context){
  Navigator.of(context).pop();
}