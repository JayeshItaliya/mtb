import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/commonController/commonController.dart';

CommonController cx = Get.put(CommonController());
String location = '';
String address = '';
String bookingId = '';
String demoText = 'Lorem It is a long established fact that a reader will betai by the readable content of a page when looking at its is layout. The point of using Lorem Ipsum is that it has and more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packagesdf and web page editors now use Lorem Ipsum as their dei ult model text, and a search for lorem ipsum will uncov er many web sites still in their infancy. Various versions have evolved over the years, sometimes by accidentsc sometimes on \n\nLorem It is a long established fact that a reader will betai by the readable content of a page when looking at its is layout. The point of using Lorem Ipsum is that it has and more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packagesdf and web page editors now use Lorem Ipsum as their dei ult model text, and a search for lorem ipsum will uncov er many web sites still in their infancy. Various versions have evolved over the years, sometimes by accidentsc sometimes on ';

showLongToast(String s) {
  Fluttertoast.showToast(
    msg: s,
    toastLength: Toast.LENGTH_LONG,
  );
}

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
                  Icon(
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
  String? suffixImage,
  Color? suffixBackgroundColor,
  Function? suffixOnTap,
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
  bool showCrossBackButton=false,
  required String? title,
  required BuildContext context,
}) {
  return Row(
    children: [
      isPrefix
          ? InkWell(
        onTap: () {
          onBack(context);
        },
        child: Image.asset(
          'assets/common/back.png',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          scale: 3,
        ),
      )
              onTap: () {
                onBack(context);
              },
              child: Image.asset(
                'assets/common/${!showCrossBackButton?'back':'cross_back'}.png',
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
          fontSize: fontSize ?? 16,
          textAlign: textAlign ?? TextAlign.center,
        ),
      ),
      if (isPrefix && !isSuffix) ...{Container(width: Resp.size(30))},
      isSuffix
          ? Image.asset(
        'assets/common/filter.png',
        fit: BoxFit.cover,
        alignment: Alignment.center,
        scale: 3,
      )
          : Container(),
    ],
  );
}
