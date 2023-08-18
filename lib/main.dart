import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/splashScreen.dart';
import 'package:mtb/screens/following/filterBillsScreen.dart';

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
      home: SplashScreen(),
    );
  }
}
