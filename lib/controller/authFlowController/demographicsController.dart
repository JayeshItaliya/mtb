import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtb/services/api_config.dart';
import 'package:mtb/utils/circularLoader.dart';
import 'package:mtb/utils/utils.dart';

import '../../mainPage.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/strings.dart';

class DemographicsController extends GetxController{


  final ageController =TextEditingController().obs;
  final employeeStatusController =TextEditingController().obs;
  final employmentStatusController =TextEditingController().obs;

  var selectAgeValue="Age".obs;
  var selectGenderValue="Gender".obs;
  var selectedCity="City".obs;
  var selectedState="State".obs;
  var selectedParentalStatusValue="Parental Status".obs;
  var selectedSexualOrientationValue="Sexual Orientation".obs;
  var selectedCitizenShip="Citizenship Status".obs;
  var selectedHomeOwner="Home-owner Status".obs;
  var selectedHealthCare="Healthcare".obs;
  var selectedEmployment="Employment Status".obs;
  var selectedServiceStatus="Service Status".obs;

  List<String> ageList=
  [
    "13-18",
    "13-25",
    "18+",
    "65+",
  ];

  List<String> genderList=
  [
    "Female",
    "Male",
    "Non-binary",
  ];

  List<String> cityList=
  [
    "Middletown",
  ];

  List<String> stateList=
  [
    "Connecticut",
  ];

  List<String> sexualOrientationList=
  [
    "Heterosexual",
    "LGBTQ",
  ];

  List<String> citizenShipList=
  [
    "U.S. Citizen",
    "Lawful Permanent Resident",
    "Undocumented Immigrant",
    "Temporary Visitor",
  ];

  List<String> homeOwnerStatusList=
  [
    "Home-owner",
    "Renter",
    "Without housing",
  ];

  List<String> healthCareList=
  [
    "Private healthcare",
    "Government Healthcare",
    "Employer-provided Healthcare",
  ];

  List<String> parentalStatusList=
  [
    "Parent",
    "Expecting Parent",
    "Not a parent",
  ];

  List<String> employeeStatusList=
  [
    "Employed",
    "Unemployed",
    "Employer-provided Healthcare",
  ];

  List<String> serviceStatusList=
  [
    "Veteran",
    "Current Military Personel",
    "In Active Duty",
    "Not affiliated with the Army",
  ];


  setDemographicApiCall(BuildContext context,bool isFromProfile)async{
    try {
      loadingDialog(context);
    var data={
      'gender':ageController.value.text.contains("Male")?'1':ageController.value.text.contains("Female")?"2":"3",
      'state': selectedState.value.toString(),
      'city': selectedCity.value.toString(),
      'sexual_orientation': selectedSexualOrientationValue.value.toString(),
      'citizenship_status': selectedCitizenShip.value.toString(),
      'home_owner_status': selectedHomeOwner.value.toString(),
      'healthcare': selectedHealthCare.value.toString(),
      'employment_status': selectedEmployment.value.toString(),
      'service_status': selectedServiceStatus.value.toString(),
      'parental_status': selectedParentalStatusValue.value.toString(),
      'age': selectAgeValue.value.toString()
    };
      dynamic response= await apiServices.postResponse(context: context,url: ApiConfig.users,body: data);
      if(response!=null){
        if(response["success"]){
          if (!context.mounted) return;
          showSuccessDialog(context,'',showMessage: false);
          if(cx.read(Keys.isCompulsoryDemographics)){
            cx.write(Keys.isCompulsoryDemographics, false);
          }
          if(isFromProfile){
            showLongToast('Demographics Updated Successfully');
          }
          else{
            showLongToast('Login Done Successfully');
            if (!context.mounted) return;
            offAllNavigator(context: context, pageName: const MainPageScreen());
          }
        }
        else if(response["success"]==false){
          showErrorDialog(context,response["message"]);
        }
      }

    } on Exception catch (e) {
      showErrorDialog(context,"OOPS!");
     customPrint("Error==>${e.toString()}");
    }
  }
}