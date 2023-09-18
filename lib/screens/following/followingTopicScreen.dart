import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/authFlowController/chooseTopicController.dart';
import '../../model/trendingModel/ForYouModel.dart';
import '../../utils/appColors.dart';
import '../../utils/commonCard.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class FollowingTopic extends StatefulWidget {
  final ForYouModel item;

  const FollowingTopic({super.key, required this.item});

  @override
  State<FollowingTopic> createState() => _FollowingTopicState();
}

class _FollowingTopicState extends State<FollowingTopic> {
  ChooseTopicController chooseTopicController =
      Get.put(ChooseTopicController());

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
                  title: 'Following Topics', isSuffix: false, context: context),
              const HeightBox(20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    Resp.size(6),
                    Resp.size(12),
                    Resp.size(6),
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
                    itemCount: widget.item.topicTags?.length ?? 0,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // maxCrossAxisExtent: 200,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(
                          Resp.size(4),
                          Resp.size(0),
                          Resp.size(0),
                          Resp.size(10),
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
                            topicsCardFollowing(
                                widget.item.topicTags?[index] ?? "", () {
                              chooseTopicController.followTopic(
                                  context, widget.item.topicTags![index], '0');
                              setState(() {
                                widget.item.topicTags?.removeAt(index);
                                widget.item.isFollow?.removeAt(index);
                              });
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
