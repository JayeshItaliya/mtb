import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/services/api_call.dart';

import '../../controller/homeController/homeController.dart';
import '../../model/homeFlowModel/billListModel.dart';
import '../../utils/commonCard.dart';
import '../../utils/commonEmptyScreenMessage.dart';
import '../../utils/customLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';
import '../following/filterBillsScreen.dart';
import 'billDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeController.getBillDataAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: defaultScreenPadding(),
        child: Column(
          children: [
            customAppBar(
                title: 'User’s Legislative Feed',
                isPrefix: false,
                context: context,
                onTapSuffix: () {
                  cx.showBottomSheet.value = false;
                  toPushNavigator(
                      context: context,
                      onBack: (_) {
                        cx.showBottomSheet.value = true;
                        homeController.getBillDataAPI(context);
                      },
                      pageName: const FilterBillsScreen());
                }),
            const HeightBox(20),
            Obx(
              () => homeController.isLoading.value
                  ? const CustomLoader()
                  : homeController.billDataList.isEmpty
                      ? const EmptyScreenMessage(
                          message: "No Bills Found",
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            padding:
                                EdgeInsets.symmetric(horizontal: Resp.size(4)),
                            itemCount: homeController.billDataList.length,
                            itemBuilder: (context, index) {
                              BillListModel item =
                                  homeController.billDataList[index];
                              return InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  cx.showBottomSheet.value = false;
                                  toPushNavigator(
                                      context: context,
                                      onBack: (_) {
                                        cx.showBottomSheet.value = true;
                                        homeController.getBillDataAPI(context);
                                      },
                                      pageName: BillDetailsScreen(
                                        item: item,
                                      ));
                                },
                                child: homeCard(
                                    context, item, homeController, index, () {
                                  setState(() {
                                    item.isFollow = (!(item.isFollow ?? false));
                                    TaskProvider().followAPI(
                                        item.id.toString(),
                                        item.isFollow ?? false ? '1' : '0',
                                        context);
                                  });
                                }),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
