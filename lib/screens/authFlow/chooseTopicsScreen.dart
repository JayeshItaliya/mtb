import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/authFlow/demographicsScreen.dart';
import 'package:mtb/utils/pageNavgation.dart';

import '../../controller/authFlowController/chooseTopicController.dart';
import '../../model/authFlowModel/chooseTopicModel.dart';
import '../../utils/appColors.dart';
import '../../utils/commonButton.dart';
import '../../utils/commonCard.dart';
import '../../utils/interText.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class ChooseTopicsScreen extends StatefulWidget {
  const ChooseTopicsScreen({super.key});

  @override
  State<ChooseTopicsScreen> createState() => _ChooseTopicsScreenState();
}

class _ChooseTopicsScreenState extends State<ChooseTopicsScreen> {
  final chooseTopicController = Get.put(ChooseTopicController());

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
            (index) =>
                ChooseTopicModel(topicName: topicList[index], isFollow: false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Resp.size(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeightBox(20),
              const InterText(
                  text: "Top Issues", fontSize: 24, fontWeight: FontWeight.w600),
              const HeightBox(10),
              const Padding(
                padding: EdgeInsets.only(right: 26),
                child: InterText(
                    text: "Choose what you care about",
                    fontSize: 12,
                    textOverflow: TextOverflow.clip,
                    color: AppColors.lightGrey,
                    maxLines: 2,
                    fontWeight: FontWeight.w600),
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
                        childAspectRatio: 0.7,
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
                              topicsForYouCard(
                                  navigation: () {},
                                  isFollowing: item[index].isFollow,
                                  onTapFollow: () {
                                    setState(() {
                                      item[index].isFollow =
                                          !item[index].isFollow;
                                    });
                                    chooseTopicController.followTopic(
                                        context,
                                        item[index].topicName,
                                        item[index].isFollow ? '1' : '0');
                                  },
                                  topicName: item[index].topicName,isFromSignUp: true),
                            ],
                          ),
                        );
                      },
                    )),
              ),
              CommonButton(
                text: "Continue",
                topHeight: 30,
                onTap: () {
                  toPushNavigator(
                      context: context, pageName: const DemoGraphicsScreen());
                },
              ),
              const HeightBox(10),
            ],
          ),
        ),
      ),
    );
  }
}
