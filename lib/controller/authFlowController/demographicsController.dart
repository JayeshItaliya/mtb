import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DemoGraphicsController extends GetxController{
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
    "City 1",
    "City 2",
  ];

  List<String> stateList=
  [
    "State 1",
    "State 2",
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
    "Hindu",
    "Muslim",
    "Sikh",
  ];
}