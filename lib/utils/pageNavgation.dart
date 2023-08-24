import 'package:flutter/material.dart';

/// Get To
toPushNavigator({context, pageName}){
  Navigator.push(context, MaterialPageRoute(builder: (context) => pageName));
}

/// Get offAll
offNavigator({context, pageName}){
  Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => pageName), (Route<dynamic> route) => false,
  );
}

/// onBack
onBack(context){
  Navigator.of(context).pop();
}