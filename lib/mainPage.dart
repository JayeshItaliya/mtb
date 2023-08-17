import 'package:flutter/material.dart';
import 'package:mtb/screens/homeFlow/billDetailsScreen.dart';
import 'package:mtb/screens/homeFlow/forScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
     inactiveIcon:Image.asset("assets/homeFlow/following.png",color: AppColors.grey) ,
     icon: Image.asset("assets/homeFlow/following.png",color: AppColors.primaryColor),
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
    )
  ];

  List<Widget> widgetScreen = [
    const BillDetailsScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomSheet: PersistentTabView(
        context,
        bottomScreenMargin: 0,
        margin: EdgeInsets.zero,
        padding: const NavBarPadding.fromLTRB(5,3,5,3),
        navBarHeight: Resp.size(70),
        controller: controller,
        screens: widgetScreen,
        items: navBarsItems,
        resizeToAvoidBottomInset: true,
        onItemSelected: (value) {
          setState(() {});
        },
        backgroundColor: AppColors.lightBlack,
        confineInSafeArea: false,
        stateManagement: true,
        navBarStyle: NavBarStyle.style3,
        hideNavigationBarWhenKeyboardShows: false,
        hideNavigationBar: true,
        handleAndroidBackButtonPress: true,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
      ),
    );
  }

}
