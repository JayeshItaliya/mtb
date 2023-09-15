import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/chooseTopicController.dart';
import 'package:mtb/screens/following/filterTopicScreen.dart';

import '../../controller/trendingController/trendingController.dart';
import '../../model/authFlowModel/chooseTopicModel.dart';
import '../../model/trendingModel/ForYouModel.dart';
import '../../utils/appColors.dart';
import '../../utils/commonCard.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class TopicsForYou extends StatefulWidget {
  ForYouModel model;

  TopicsForYou(this.model, {super.key});

  @override
  State<TopicsForYou> createState() => _TopicsForYouState();
}

class _TopicsForYouState extends State<TopicsForYou> {
  TrendingController trendingController = Get.put(TrendingController());
  ChooseTopicController chooseTopicController =
      Get.put(ChooseTopicController());
  List<String> topicList = [
    "Agriculture",
    "Army",
    "Civil Rights",
    "Policing",
    "Economics",
    "Education",
    "Immigration",
    "Environment & Energy",
    "Government",
    "Welfare",
    "Labor",
    "Tech",
    "Taxes",
    "Health",
    "IR",
    "Infrastructure",
    "Miscellaneous",
  ];
  List<ChooseTopicModel> item = [];

  @override
  void initState() {
    super.initState();

    item = List<ChooseTopicModel>.generate(
        topicList.length,
        (index) => ChooseTopicModel(
            topicName: topicList[index],
            isFollow: widget.model.isFollow![index])).toList();
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
                  title: 'Topics For You',
                  context: context,
                onTapSuffix: (){
                  toPushNavigator(
                      context: context,
                      onBack: (_) async {
                        trendingController
                            .forYouData.value =
                        (await trendingController
                            .getForYouData(context))!;
                        },
                      pageName: const FilterTopicScreen());
                }
              ),
              const HeightBox(20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    Resp.size(0),
                    Resp.size(12),
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
                    itemCount: item.length,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // maxCrossAxisExtent: 200,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      //
                      // for (String topic in topicList) {
                      //   if (!data.topicTags!.contains(topic)) {
                      //     data.topicTags!.add(topic);
                      //   }
                      // }
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
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            topicsForYouCard(
                                navigation: () {},
                                isFollowing: item[index].isFollow,
                                onTapFollow: () {
                                  setState(() {
                                    item[index].isFollow =
                                    !item[index].isFollow;
                                    // data.topicTags!.add(item[index].topicName);
                                  });
                                  chooseTopicController.followTopic(
                                      context,
                                      item[index].topicName,
                                      item[index].isFollow ? '1' : '0');
                                },
                                topicName: item[index].topicName),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.fromLTRB(
              //       Resp.size(0),
              //       Resp.size(12),
              //       Resp.size(12),
              //       Resp.size(0),
              //     ),
              //     // margin: EdgeInsets.only(bottom: Resp.size(25),),
              //     decoration: ShapeDecoration(
              //       color: AppColors.lightBlack,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(Resp.size(10)),
              //       ),
              //     ),
              //     child: Obx(() {
              //       ForYouModel item = trendingController.forYouData.value;
              //       int size =
              //           trendingController.forYouData.value.topicTags?.length ??
              //               0;
              //       for (String s in topicList) {
              //         if (!item.topicTags!.contains(s)) {
              //           item.topicTags!.add(s);
              //         }
              //       }
              //       return GridView.builder(
              //         shrinkWrap: true,
              //         itemCount: item.topicTags?.length ?? 0,
              //         physics: const ClampingScrollPhysics(),
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 3,
              //           // maxCrossAxisExtent: 200,
              //           crossAxisSpacing: 0,
              //           mainAxisSpacing: 0,
              //           childAspectRatio: 0.9,
              //         ),
              //         itemBuilder: (BuildContext context, int index) {
              //           return Container(
              //             padding: EdgeInsets.fromLTRB(
              //               Resp.size(12),
              //               Resp.size(0),
              //               Resp.size(0),
              //               Resp.size(12),
              //             ),
              //             decoration: ShapeDecoration(
              //               color: AppColors.lightBlack,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(Resp.size(10)),
              //               ),
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 topicsForYouCard(
              //                     navigation: () {
              //                       // Get.to(const TrendingScreen());
              //                     },
              //                     isFollowing: index <= size - 1,
              //                     onTapFollow: () {
              //
              //                       setState(() {
              //                         item.isFollow = !(item.isFollow??false);
              //                       });
              //                       chooseTopicController.followTopic(
              //                           context,
              //                           item.topicTags?[index]??"",
              //                           (item.isFollow??false) ? '1' : '0');
              //                     },
              //                     name: item.topicTags != null &&
              //                             item.topicTags!.isNotEmpty
              //                         ? item.topicTags![index]
              //                         : ''),
              //               ],
              //             ),
              //           );
              //         },
              //       );
              //     }),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
