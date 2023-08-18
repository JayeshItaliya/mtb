import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/searchFilter/filterScreen.dart';
import 'package:mtb/screens/searchFilter/searchScreen.dart';

import 'mainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mind The Bill',
      home: FilterScreen(),
    );
  }
}
