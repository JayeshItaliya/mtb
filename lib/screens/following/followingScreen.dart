import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/followingController/followingController.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';

import '../../controller/authFlowController/chooseTopicController.dart';
import '../../model/followingModel/followModel.dart';
import '../../model/trendingModel/ForYouModel.dart';
import '../../services/api_call.dart';
import '../../utils/commonCard.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';
import '../homeFlow/billDetailsScreen.dart';
import 'filterBillsScreen.dart';
import 'filterTopicScreen.dart';
import 'followingBill.dart';
import 'followingCongressPerson.dart';
import 'followingTopicScreen.dart';

class FollowingScreen extends StatefulWidget {
  final bool isFromProfile;

  const FollowingScreen({super.key, this.isFromProfile = false});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  FollowingController followController = Get.put(FollowingController());
  ChooseTopicController chooseTopicController =
      Get.put(ChooseTopicController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      followController.getFollowDataAPI(context);
      followController.forYouData.value =
          (await followController.getForYouData(context))!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: defaultScreenPadding(),
          child: Column(
            children: [
              customAppBar(
                  title: 'Following',
                  isSuffix: false,
                  context: context,
                  isPrefix: widget.isFromProfile),
              const HeightBox(20),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: Resp.size(4)),
                  children: [
                    Obx(
                      () => Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InterText(
                                    text:
                                        'You are following ${followController.followList.length} ${(followController.followList.length) > 1 ? 'Bills' : 'Bill'}',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
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
                                  borderRadius:
                                      BorderRadius.circular(Resp.size(10)),
                                ),
                              ),
                              child: Obx(() {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: followController.followList.isEmpty
                                      ? 0
                                      : followController.followList.length >= 3
                                          ? 3
                                          : followController.followList.length,
                                  physics: const ClampingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    // maxCrossAxisExtent: 200,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    FollowModel model =
                                        followController.followList[index];
                                    return InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: () {
                                        cx.showBottomSheet.value = false;
                                        toPushNavigator(
                                            context: context,
                                            onBack: (_) {
                                              cx.showBottomSheet.value = true;
                                              followController
                                                  .getFollowDataAPI(context);
                                            },
                                            pageName: BillDetailsScreen(
                                              item: followController
                                                  .followList[index]
                                                  .billdetail[0],
                                            ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                          Resp.size(12),
                                          Resp.size(0),
                                          Resp.size(0),
                                          Resp.size(8),
                                        ),
                                        decoration: ShapeDecoration(
                                          color: AppColors.lightBlack,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Resp.size(10)),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            topicCard(model, () {
                                              followController.followList
                                                  .removeAt(index);
                                              TaskProvider().followAPI(
                                                  model.billId.toString(),
                                                  '0',
                                                  context);
                                            }),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                            if (followController.followList.length > 3) ...{
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  cx.showBottomSheet.value = false;
                                  toPushNavigator(
                                      context: context,
                                      onBack: (_) async {
                                        cx.showBottomSheet.value = widget.isFromProfile?false:true;
                                      },
                                      pageName: FollowingBill(
                                          followController.followList));
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    alignment: Alignment.center,
                                    child: const InterText(
                                      text: 'See More',
                                      color: AppColors.primaryColor,
                                      textAlign: TextAlign.center,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            }
                          ],
                        ),
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InterText(
                                  text: '31 Congress Person',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                          const HeightBox(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              personCard(),
                              personCard(),
                              personCard(),
                            ],
                          ),
                          InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              cx.showBottomSheet.value = false;
                              toPushNavigator(
                                  context: context,
                                  onBack: (_) async {
                                    cx.showBottomSheet.value = widget.isFromProfile?false:true;
                                  },
                                  pageName: const FollowingCongressPerson());
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
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                alignment: Alignment.center,
                                child: const InterText(
                                  text: 'See More',
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
                    Obx(() {
                      ForYouModel item = followController.forYouData.value;

                      return Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InterText(
                                    text:
                                        '${item.topicTags?.length ?? 0} ${(item.topicTags?.length ?? 0) > 1 ? 'Topics' : 'Topic'}',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: (item.topicTags?.length ?? 0) != 0
                                  ? EdgeInsets.only(top: Resp.size(12))
                                  : EdgeInsets.zero,
                              itemCount: item.topicTags == null ||
                                      item.topicTags!.isEmpty
                                  ? 0
                                  : item.topicTags!.length >= 3
                                      ? 3
                                      : item.topicTags!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 0.9),
                              itemBuilder: (context, index) => Container(
                                margin:
                                    const EdgeInsets.only(right: 11, bottom: 0),
                                child: topicsCardFollowing(
                                    item.topicTags?[index] ?? '', () {
                                  chooseTopicController.followTopic(
                                      context, item.topicTags![index], '0');
                                  setState(() {
                                    item.topicTags?.removeAt(index);
                                    item.isFollow?.removeAt(index);
                                  });
                                }),
                              ),
                            ),
                            if ((item.topicTags?.length ?? 0) > 3) ...{
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  cx.showBottomSheet.value = false;
                                  toPushNavigator(
                                      context: context,
                                      pageName: FollowingTopic(
                                        item: item,
                                      ),
                                      onBack: (value) async {
                                        followController.forYouData.value =
                                            (await followController
                                                .getForYouData(context))!;
                                        cx.showBottomSheet.value = widget.isFromProfile?false:true;
                                      });
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    alignment: Alignment.center,
                                    child: const InterText(
                                      text: 'See More',
                                      color: AppColors.primaryColor,
                                      textAlign: TextAlign.center,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            }
                          ],
                        ),
                      );
                    }),
                    widget.isFromProfile
                        ? const HeightBox(25)
                        : const HeightBox(89),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget personCard() {
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
                  const InterText(
                    text: 'Ralph Edwards',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    textAlign: TextAlign.center,
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
          const WidthBox(12),
        ],
      ),
    );
  }
}
