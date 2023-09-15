// ignore_for_file: unnecessary_brace_in_string_interps, constant_identifier_names

class ApiConfig {
  ///live url
  // static const String baseUrl = "http://192.168.0.135/mtb-project/api/";
   static const String baseUrl = "https://mindthebill.com/api/";

  /// Auth Flow & Profile Flow
  static const String signUp = "${baseUrl}signup";
  static const String signIn = "${baseUrl}signin";
  static const String forgotPassword = "${baseUrl}forgotpassword";
  static const String verifyCode = "${baseUrl}verifycode";
  static const String changePassword = "${baseUrl}change-password";
  static const String editProfile = "${baseUrl}profile";
  static const String users = "${baseUrl}users";
  static const String logout = "${baseUrl}logout";
  static const String deleteAccount = "${baseUrl}users";
  static const String getUserData = "${baseUrl}users";
  static const String followTopic = "${baseUrl}followtopic";


  /// Home Flow
  static const String billdata = "${baseUrl}billdata";
  static const String relatedBill = "${baseUrl}related_bill";
  static const String likeBill = "${baseUrl}bill/like";
  static const String follow = "${baseUrl}follow";

  /// Search Flow
  static const String filterData = "${baseUrl}filter?";
  static const String search = "${baseUrl}search?bill_name=";

  /// Trending Flow
  static const String newestBills = "${baseUrl}bills/newest";
  static const String forYou = "${baseUrl}foryou";
  static const String topIssues = "${baseUrl}topissues";
}
