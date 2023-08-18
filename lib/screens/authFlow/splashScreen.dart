import 'package:flutter/material.dart';
import 'package:mtb/screens/authFlow/signUpScreen.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import 'signInScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToScreen();
  }

  @override
  Widget build(BuildContext context) {
    Resp.init(context);
    return Scaffold(
      backgroundColor:Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: SizedBox(
          height: Resp.size(236),
          width: Resp.size(98),
          child: Padding(
            padding: EdgeInsets.only(left: Resp.size(70),right: Resp.size(70)),
            child: Center(
              child: Image.asset(
                  'assets/common/logo.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
  navigateToScreen() async {
    await Future.delayed(const Duration(seconds: 2), (){
          offNavigator(context: context,PageName: const SignInScreen());
    });
  }
}


