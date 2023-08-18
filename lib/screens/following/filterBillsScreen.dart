import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import '../../controller/searchController/filterBillsController.dart';
import '../../mainPage.dart';
import '../../utils/utils.dart';

class FilterBillsScreen extends StatefulWidget {
  const FilterBillsScreen({super.key});

  @override
  State<FilterBillsScreen> createState() => _FilterBillsScreenState();
}

class _FilterBillsScreenState extends State<FilterBillsScreen> {
  FilterBillsController filterController = Get.put(FilterBillsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Resp.size(12)),
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
              checkBoxDropdown(0,'Topic',filterController.topicList),
              const HeightBox(12),
              checkBoxDropdown(1,'Party Affiliation',filterController.partyList),
              const HeightBox(12),
              checkBoxDropdown(2,'Proposal Date',filterController.dateList),
              const HeightBox(12),
              checkBoxDropdown(3,'Congressional Action',filterController.actionList),
              const HeightBox(12),
              checkBoxDropdown(4,'Following Status',filterController.statusList),

              const HeightBox(180),
              CommonButton(
                text: "Apply filters",
                color: AppColors.lightGrey,
                fontWeight: FontWeight.w600,
                onTap: () {
                  toPushNavigator(
                      context: context, PageName: const MainPageScreen());
                },
              ),
              const HeightBox(25),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkBoxDropdown(int i,String title,var list) {
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
          InkWell(
            onTap: (){
              if(i==filterController.dropDownIndex.value){
                filterController.dropDownIndex.value=99;
              }
              else{
                filterController.dropDownIndex.value=i;
              }
            },
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
            visible: filterController.dropDownIndex.value==i,
            child: SizedBox(
              height: cx.height/4,
              child: ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: Resp.size(20)),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
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
                                fontSize: 12,
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<FilterBillsController>();
  }
}