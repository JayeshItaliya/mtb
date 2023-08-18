import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/searchFilterController/searchController.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/utils.dart';

import '../../utils/commonWidgets.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/textFormFields.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = Get.put(SearchControllers());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Resp.size(20)),
          child: Column(
            children: [
              customAppBar(
                  title: 'Search',
                  context: context,
                  isSuffix: false,
                  fontSize: Resp.size(18)),
              SizedBox(
                height: Resp.size(18),
              ),
              AppWidget.getTextField(
                  hintText: "Search (H.B. 1232, Inflation, etc)",
                  preFixIcon: Image.asset(
                    'assets/searchFlow/search.png',
                    scale: 3,
                  ),onChangedFunction: (s){
                    _searchController.setSearchMode(!s.isEmpty);
              },
                  hintTextColor: AppColors.lightGrey,
                  inputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: TextEditingController()),
              SizedBox(height: Resp.size(12),),
              Obx(
                ()=> _searchController.isSearch.value?Flexible(child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
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
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    const HeightBox(10),
                                    Container(
                                      decoration: ShapeDecoration(
                                        color: AppColors.lightBlack,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Resp.size(5))),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          StatusCard('Introduced',
                                              isActive: true),
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
                                            borderRadius: BorderRadius.circular(
                                                Resp.size(5))),
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
                                    const HeightBox(10),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        index == 9 ? const HeightBox(75) : const HeightBox(12),
                      ],
                    );
                  },
                )):SizedBox(),
              ),
              Obx(
                ()=> !_searchController.isSearch.value?Flexible(
                  child: ListView.builder(
                    itemCount: 5,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(top: Resp.size(12)),
                      decoration: ShapeDecoration(
                        color: AppColors.grey.withOpacity(0.13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      padding: EdgeInsets.all(Resp.size(12)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/common/health.svg',
                            width: Resp.size(45),
                            height: Resp.size(45),
                          ),
                          InterText(
                            text: '    Healthcare Bill',
                            fontSize: Resp.size(14),
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ),
                ):SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
