import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtb/screens/homeFlow/againstScreen.dart';
import 'package:mtb/screens/homeFlow/forScreen.dart';
import 'package:mtb/screens/homeFlow/relatedToScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import '../../controller/homeController/billDetailsController.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class BillDetailsScreen extends StatefulWidget {
  const BillDetailsScreen({super.key});

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  final billDetailsController = Get.put(BillDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const HeightBox(15),
          customAppBar(
              title: 'Healthcare Bill', isSuffix: false, context: context),
          const HeightBox(20),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: Resp.size(4)),
              children: [
                Container(
                  padding: EdgeInsets.all(Resp.size(12)),
                  decoration: ShapeDecoration(
                    color: AppColors.lightBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Resp.size(10)),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/common/health.svg',
                          width: Resp.size(45),
                          height: Resp.size(45),
                        ),
                        title: InterText(
                          text: 'Healthcare Bill',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        subtitle: InterText(
                          text: 'Proposed on 12/04/2023',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        trailing: SvgPicture.asset(
                          'assets/homeFlow/followBill.svg',
                          width: Resp.size(69),
                          height: Resp.size(31),
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      const HeightBox(6),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: AppColors.grey.withOpacity(0.13),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Resp.size(8))),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InterText(
                              text: 'Status in Congress',
                              fontWeight: FontWeight.w400,
                            ),
                            const HeightBox(10),
                            Container(
                              decoration: ShapeDecoration(
                                color: AppColors.lightBlack,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(Resp.size(5))),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StatusCard('Introduced', isActive: true),
                                  StatusCard('Passed House'),
                                  StatusCard('Passed Senate'),
                                  StatusCard('In Effect'),
                                ],
                              ),
                            ),
                            const HeightBox(8),
                            Container(
                              decoration: ShapeDecoration(
                                color: AppColors.lightBlack,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(Resp.size(5))),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Resp.size(11),
                                  vertical: Resp.size(13)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InterText(
                                    text: 'Efficacy Rating',
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  InterText(
                                    text: '4',
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HeightBox(10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: AppColors.grey.withOpacity(0.13),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Resp.size(8))),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // InterText(
                            //   text: 'Status in CongressLorem ipsum dolor sit amet, consectetur adcinge lit.Maecenas pretium lacus quis massa blandit, ettristilectus pretium. In sed turpis fertum, placerat auguenon, maximus lorem',
                            //   fontSize: 10,
                            //   fontWeight: FontWeight.w400,
                            //   textOverflow: TextOverflow.clip,
                            //   maxLines: 3,
                            // ),
                            handleDescription("Bill Description",
                                'Status in CongressLorem ipsum dolor sit amet, consectetur adcinge lit.Maecenas pretium lacus quis massa blandit, ettristilectus pretium. In sed turpis fertum, placerat auguenon, maximus lorem'),
                            const HeightBox(10),
                            Container(
                              decoration: ShapeDecoration(
                                color: AppColors.lightBlack,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(Resp.size(5))),
                              ),
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: Resp.size(11),
                              //     vertical: Resp.size(13)),
                              child: Column(
                                children: [
                                  BillCharacteristicsCard('Efficacy Rating', 4),
                                  BillCharacteristicsCard('Clarity', 4),
                                  BillCharacteristicsCard('Redundancy', 4),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const HeightBox(12),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    Resp.size(12),
                    Resp.size(12),
                    Resp.size(0),
                    Resp.size(12),
                  ),
                  decoration: ShapeDecoration(
                    color: AppColors.lightBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Resp.size(10)),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Resp.size(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InterText(
                              text: 'For',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            InkWell(
                              onTap: () {
                                toPushNavigator(
                                    context: context,
                                    PageName: const ForScreen());
                              },
                              child: InterText(
                                text: 'See More',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HeightBox(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PersonCard(),
                          PersonCard(),
                          PersonCard(),
                        ],
                      ),
                    ],
                  ),
                ),
                const HeightBox(12),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    Resp.size(12),
                    Resp.size(12),
                    Resp.size(0),
                    Resp.size(12),
                  ),
                  decoration: ShapeDecoration(
                    color: AppColors.lightBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Resp.size(10)),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Resp.size(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InterText(
                              text: 'Against',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            InkWell(
                              onTap: () {
                                toPushNavigator(
                                    context: context,
                                    PageName: const AgainstScreen());
                              },
                              child: InterText(
                                text: 'See More',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HeightBox(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PersonCard(),
                          PersonCard(),
                          PersonCard(),
                        ],
                      ),
                    ],
                  ),
                ),
                const HeightBox(12),
                Image.asset(
                  'assets/homeFlow/map.png',
                  width: Resp.size(343),
                  height: Resp.size(165),
                ),
                const HeightBox(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          billDetailsController.upValue.value =
                              !billDetailsController.upValue.value;
                        },
                        child: SvgPicture.asset(
                          billDetailsController.upValue.value
                              ? 'assets/homeFlow/up.svg'
                              : 'assets/homeFlow/noneUp.svg',
                          width: Resp.size(55),
                          height: Resp.size(55),
                        )),
                    InkWell(
                        onTap: () {
                          billDetailsController.downValue.value =
                              !billDetailsController.downValue.value;
                        },
                        child: SvgPicture.asset(
                          billDetailsController.downValue.value
                              ? 'assets/homeFlow/down.svg'
                              : 'assets/homeFlow/noneDown.svg',
                          width: Resp.size(55),
                          height: Resp.size(55),
                        )),
                  ],
                ),
                const HeightBox(30),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    Resp.size(12),
                    Resp.size(12),
                    Resp.size(0),
                    Resp.size(12),
                  ),
                  decoration: ShapeDecoration(
                    color: AppColors.lightBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Resp.size(10)),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Resp.size(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InterText(
                              text: 'Related To',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            InkWell(
                              onTap: () {
                                toPushNavigator(
                                    context: context,
                                    PageName: const RelatedToScreen());
                              },
                              child: InterText(
                                text: 'View All',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HeightBox(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          topicsCard('Infrastructure Bill'),
                          topicsCard('Infrastructure Bill'),
                          topicsCard('Healthcare Bill'),
                        ],
                      ),
                    ],
                  ),
                ),
                const HeightBox(89),
              ],
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomSheet: BottomSheet(
        backgroundColor: AppColors.lightBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Resp.size(15)),
            topRight: Radius.circular(Resp.size(15)),
            bottomRight: Radius.circular(Resp.size(0)),
            bottomLeft: Radius.circular(Resp.size(0)),
          ),
        ),
        onClosing: () {},
        builder: (BuildContext context) {
          return Container(
            height: Resp.size(76),
            // color: AppColors.lightBlack,

            decoration: ShapeDecoration(
              color: AppColors.lightBlack,
              shadows: const [
                BoxShadow(
                    color: AppColors.lightBlack,
                    spreadRadius: 0,
                    blurRadius: 10),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Resp.size(15)),
                  topRight: Radius.circular(Resp.size(15)),
                  bottomRight: Radius.circular(Resp.size(0)),
                  bottomLeft: Radius.circular(Resp.size(0)),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/homeFlow/news.svg',
                      width: Resp.size(26),
                      height: Resp.size(26),
                    ),
                    const HeightBox(10),
                    InterText(
                      text: 'News',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/homeFlow/add.svg',
                      width: Resp.size(26),
                      height: Resp.size(26),
                    ),
                    const HeightBox(10),
                    InterText(
                      text: 'Follow',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    onShareData(
                        text: "\*Download Mind The Bill Now😍"
                            "\*\n\nLink For iOS:\nhttps://apps.apple.com/us/app/domez/id6444339880"
                            "\n\nLink For Android:"
                            "\nhttps://play.google.com/store/apps/details?id=domez.io\n");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/homeFlow/share.svg',
                        width: Resp.size(26),
                        height: Resp.size(26),
                      ),
                      const HeightBox(10),
                      InterText(
                        text: 'Share',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget StatusCard(String text, {bool isActive = false}) {
    return Padding(
      padding: EdgeInsets.only(
        left: !isActive && text == 'Introduced' ? Resp.size(11) : 0,
        right: !isActive && text == 'In Effect' ? Resp.size(11) : 0,
      ),
      child: Container(
        decoration: ShapeDecoration(
          color:
              isActive ? AppColors.grey.withOpacity(0.25) : Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Resp.size(5))),
        ),
        padding: isActive
            ? EdgeInsets.symmetric(
                vertical: Resp.size(10), horizontal: Resp.size(8))
            : EdgeInsets.symmetric(vertical: Resp.size(13)),
        margin: EdgeInsets.all(Resp.size(3)),
        child: InterText(
          text: text,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget commonContainer(String text, {bool isTag = true}) {
    return Container(
      decoration: ShapeDecoration(
        color: isTag ? AppColors.purple : AppColors.darkBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Resp.size(5))),
      ),
      padding: EdgeInsets.symmetric(
          vertical: Resp.size(10), horizontal: Resp.size(8)),
      child: InterText(
        text: text,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      ),
    );
  }

  Widget BillCharacteristicsCard(String text, int value) {
    return Container(
      padding: EdgeInsets.only(
          left: Resp.size(11),
          right: Resp.size(11),
          top: text == 'Efficacy Rating' ? Resp.size(12) : Resp.size(0),
          bottom: text == 'Redundancy' ? Resp.size(12) : Resp.size(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InterText(
            text: text,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          InterText(
            text: value.toString(),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  Widget handleDescription(String title, String desc) {
    return RichText(
      maxLines: 10,
      overflow: TextOverflow.clip,
      text: TextSpan(
        text: '',
        style: GoogleFonts.inter(
          color: Colors.white.withOpacity(0.4),
          fontWeight: FontWeight.w500,
          fontSize: Resp.size(12),
        ),
        children: <TextSpan>[
          desc.length > 120
              ? TextSpan(
                  text: desc.substring(0, 120),
                )
              : TextSpan(
                  text: desc.toString(),
                ),
          desc.length > 120
              ? TextSpan(
                  text: '...See More',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    fontSize: Resp.size(12),
                    // decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // showDialog(
                      //     barrierDismissible: false,
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return moreDialog(title, desc);
                      //     });
                    },
                )
              : TextSpan(text: ''),
        ],
      ),
    );
  }

  Widget PersonCard() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.grey.withOpacity(0.13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              padding: EdgeInsets.fromLTRB(
                  Resp.size(7), Resp.size(12), Resp.size(7), Resp.size(8)),
              child: Column(
                children: [
                  SizedBox(
                    height: Resp.size(55),
                    width: Resp.size(55),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 55,
                      backgroundImage: AssetImage(
                        'assets/homeFlow/dummyPerson.png',
                      ),
                    ),
                  ),
                  const HeightBox(10),
                  InterText(
                    text: 'Ralph Edwards',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  const HeightBox(8),
                  SvgPicture.asset(
                    'assets/homeFlow/followPerson.svg',
                    width: Resp.size(85),
                    height: Resp.size(28),
                  ),
                ],
              ),
            ),
          ),
          WidthBox(12),
        ],
      ),
    );
  }

  Widget topicsCard(String text) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.grey.withOpacity(0.13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Resp.size(8),
                vertical: Resp.size(12),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/common/health.svg',
                    width: Resp.size(45),
                    height: Resp.size(45),
                  ),
                  const HeightBox(10),
                  InterText(
                    text: text,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          WidthBox(12),
        ],
      ),
    );
  }
}
