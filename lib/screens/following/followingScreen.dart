import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';

import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';
import 'filterBillsScreen.dart';
import 'filterTopicScreen.dart';
import 'followingBill.dart';
import 'followingCongressPerson.dart';
import 'followingTopicScreen.dart';


class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const HeightBox(15),
          customAppBar(
              title: 'Following',
              isSuffix: false,
              context: context,
            isPrefix: false
          ),
          const HeightBox(20),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: Resp.size(4)),
              children: [

                Container(
                  // padding: EdgeInsets.fromLTRB(
                  //   Resp.size(12),
                  //   Resp.size(12),
                  //   Resp.size(0),
                  //   Resp.size(12),
                  // ),
                  decoration: ShapeDecoration(
                    color: AppColors.lightBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Resp.size(10)),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          Resp.size(12),
                          Resp.size(12),
                          Resp.size(12),
                          Resp.size(0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InterText(
                              text: 'You are following 3 Bills',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            InkWell(
                              onTap: () {
                                toPushNavigator(
                                    context: context,
                                    PageName: const FilterBillsScreen());
                              },
                              child: SvgPicture.asset(
                                  'assets/following/filter.svg',
                                width: Resp.size(68),
                                height: Resp.size(31),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HeightBox(12),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          Resp.size(0),
                          Resp.size(0),
                          Resp.size(12),
                          Resp.size(0),
                        ),
                        // margin: EdgeInsets.only(bottom: Resp.size(25),),
                        decoration: ShapeDecoration(
                          color: AppColors.lightBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Resp.size(10)),
                          ),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          physics: const ClampingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // maxCrossAxisExtent: 200,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(
                                Resp.size(12),
                                Resp.size(0),
                                Resp.size(0),
                                Resp.size(12),
                              ),
                              decoration: ShapeDecoration(
                                color: AppColors.lightBlack,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(Resp.size(10)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  topicCard(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          toPushNavigator(
                              context: context, PageName: const FollowingBill());
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            Resp.size(12),
                            Resp.size(0),
                            Resp.size(12),
                            Resp.size(12),
                          ),
                          child: Container(
                            height: Resp.size(42),
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              color: AppColors.grey.withOpacity(0.3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            alignment: Alignment.center,
                            child: InterText(
                              text:'See More',
                              color: AppColors.primaryColor,
                              textAlign: TextAlign.center,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
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
                              text: '8 Congress Person',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            InkWell(
                              onTap: () {
                                // toPushNavigator(
                                //     context: context,
                                //     PageName: const ForScreen());
                              },
                              child: SvgPicture.asset(
                                'assets/following/filter.svg',
                                width: Resp.size(68),
                                height: Resp.size(31),
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
                      InkWell(
                        onTap: (){
                          toPushNavigator(
                              context: context, PageName: const FollowingCongressPerson());
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            Resp.size(0),
                            Resp.size(12),
                            Resp.size(12),
                            Resp.size(0),
                          ),
                          child: Container(
                            height: Resp.size(42),
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              color: AppColors.grey.withOpacity(0.3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            alignment: Alignment.center,
                            child: InterText(
                              text:'See More',
                              color: AppColors.primaryColor,
                              textAlign: TextAlign.center,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
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
                              text: '6 Topics',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            InkWell(
                              onTap: () {
                                toPushNavigator(
                                    context: context,
                                    PageName: const FilterTopicScreen());
                              },
                              child: SvgPicture.asset(
                                'assets/following/filter.svg',
                                width: Resp.size(68),
                                height: Resp.size(31),
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
                      InkWell(
                        onTap: (){
                          toPushNavigator(
                              context: context,
                              PageName: const FollowingTopic());
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            Resp.size(0),
                            Resp.size(12),
                            Resp.size(12),
                            Resp.size(0),
                          ),
                          child: Container(
                            height: Resp.size(42),
                            width: double.infinity,
                            decoration: ShapeDecoration(
                              color: AppColors.grey.withOpacity(0.3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            alignment: Alignment.center,
                            child: InterText(
                              text:'See More',
                              color: AppColors.primaryColor,
                              textAlign: TextAlign.center,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const HeightBox(89),
              ],
            ),
          ),
        ],
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
          desc.length > 150
              ? TextSpan(
            text: desc.substring(0, 150),
          )
              : TextSpan(
            text: desc.toString(),
          ),
          desc.length > 150
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
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return moreDialog(title, desc);
                    });
              },
          )
              : TextSpan(text: ''),
        ],
      ),
    );
  }

  Widget moreDialog(String title, String desc) =>
      StatefulBuilder(builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: cx.width / 1.15,
            height: cx.height / 1.1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                InterText(
                    height: 1.2,
                    text: title,
                    fontSize: cx.height > 800 ? 23 : 20,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.ellipsis,
                    color: Colors.black),
                const HeightBox(20),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 8, 10, 8),
                        child: InterText(
                          color: Color(0xFF444444),
                          fontWeight: FontWeight.w500,
                          fontSize: cx.height > 800 ? 18 : 16,
                          textAlign: TextAlign.start,
                          text: desc,
                          maxLines: 100000,
                        ),
                      ),
                      HeightBox(20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });

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
                    'assets/homeFlow/following.svg',
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
                    'assets/common/labor.svg',
                    width: Resp.size(45),
                    height: Resp.size(45),
                  ),
                  const HeightBox(10),
                  SvgPicture.asset(
                    'assets/homeFlow/following.svg',
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
  Widget topicCard() {
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
                    child: SvgPicture.asset(
                      'assets/common/immigration.svg',
                    ),
                  ),
                  const HeightBox(10),
                  InterText(
                    text: 'Immigration Bill',
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                  const HeightBox(8),
                  SvgPicture.asset(
                    'assets/homeFlow/following.svg',
                    width: Resp.size(85),
                    height: Resp.size(28),
                  ),                  // Container(
                  //   decoration: ShapeDecoration(
                  //     color: AppColors.passedHouse,
                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  //   ),
                  //   width: Resp.size(85),
                  //   height: Resp.size(28),
                  //   alignment: Alignment.center,
                  //   child: InterText(
                  //     text: 'Passed House',
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          // WidthBox(Resp.size(12)),
        ],
      ),
    );
  }

}
