import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import 'package:mtb/utils/utils.dart';

import '../model/followingModel/followModel.dart';
import '../model/homeFlowModel/billListModel.dart';
import '../screens/homeFlow/billDetailsScreen.dart';
import '../screens/homeFlow/filterDataScreen.dart';
import 'appColors.dart';
import 'follow.dart';
import 'following.dart';
import 'interText.dart';

Widget homeCard(BuildContext context, BillListModel item, var controller,
    int index, VoidCallback onTapFollow,
    {bool onBackShowBottomSheet = true}) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.fromLTRB(
          Resp.size(12),
          0,
          Resp.size(12),
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
            ListTile(
              leading: InkWell(
                onTap: () {
                  cx.showBottomSheet.value = false;
                  toPushNavigator(
                      context: context,
                      onBack: (value) {
                        cx.showBottomSheet.value = onBackShowBottomSheet;
                      },
                      pageName: FilterDataScreen(
                          metaData:
                              "&topic_tag=${item.topicSimplified.toString()}"));
                },
                child: SvgPicture.asset(
                  getTopicImage(item.topicSimplified.toString()),
                  width: Resp.size(45),
                  height: Resp.size(45),
                ),
              ),
              title: InterText(
                text: item.billName,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              subtitle: InterText(
                text: 'Proposed on ${item.proposedDate}',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.white.withOpacity(0.5),
              ),
              trailing: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 85),
                child: InkWell(
                  child: (item.isFollow ?? false)
                      ? followingBill(width: 69, height: 31)
                      // : Container(
                      //     width: Resp.size(69),
                      //     height: Resp.size(31),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(Resp.size(5)),
                      //         color: AppColors.grey.withOpacity(0.3),
                      //         // image: const DecorationImage(
                      //         //     image: AssetImage(
                      //         //       'assets/homeFlow/home.png',
                      //         //     )
                      //         // )
                      //     ),
                      //     alignment: Alignment.center,
                      //     child: SvgPicture.asset(
                      //       'assets/homeFlow/followBill.svg',
                      //     ),
                      //   ),
                  : followBill(width: 69, height: 31),
                  onTap: () => onTapFollow(),
                ),
              ),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            const HeightBox(6),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: AppColors.grey.withOpacity(0.13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Resp.size(8))),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InterText(
                    text: 'Status in Congress',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  const HeightBox(10),
                  Container(
                    decoration: ShapeDecoration(
                      color: AppColors.lightBlack,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Resp.size(5))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        statusCard('Introduced',
                            selectedText: item.statusInCongress),
                        Flexible(
                            child: statusCard('Passed House',
                                selectedText: item.statusInCongress)),
                        Flexible(
                            child: statusCard('Passed Senate',
                                selectedText: item.statusInCongress)),
                        statusCard('In Effect',
                            selectedText: item.statusInCongress),
                      ],
                    ),
                  ),
                  // const HeightBox(8),
                  // Container(
                  //   decoration: ShapeDecoration(
                  //     color: AppColors.lightBlack,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius:
                  //             BorderRadius.circular(
                  //                 Resp.size(5))),
                  //   ),
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: Resp.size(11),
                  //       vertical: Resp.size(13)),
                  //   child: const Row(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment
                  //             .spaceBetween,
                  //     children: [
                  //       InterText(
                  //         text: 'Efficacy Rating',
                  //         textAlign: TextAlign.center,
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 12,
                  //       ),
                  //       InterText(
                  //         text: '4',
                  //         textAlign: TextAlign.center,
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 12,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const HeightBox(15),
                ],
              ),
            ),
            const HeightBox(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const InterText(text: 'Tags:', color: Colors.white),
                    const WidthBox(8),
                    commonContainer(
                      '#${item.tags}',
                    )
                  ],
                ),
                Row(
                  children: [
                    const InterText(text: 'Type:', color: Colors.white),
                    const WidthBox(8),
                    commonContainer(item.type.toString(), isTag: false)
                  ],
                ),
              ],
            ),
            const HeightBox(5),
          ],
        ),
      ),
      index == controller.billDataList.length - 1
          ? const HeightBox(75)
          : const HeightBox(12),
    ],
  );
}

