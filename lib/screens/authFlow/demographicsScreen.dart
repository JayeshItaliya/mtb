import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/demographicsController.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/dropDown.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';

import '../../mainPage.dart';
import '../../utils/utils.dart';
import '../homeFlow/homeScreen.dart';

class DemoGraphicsScreen extends StatefulWidget {
  final bool isFromProfile;
  const DemoGraphicsScreen({this.isFromProfile=false,super.key});

  @override
  State<DemoGraphicsScreen> createState() => _DemoGraphicsScreenState();
}

class _DemoGraphicsScreenState extends State<DemoGraphicsScreen> {
  final demoGraphicsController = Get.put(DemoGraphicsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: Resp.size(15)),
        physics: ClampingScrollPhysics(),
        children: [
          if(widget.isFromProfile)...{
            const HeightBox(30),
            customAppBar(title: '', context: context, isSuffix: false),
          },
          const HeightBox(20),
          InterText(
              text: "Input your Demographic",
              fontSize: 24,
              fontWeight: FontWeight.w600),
          InterText(
              text: "Information", fontSize: 24, fontWeight: FontWeight.w600),
          const HeightBox(10),
          Padding(
            padding: const EdgeInsets.only(right: 26),
            child: InterText(
                text:
                    "This information is used to personalize your legislative feed. It will not be used or sent anywhere.",
                fontSize: 12,
                textOverflow: TextOverflow.clip,
                color: AppColors.lightGrey,
                maxLines: 2,
                fontWeight: FontWeight.w600),
          ),
          const HeightBox(30),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.ageList,
              mycontrollerValue: demoGraphicsController.selectAgeValue,
              hint: "Age"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.genderList,
              mycontrollerValue: demoGraphicsController.selectGenderValue,
              hint: "Gender"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.stateList,
              mycontrollerValue:
                  demoGraphicsController.selectedState,
              hint: "State"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.cityList,
              mycontrollerValue:
                  demoGraphicsController.selectedCity,
              hint: "City"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.parentalStatusList,
              mycontrollerValue:
                  demoGraphicsController.selectedParentalStatusValue,
              hint: "Parental Status"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.sexualOrientationList,
              mycontrollerValue:
                  demoGraphicsController.selectedSexualOrientationValue,
              hint: "Sexual Orientation"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.citizenShipList,
              mycontrollerValue: demoGraphicsController.selectedCitizenShip,
              hint: "CitizenShip Status"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.homeOwnerStatusList,
              mycontrollerValue: demoGraphicsController.selectedHomeOwner,
              hint: "Home-owner Status"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.healthCareList,
              mycontrollerValue: demoGraphicsController.selectedHealthCare,
              hint: "Healthcare"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.employeeStatusList,
              mycontrollerValue: demoGraphicsController.selectedEmployment,
              hint: "Employment Status"),
          CommonDropDown(
              context: context,
              list: demoGraphicsController.serviceStatusList,
              mycontrollerValue: demoGraphicsController.selectedServiceStatus,
              hint: "Service Status",
            isHeightBox: false
          ),
          CommonButton(
            text: widget.isFromProfile?'Save':"Continue",
            onTap: () {
              toPushNavigator(
                  context: context, PageName: const MainPageScreen());
            },
          ),
          HeightBox(
            Resp.size(25),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    Get.delete<DemoGraphicsController>();
  }
}
