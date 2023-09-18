import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';

import '../../controller/homeController/homeController.dart';
import '../../services/api_call.dart';
import '../../utils/commonCard.dart';
import '../../utils/commonEmptyScreenMessage.dart';
import '../../utils/customLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';
import 'billDetailsScreen.dart';

class FilterDataScreen extends StatefulWidget {
  final String metaData;

  const FilterDataScreen({this.metaData = '', super.key});

  @override
  State<FilterDataScreen> createState() => _FilterDataScreenState();
}

class _FilterDataScreenState extends State<FilterDataScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getFilteredDataAPI(context, widget.metaData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () {
            // toPushNavigator(
            //     context: context, pageName: const BillDetailsScreen());
          },
          child: Padding(
            padding: defaultScreenPadding(),
            child: Column(
              children: [
                customAppBar(
                  title: 'Filtered Data',
                  isSuffix: false,
                  context: context,
                ),
                const HeightBox(20),
                Obx(
                  () => homeController.isFilterLoading.value
                      ? const CustomLoader()
                      : homeController.filteredDataList.isEmpty
                          ? const EmptyScreenMessage(message: "No Filtered Data Found",)
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Resp.size(4)),
                                itemCount:
                                    homeController.filteredDataList.length,
                                itemBuilder: (context, index) {
                                  var item =
                                      homeController.filteredDataList[index];
                                  return InkWell(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    onTap: () {
                                      cx.showBottomSheet.value = false;
                                      toPushNavigator(
                                          context: context,
                                          onBack: (_) {
                                            cx.showBottomSheet.value = true;
                                            homeController.getFilteredDataAPI(
                                                context, widget.metaData);
                                          },
                                          pageName: BillDetailsScreen(
                                            item: item,
                                          ));
                                    },
                                    child: homeCard(
                                        context, item, homeController, index,
                                        () {
                                      setState(() {
                                        item.isFollow =
                                            (!(item.isFollow ?? false));
                                        TaskProvider().followAPI(
                                            item.id.toString(),
                                            item.isFollow ?? false ? '1' : '0',
                                            context);
                                      });
                                    }, onBackShowBottomSheet: false),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
