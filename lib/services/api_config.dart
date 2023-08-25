// ignore_for_file: unnecessary_brace_in_string_interps, constant_identifier_names

class ApiConfig {
  ///live url
  static const String baseUrl = "http://192.168.0.122/mtb-project/api/";

  /// Auth Flow
  static const String signUp = "${baseUrl}signup";
  static const String signIn = "${baseUrl}signin";
  static const String forgotPassword = "${baseUrl}forgotpassword";
  static const String verifyCode = "${baseUrl}verifycode";
  static const String changePassword = "${baseUrl}change-password";
  static const String users = "${baseUrl}users";
  static const String logout = "${baseUrl}logout";
  static const String deleteAccount = "${baseUrl}users";
  static const String getUserData = "${baseUrl}users";
}