Widget commonContainer(String text, {bool isTag = true}) {
  return Container(
    decoration: ShapeDecoration(
      color: isTag ? AppColors.purple : AppColors.darkBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Resp.size(5))),
    ),
    padding:
        EdgeInsets.symmetric(vertical: Resp.size(10), horizontal: Resp.size(8)),
    child: InterText(
      text: text,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w400,
      fontSize: 10,
    ),
  );
}

Widget topicCard(FollowModel model, Function onFollowClick) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Resp.size(55),
                  width: Resp.size(55),
                  child: SvgPicture.asset(
                    getTopicImage(model.topicTag ?? ''),
                  ),
                ),
                const HeightBox(10),
                InterText(
                  text: model.billName,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
                const HeightBox(8),
                InkWell(
                  onTap: () {
                    onFollowClick();
                  },
                  child: SvgPicture.asset(
                    'assets/homeFlow/following.svg',
                    width: Resp.size(85),
                    height: Resp.size(28),
                  ),
                ),
                // Container(
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

Widget topicsForYouCard({
  required Function navigation,
  required bool isFollowing,
  required Function onTapFollow,
  required String topicName,
  bool isFromSignUp = false,
}) {
  return Expanded(
    child: InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () => navigation(),
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
                  Resp.size(7), Resp.size(8), Resp.size(7), Resp.size(8)),
              alignment: Alignment.center,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      //TODO NOT DONE
                      // toPushNavigator(
                      //     context: context,
                      //     pageName: FilterDataScreen(metaData: "&topic_tag=${item.newBill?.topicSimplified.toString()??""}"));
                    },
                    child: SizedBox(
                      height: Resp.size(55),
                      width: Resp.size(55),
                      child: SvgPicture.asset(
                        getTopicImage(topicName),
                      ),
                    ),
                  ),
                  HeightBox(isFromSignUp ? 10 : 0),
                  isFromSignUp
                      ? InterText(
                          text: topicName,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                  const HeightBox(10),
                  InkWell(
                    child: isFollowing
                        ? followingBill(width: 85, height: 28)
                        : followBill(width: 85, height: 28),
                    onTap: () => onTapFollow(),
                  ),
                ],
              ),
            ),
          ),
          // WidthBox(12),
        ],
      ),
    ),
  );
}

Widget topicsCardFollowing(String text, Function onTapFollow) {
  return Container(
    decoration: ShapeDecoration(
      color: AppColors.grey.withOpacity(0.13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: Resp.size(8),
      vertical: Resp.size(12),
    ),
    child: Column(
      children: [
        SvgPicture.asset(
          getTopicImage(text),
          width: Resp.size(55),
          height: Resp.size(55),
        ),
        const HeightBox(10),
        InkWell(
          onTap: () => onTapFollow(),
          child: followingBill(
            width: 85,
            height: 28,
          ),
        )
      ],
    ),
  );
}

Widget statusCard(String text, {String? selectedText}) {
  return Padding(
    padding: EdgeInsets.only(
      left: selectedText?.toLowerCase() != 'introduced' &&
              text.toLowerCase() == 'introduced'
          ? Resp.size(4)
          : 0,
      right: selectedText?.toLowerCase() != 'in effect' &&
              text.toLowerCase() == 'in effect'
          ? Resp.size(4)
          : 0,
    ),
    child: Container(
      decoration: ShapeDecoration(
        color: selectedText?.toLowerCase() == 'introduced' &&
                text.toLowerCase() == 'introduced'
            ? AppColors.introduced
            : selectedText?.toLowerCase() == 'passed house' &&
                    text.toLowerCase() == 'passed house'
                ? AppColors.passedHouse
                : selectedText?.toLowerCase() == 'passed senate' &&
                        text.toLowerCase() == 'passed senate'
                    ? AppColors.passedSenate
                    : selectedText?.toLowerCase() == 'in effect' &&
                            text.toLowerCase() == 'in effect'
                        ? AppColors.inEffect
                        : Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Resp.size(5))),
      ),
      padding: selectedText?.toLowerCase() == text.toLowerCase()
          ? EdgeInsets.symmetric(
              vertical: Resp.size(10), horizontal: Resp.size(8))
          : EdgeInsets.symmetric(vertical: Resp.size(13)),
      margin: EdgeInsets.all(Resp.size(2)),
      child: InterText(
        text: text,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w400,
        textOverflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ),
  );
}
