import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/authFlowController/demographicsController.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/dropDown.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';

import '../../controller/searchFilterController/filterController.dart';
import '../../mainPage.dart';
import '../../utils/utils.dart';
import '../homeFlow/homeScreen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Resp.size(15)),
        child: Obx(
          ()=> ListView(
            shrinkWrap: true,
            // physics: ClampingScrollPhysics(),
            children: [
              const HeightBox(30),
              customAppBar(
                  title: 'Filters',
                  showCrossBackButton: true,
                  context: context,
                  fontSize: Resp.size(18),
                  isSuffix: false),
              const HeightBox(30),
              checkBoxDropdown(0,'Title',_filterController.topicList),
              SizedBox(
                height: Resp.size(12),
              ),
              checkBoxDropdown(1,'Party Affiliation',_filterController.partyList),
              SizedBox(
                height: Resp.size(12),
              ),
              checkBoxDropdown(2,'Proposal Date',_filterController.dateList),
              SizedBox(
                height: Resp.size(12),
              ),
              checkBoxDropdown(3,'Congressional Action',_filterController.actionList),
              SizedBox(
                height: Resp.size(12),
              ),
              checkBoxDropdown(4,'Following Status',_filterController.statusList),


              SizedBox(
                height: Resp.size(180),
              ),
              CommonButton(
                text: "Apply filters",
                color: AppColors.lightGrey,
                fontWeight: FontWeight.w600,
                onTap: () {
                  toPushNavigator(
                      context: context, PageName: const MainPageScreen());
                },
              ),
              HeightBox(
                Resp.size(25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkBoxDropdown(int i,String title,List list) {
    return Container(
      padding: EdgeInsets.all(Resp.size(12)),
      decoration: ShapeDecoration(
        color: AppColors.lightBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Resp.size(10)),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()=>_filterController.i=i,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Resp.size(14),
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Image.asset("assets/common/dropDown.png", scale: 3),
              ],
            ),
          ),
          Visibility(
            visible: _filterController.i==i,
            child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: Resp.size(15)),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (list[index][1] == 0) {
                          list[index][1] = 1;
                        } else {
                          list[index][1] = 0;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InterText(
                              text: list[index][0],
                              fontSize: Resp.size(12),
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Obx(
                            () => Image.asset(
                              "assets/authFlow/${list[index][1] == 1 ? "check" : "unCheck"}.png",
                              scale: 3.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: index!=list.length-1,
                      child: Container(
                        height: 1,
                        margin: EdgeInsets.symmetric(vertical: Resp.size(15)),
                        color: AppColors.grey,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<FilterController>();
  }
}
