import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtb/controller/trendingController/trendingController.dart';
import 'package:mtb/screens/following/followingScreen.dart';
import 'package:mtb/screens/homeFlow/homeScreen.dart';
import 'package:mtb/screens/profileFlow/profileScreen.dart';
import 'package:mtb/screens/searchFlow/searchScreen.dart';
import 'package:mtb/screens/trending/trendingScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'controller/followingController/followingController.dart';
import 'controller/homeController/homeController.dart';
import 'controller/profileController/getProfileDataController.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  List<PersistentBottomNavBarItem> navBarsItems=
  [

   PersistentBottomNavBarItem(
     contentPadding: 0,

     activeColorPrimary: AppColors.primaryColor,
     inactiveColorPrimary: AppColors.grey,
     inactiveIcon:Image.asset("assets/homeFlow/home.png",color: AppColors.grey) ,
     icon: Image.asset("assets/homeFlow/home.png",color: AppColors.primaryColor,height: 50,scale: 0.5,width: 50,),
     title: ("Home"),
   ),
    PersistentBottomNavBarItem(
      iconSize: Resp.size(30),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.grey,
     inactiveIcon:Image.asset("assets/homeFlow/search.png",color: AppColors.grey) ,
     icon: Image.asset("assets/homeFlow/search.png",color: AppColors.primaryColor),
     title: ("Search"),

   ),PersistentBottomNavBarItem(
    iconSize: Resp.size(30),
    activeColorPrimary: AppColors.primaryColor,
    inactiveColorPrimary: AppColors.grey,
     inactiveIcon:Image.asset("assets/homeFlow/followingBottomBar.png",color: AppColors.grey) ,
     icon: Image.asset("assets/homeFlow/followingBottomBar.png",color: AppColors.primaryColor),
     title: ("Following"),

   ),
    PersistentBottomNavBarItem(
      iconSize: Resp.size(30),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.grey,
      inactiveIcon:Image.asset("assets/homeFlow/trending.png",color: AppColors.grey,) ,
      icon: Image.asset("assets/homeFlow/trending.png",color: AppColors.primaryColor,),
      title: ("Trending"),

    ),
    PersistentBottomNavBarItem(
      iconSize: Resp.size(30),
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.grey,
      inactiveIcon:Image.asset("assets/homeFlow/profile.png",color: AppColors.grey),
      icon: Image.asset("assets/homeFlow/profile.png",color: AppColors.primaryColor,),
      title: ("Profile"),
      contentPadding: 0,

      // textStyle: GoogleFonts.inter(
      //   height: 5
      // )
    )
  ];

  List<Widget> widgetScreen = [
    const HomeScreen(),
    const SearchScreen(),
    const FollowingScreen(),
    const TrendingScreen(),
    const ProfileScreen(),
  ];
  HomeController homeController = Get.put(HomeController());
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cx.showBottomSheet.value=true;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomSheet: Obx(
              ()=> PersistentTabView(
            context,
            bottomScreenMargin: 0,
            margin: EdgeInsets.zero,
            padding: NavBarPadding.fromLTRB(Resp.size(05),Resp.size(04),Resp.size(15),Resp.size(15)),
            navBarHeight: Resp.size(70),
            controller: controller,
            screens: widgetScreen,
            neumorphicProperties: const NeumorphicProperties(
              bevel: 2,
              borderRadius: 0,
              curveType: CurveType.flat
            ),
            items: navBarsItems,
            resizeToAvoidBottomInset: true,
            onItemSelected: (value) async {
              if(value==0){
                await homeController.getBillDataAPI(context);
              }
              else if(value==1){
              }
              else if(value==2){
                FollowingController followController = Get.put(FollowingController());

                followController.getFollowDataAPI(context);
                followController.forYouData.value =
                (await followController.getForYouData(context))!;
              }
              else if(value==3){
                TrendingController trendingController = Get.put(TrendingController());

                trendingController.billData.value =
                  (await trendingController.getTrendingBillData(context))!;
                  trendingController.forYouData.value =
                  (await trendingController.getForYouData(context))!;
                  trendingController.topIssuesData.value =
                  (await trendingController.getTopIssuesData(context))!;

              }
              else if(value==4){
                GetProfileDataController getProfileDataController = Get.put(GetProfileDataController());

                getProfileDataController.getUserProfileApiCall(context);
              }
            },
                popAllScreensOnTapAnyTabs: true,

            backgroundColor: AppColors.lightBlack,
            confineInSafeArea: false,
            stateManagement: true,
            navBarStyle: NavBarStyle.style3,
            hideNavigationBarWhenKeyboardShows: true,
            hideNavigationBar: !cx.showBottomSheet.value,
            handleAndroidBackButtonPress: true,
            // screenTransitionAnimation: const ScreenTransitionAnimation(
            //   animateTabTransition: true,
            //   curve: Curves.ease,
            //   duration: Duration(milliseconds: 100),
            // ),
            decoration: const NavBarDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),

            ),

          ),
        ),
      ),
    );
  }
}
