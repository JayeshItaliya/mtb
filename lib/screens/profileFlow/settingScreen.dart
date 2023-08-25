import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/profileController/deleteAccountController.dart';
import 'package:mtb/controller/profileController/logOutController.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/utils.dart';
import '../../utils/appColors.dart';
import '../../utils/commonButton.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../profileFlow/changePasswordScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final deleteController=Get.put(DeleteAccountController());
  final logOutController=Get.put(LogOutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.only(left:Resp.size(12),right:Resp.size(12),top:Resp.size(35),),
        children: [
          customAppBar(title: 'Settings', context: context,isSuffix: false,
          fontSize: 18,
          fontWeight: FontWeight.w600),
          const HeightBox(38),
          btn('Change Password',(){
            toPushNavigator(
                context: context, pageName: const ChangePasswordScreen());
          }),
          const HeightBox(12),
          btn('Delete Account',(){dialog(false);}),
          const HeightBox(12),
          btn('Log Out',(){
            dialog(true);
          }),


        ],
      ),
    );
  }

  Widget btn(String label,Function onTap) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: (){
        onTap();
      },
      child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBlack,
              borderRadius: BorderRadius.circular(Resp.size(12)),
            ),
            padding: EdgeInsets.symmetric(horizontal:Resp.size(15),vertical:Resp.size(18), ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InterText(text: label,
                fontSize: 14,
                fontWeight: FontWeight.w500),
                SvgPicture.asset(
                  'assets/profileFlow/arrow_right.svg',
                  width: Resp.size(20),
                  height: Resp.size(20),
                )
              ],
            ),
          ),
    );
  }

  void dialog(bool logout){
    showDialog(context: context, builder: (context) => Material(
      color: Colors.transparent,
      child: Center(
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0XFFD0D0D0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(Resp.size(12)),
              ),
              padding: EdgeInsets.all(Resp.size(30)),
              margin: EdgeInsets.all(Resp.size(20)),
              child: Column(
                children: [
                  InterText(text: logout?'Log Out':'Delete Account',fontSize: 18,
                  fontWeight: FontWeight.w500),
                  const HeightBox(15),
                  InterText(text: 'Are You Sure You Want To ${logout?'Logout':'Delete'} This\nAccount?',fontSize: 14,
                      fontWeight: FontWeight.w400,color: AppColors.white,maxLines: 2,textAlign: TextAlign.center,),
                  CommonButton(
                    height: Resp.size(54),
                    text: logout?'Log Out':'Delete Account',
                      fontSize: 18,
                    onTap: () {
                      if(logout==true){
                        logOutController.logOutApiCall(context);
                      }
                      else if(logout==false){
                        deleteController.deleteAccountApiCall(context);
                      }
                    },
                  ),
                  const HeightBox(30),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const InterText(text: 'No thanks!',fontSize: 16,
                        fontWeight: FontWeight.w600,color: AppColors.white,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
