import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/searchController/filterTopicsController.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/pageNavgation.dart';
import 'package:mtb/utils/responsiveUi.dart';
import '../../controller/searchController/filterBillsController.dart';
import '../../mainPage.dart';
import '../../utils/utils.dart';
import '../homeFlow/filterDataScreen.dart';

class FilterTopicScreen extends StatefulWidget {
  const FilterTopicScreen({super.key});

  @override
  State<FilterTopicScreen> createState() => _FilterTopicScreenState();
}

class _FilterTopicScreenState extends State<FilterTopicScreen> {
  FilterBillsController filterController = Get.put(FilterBillsController());
  List<String> topicsList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: defaultScreenPadding(),
          child: Obx(
            () => Column(
              children: [
                customAppBar(
                  title: 'Filters',
                  showCrossBackButton: true,
                  context: context,
                  fontSize: Resp.size(18),
                  suffix: GestureDetector(
                    onTap: () {
                      if (filterController.buttonColor.value ==
                          AppColors.primaryColor) {
                        filterController.buttonColor.value =
                            AppColors.lightGrey;
                        for (var element in filterController.topicList) {
                          element[1] = 0;
                        }
                      }
                    },
                    child: filterController.buttonColor.value==AppColors.primaryColor?const InterText(
                        text: 'Reset',
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600):Container(),
                  ),
                ),
                const HeightBox(30),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      checkBoxDropdown(0, 'Topic', filterController.topicList),
                      const HeightBox(5),
                      Obx(
                        () => CommonButton(
                          text: "Apply filters",
                          color: filterController.buttonColor.value,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            if (filterController.buttonColor.value ==
                                AppColors.primaryColor) {
                              String data = '';
                              if (topicsList.isNotEmpty) {
                                data =
                                    '$data&topic_tag=${topicsList.join(',')}';
                              }
                              toPushNavigator(
                                  context: context,
                                  pageName: FilterDataScreen(metaData: data));
                            }
                          },
                        ),
                      ),
                      const HeightBox(25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> getSelectedData(List list) {
    List selectedDataArr = list.where((p0) => p0[1] == 1).toList();
    List<String> lst = List<String>.generate(selectedDataArr.length,
        (index) => selectedDataArr[index][0].toString()).toList();
    return lst;
  }

  Widget checkBoxDropdown(int i, String title, var list) {
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
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              if (i == filterController.dropDownIndex.value) {
                filterController.dropDownIndex.value = 99;
              } else {
                filterController.dropDownIndex.value = i;
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Resp.size(15),
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                !(filterController.dropDownIndex.value == i)
                    ? Image.asset("assets/common/dropDown.png", scale: 3)
                    : Image.asset("assets/common/dropUp.png", scale: 3),
              ],
            ),
          ),
          Visibility(
            visible: filterController.dropDownIndex.value == i,
            child: SizedBox(
              height: cx.height / 4,
              child: ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: Resp.size(25)),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          if (list[index][1] == 0) {
                            list[index][1] = 1;
                          } else {
                            list[index][1] = 0;
                          }
                          topicsList =
                              getSelectedData(filterController.topicList);

                          filterController.buttonColor.value = getColor();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InterText(
                                text: list[index][0],
                                fontSize: 12,
                                color: Colors.white,
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
                        visible: index != list.length - 1,
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

  Color getColor() {
    if (topicsList.isEmpty) {
      return AppColors.lightGrey;
    }
    return AppColors.primaryColor;
  }
}
