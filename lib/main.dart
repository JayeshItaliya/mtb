import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mtb/screens/authFlow/splashScreen.dart';
import 'package:mtb/utils/loader.dart';

final storage = GetStorage();
void main()async{
  await GetStorage.init();
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
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
