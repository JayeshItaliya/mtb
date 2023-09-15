import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/commonController/commonController.dart';
import '../services/networkApiServices.dart';

CommonController cx = Get.put(CommonController());
var apiServices = NetWorkApiServices();
var showBottomSheet=true.obs;
String location = '';
String address = '';
String bookingId = '';

showLongToast(String s) {
  Fluttertoast.showToast(
    msg: s,
    toastLength: Toast.LENGTH_LONG,

  );
}

const String dummyProfileUrl ="https://mindthebill.com/storage/app/public/profile_images/default.png";

EdgeInsets defaultScreenPadding({double hPadding=8}){
  return  EdgeInsets.symmetric(horizontal: Resp.size(hPadding));
}
ScrollBehavior removeScroll=const ScrollBehavior();
onShareData({String? text}) async {
  await Share.share(text!);
}

class HeightBox extends StatelessWidget {
  final double size;

  const HeightBox(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Resp.size(size),
    );
  }
}
bool isValid(String email) =>
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
class WidthBox extends StatelessWidget {
  final double size;

  const WidthBox(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Resp.size(size),
    );
  }
}

Widget noInternetLottie({bool? backbutton}) {
  return Column(
    mainAxisAlignment: backbutton ?? false
        ? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.center,
    children: [
      backbutton ?? false
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: cx.responsive(20, 15, 12),
                      top: cx.responsive(43, 35, 30)),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 27,
                          color: Colors.black,
                        ),
                      )),
                ),
              ],
            )
          : Container(),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("lottie/no_internet_lottie.json",
              height: cx.height / 2, width: double.infinity),
          HeightBox(
            cx.height / 9,
          ),
          InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              // Get.offAll(
              //   WonderEvents(),
              //   transition: Transition.fade,
              // );
            },
            child: Container(
              color: Colors.grey,
              height: cx.height / 18,
              width: cx.width / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ),
                  InterText(
                    text: " Retry",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: cx.responsive(24, 20, 18),
                  ),
                ],
              ),
            ),
          ),
          HeightBox(
            cx.height / 40,
          ),
        ],
      ),
    ],
  );
}

Gradient? backShadowContainer() {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(.0),
        Colors.black.withOpacity(.7),
      ]);
}

Widget customAppBar({
  double? suffixImagePadding,
  Widget? suffix,
  Color? suffixBackgroundColor,
  Function? onTapSuffix,
  Color? suffixImageColor,
  Color? prefixBackgroundColor,
  String? prefixImage,
  double? borderRadius,
  Function? prefixOnTap,
  bool isSuffix = true,
  bool isPrefix = true,
  Color? prefixImageColor,
  double? prefixImagePadding,
  FontWeight? fontWeight,
  double? fontSize,
  TextAlign? textAlign,
  double? prefixImageHeight,
  double? prefixImageWidth,
  Color? fontColor,
  bool showCrossBackButton = false,
  required String? title,
  required BuildContext context,
}) {
  return Column(
    children: [
      const HeightBox(10),
      Row(
        children: [
          isPrefix
              ? InkWell(

                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    onBack(context);
                  },
                  child: Image.asset(
                    'assets/common/${!showCrossBackButton ? 'back' : 'cross_back'}.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    scale: 3,
                  ),
                )
              : Container(),
          if (!isPrefix && isSuffix) ...{Container(width: Resp.size(30))},
          Expanded(
            child: InterText(
              text: title ?? '',
              color: fontColor ?? Colors.white,
              maxLines: 1,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontSize: fontSize ?? 18,
              textAlign: textAlign ?? TextAlign.center,
            ),
          ),
          if (isPrefix && !isSuffix) ...{Container(width: Resp.size(30))},
          isSuffix
              ? Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: suffix??InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () => isSuffix ? onTapSuffix!() : () {},
                    child: Image.asset(
                      'assets/common/filter.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      scale: 3,
                    ),
                  ),
              )
              : Container(),
        ],
      ),
    ],
  );
}

customPrint(var printValue){
  if (kDebugMode) {
    print(printValue);
  }
}
String getTopicImage(String topic){
  String path='assets/common/';
  switch(topic){
    case "Agriculture":
      return '${path}agriculture.svg';
    case "Army":
      return '${path}army.svg';
    case "Civil Rights":
      return '${path}civilRights.svg';
    case "Policing":
      return '${path}policing.svg';
    case "Economics":
      return '${path}economics.svg';
    case "Education":
      return '${path}education.svg';
    case "Immigration":
      return '${path}immigration.svg';
    case "Environment & Energy":
      return '${path}environment.svg';
    case "Government":
      return '${path}government.svg';
    case "Welfare":
      return '${path}welfare.svg';
    case "Labor":
      return '${path}labor.svg';
    case "Tech":
      return '${path}tech.svg';
    case "Health":
      return '${path}health.svg';
    case "Taxes":
      return '${path}taxes.svg';
    case "IR":
      return '${path}ir.svg';
    case "Infrastructure":
      return '${path}infrastructure.svg';
    case "Miscellaneous":
      return '${path}miscellaneous.svg';
    default:
      return '${path}government.svg';
  }
}

showOpenAppSettingsDialog(context) async {
  print('Permission denied');
  await openAppSettings();
  // return CustomDialog.show(
  //   context,
  //   'Permission needed',
  //   'Photos permission is needed to select photos',
  //   'Open settings',
  //   openAppSettings,
  // );
}
