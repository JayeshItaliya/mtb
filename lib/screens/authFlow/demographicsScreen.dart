import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/demographicsController.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/dropDown.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/responsiveUi.dart';
import '../../controller/profileController/getProfileDataController.dart';
import '../../utils/utils.dart';

class DemoGraphicsScreen extends StatefulWidget {
  final bool isFromProfile;
  final bool isBackButton;

  const DemoGraphicsScreen(
      {this.isFromProfile = false, this.isBackButton = true, super.key});

  @override
  State<DemoGraphicsScreen> createState() => _DemoGraphicsScreenState();
}

class _DemoGraphicsScreenState extends State<DemoGraphicsScreen> {
  final demoGraphicsController = Get.put(DemographicsController());
  final profileController = Get.put(GetProfileDataController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getUserProfileApiCall(context);
      if (widget.isFromProfile) {
        demoGraphicsController.selectAgeValue.value =
            profileController.userProfileModel.age.toString();
        demoGraphicsController.selectGenderValue.value =
            profileController.userProfileModel.gender == 1
                ? 'Male'
                : profileController.userProfileModel.gender == 2
                    ? 'Female'
                    : profileController.userProfileModel.gender == 3
                        ? 'Non-binary'
                        : 'Gender';
        demoGraphicsController.selectedState.value =
            profileController.userProfileModel.state.toString();
        demoGraphicsController.selectedCity.value =
            profileController.userProfileModel.city.toString();
        demoGraphicsController.selectedParentalStatusValue.value =
            profileController.userProfileModel.parentalStatus.toString();
        demoGraphicsController.selectedSexualOrientationValue.value =
            profileController.userProfileModel.sexualOrientation.toString();
        demoGraphicsController.selectedCitizenShip.value =
            profileController.userProfileModel.citizenshipStatus.toString();
        demoGraphicsController.selectedHomeOwner.value =
            profileController.userProfileModel.homeOwnerStatus.toString();
        demoGraphicsController.selectedHealthCare.value =
            profileController.userProfileModel.healthcare.toString();
        demoGraphicsController.selectedEmployment.value =
            profileController.userProfileModel.employmentStatus.toString();
        demoGraphicsController.selectedServiceStatus.value =
            profileController.userProfileModel.serviceStatus.toString();
      } else {
        demoGraphicsController.selectedState.value = "Connecticut";
        demoGraphicsController.selectedCity.value = 'Middletown';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetProfileDataController>(builder: (controller) {
      return SafeArea(
        bottom: true,
        top: true,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ListView(
            shrinkWrap: true,
            padding: defaultScreenPadding(hPadding: 12),
            physics: const ClampingScrollPhysics(),
            children: [
              customAppBar(
                  title: '',
                  context: context,
                  isSuffix: false,
                  isPrefix: widget.isBackButton),
              HeightBox(widget.isBackButton ? 20 : 0),
              const InterText(
                  text: "Input your Demographic",
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
              const InterText(
                  text: "Information",
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
              const HeightBox(10),
              const Padding(
                padding: EdgeInsets.only(right: 26),
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
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.ageList,
                  mycontrollerValue: demoGraphicsController.selectAgeValue,
                  hint: "Age"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.genderList,
                  mycontrollerValue: demoGraphicsController.selectGenderValue,
                  hint: "Gender"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.stateList,
                  mycontrollerValue: demoGraphicsController.selectedState,
                  hint: "State"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.cityList,
                  mycontrollerValue: demoGraphicsController.selectedCity,
                  hint: "City"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.parentalStatusList,
                  mycontrollerValue:
                      demoGraphicsController.selectedParentalStatusValue,
                  hint: "Parental Status"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.sexualOrientationList,
                  mycontrollerValue:
                      demoGraphicsController.selectedSexualOrientationValue,
                  hint: "Sexual Orientation"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.citizenShipList,
                  mycontrollerValue: demoGraphicsController.selectedCitizenShip,
                  hint: "CitizenShip Status"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.homeOwnerStatusList,
                  mycontrollerValue: demoGraphicsController.selectedHomeOwner,
                  hint: "Home-owner Status"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.healthCareList,
                  mycontrollerValue: demoGraphicsController.selectedHealthCare,
                  hint: "Healthcare"),
              commonDropDown(
                  context: context,
                  list: demoGraphicsController.employeeStatusList,
                  mycontrollerValue: demoGraphicsController.selectedEmployment,
                  hint: "Employment Status"),
              commonDropDown(
                context: context,
                list: demoGraphicsController.serviceStatusList,
                mycontrollerValue: demoGraphicsController.selectedServiceStatus,
                hint: "Service Status",
              ),
              CommonButton(
                text: widget.isFromProfile ? 'Save' : "Continue",
                onTap: () {
                  if (demoGraphicsController.selectAgeValue.value == 'Age') {
                    showLongToast('Please select Age');
                  } else if (demoGraphicsController.selectGenderValue.value ==
                      'Gender') {
                    showLongToast('Please select Gender');
                  } else if (demoGraphicsController.selectedState.value ==
                      'State') {
                    showLongToast('Please select State');
                  } else if (demoGraphicsController.selectedCity.value ==
                      'City') {
                    showLongToast('Please select City');
                  } else if (demoGraphicsController
                          .selectedParentalStatusValue.value ==
                      'Parental Status') {
                    showLongToast('Please select Parental Status');
                  } else if (demoGraphicsController
                          .selectedSexualOrientationValue.value ==
                      'Sexual Orientation') {
                    showLongToast('Please select Sexual Orientation');
                  } else if (demoGraphicsController.selectedCitizenShip.value ==
                      'Citizenship Status') {
                    showLongToast('Please select Citizenship Status');
                  } else if (demoGraphicsController.selectedHomeOwner.value ==
                      'Home-owner Status') {
                    showLongToast('Please select Home-owner Status');
                  } else if (demoGraphicsController.selectedHealthCare.value ==
                      'Healthcare') {
                    showLongToast('Please select Healthcare');
                  } else if (demoGraphicsController.selectedEmployment.value ==
                      'Employment Status') {
                    showLongToast('Please select Employment Status');
                  } else if (demoGraphicsController
                          .selectedServiceStatus.value ==
                      'Service Status') {
                    showLongToast('Please select Service Status');
                  } else {
                    demoGraphicsController.setDemographicApiCall(
                        context, widget.isFromProfile);
                  }
                },
              ),
              HeightBox(
                Resp.size(25),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<DemographicsController>();
  }
}
