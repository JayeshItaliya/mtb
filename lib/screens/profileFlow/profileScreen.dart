import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtb/screens/profileFlow/editProfileScreen.dart';
import 'package:mtb/screens/profileFlow/settingScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/utils.dart';

import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../authFlow/demographicsScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Resp.size(12)),
          child: Column(
            children: [
              const HeightBox(15),
              customAppBar(
                  title: 'Profile',
                  context: context,
                  isSuffix: false,
                  isPrefix: false,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              const HeightBox(20),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightBlack,
                  borderRadius: BorderRadius.circular(Resp.size(12)),
                ),
                padding: EdgeInsets.all(Resp.size(20)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:()=>toPushNavigator(
                          context: context, pageName: const EditProfileScreen()),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/common/avatar.png',
                              width: Resp.size(90),
                              height: Resp.size(90),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              'assets/common/edit.svg',
                              width: Resp.size(25),
                              height: Resp.size(25),
                            ),
                          )
                        ],
                      ),
                    ),
                    const HeightBox(12),
                    const InterText(
                      text: 'Kristin Watson',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    const HeightBox(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/profileFlow/location.svg',
                          width: Resp.size(15),
                          height: Resp.size(15),
                        ),
                        Text(
                          ' Washington DC',
                          style: GoogleFonts.poppins(
                            fontSize: Resp.size(13),
                            fontWeight: FontWeight.w400,
                            color: AppColors.white
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const HeightBox(12),
              option('Demographics', 'demographics',(){
                toPushNavigator(
                    context: context, pageName: const DemoGraphicsScreen(isFromProfile: true,));
              }),
              const HeightBox(12),
              option('Notifications', 'notifications',(){

              }),
              const HeightBox(12),
              option('Following', 'following',(){

              }),
              const HeightBox(12),
              option('Settings ', 'settings',(){
                toPushNavigator(
                    context: context, pageName: const SettingScreen());
              }),

              // HeightBox(Resp.size(100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget option(String title, String img,Function onTap) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: (){
        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.lightBlack,
          borderRadius: BorderRadius.circular(Resp.size(12)),
        ),
        padding: EdgeInsets.all(Resp.size(12)),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/profileFlow/$img.svg',
              width: Resp.size(45),
              height: Resp.size(45),
            ),
            InterText(
              text: '    $title',
              fontSize: Resp.size(14),
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
