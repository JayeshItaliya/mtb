import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/utils.dart';
import '../../controller/searchController/searchController.dart';
import '../../services/api_call.dart';
import '../../utils/commonCard.dart';
import '../../utils/commonEmptyScreenMessage.dart';
import '../../utils/customLoader.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/textFormFields.dart';
import '../homeFlow/billDetailsScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchControllers searchScreenController = Get.put(SearchControllers());
  Timer? _debounce;

  @override
  void initState() {
    searchScreenController.billDataList.value = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllers>(
        init: Get.put(SearchControllers()),
        builder: (controller) {
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
                      title: 'Search',
                      context: context,
                      isSuffix: false,
                      isPrefix: false,
                    ),
                    const HeightBox(18),
                    SizedBox(
                      height: Resp.size(52),
                      child: Obx(
                        () => AppWidget.getTextField(
                            hintText: "Search (H.B. 1232, Inflation, etc)",
                            preFixIcon: Image.asset(
                              'assets/searchFilter/search.png',
                              scale: 3,
                            ),
                            onChangedFunction: (s) {
                              if (_debounce?.isActive ?? false) {
                                _debounce?.cancel();
                              }
                              _debounce = Timer(
                                  const Duration(milliseconds: 500), () async {
                                searchScreenController.billDataList.value = [];
                                if (s != null && s.toString().isNotEmpty) {
                                  searchScreenController
                                      .setSearchMode(!s.isEmpty);
                                  await searchScreenController
                                      .getSearchedBillDataAPI(
                                          context, s.toString())
                                      .then((value) {
                                    searchScreenController.update();
                                  });
                                }
                              });
                            },
                            suffixIcon: searchScreenController
                                    .searchbarController.value.text.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      searchScreenController
                                          .searchbarController.value.clear();
                                      searchScreenController.billDataList.value = [];
                                      searchScreenController.update();
                                    },
                                    child: Image.asset(
                                      'assets/searchFlow/close.png',
                                      scale: Resp.size(2.7),
                                    ),
                                  )
                                : const SizedBox(width: 1, height: 1),
                            maxLength: 25,
                            hintTextColor: AppColors.lightGrey,
                            inputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            textEditingController: searchScreenController
                                .searchbarController.value),
                      ),
                    ),
                    const HeightBox(12),
                    Obx(
                      () => searchScreenController.isLoading.value
                          ? const CustomLoader()
                          : searchScreenController.isSearch.value
                              ? Flexible(
                                  child: ListView.builder(
                                  itemCount: searchScreenController
                                      .billDataList.length,
                                  itemBuilder: (context, index) {
                                    var item = searchScreenController
                                        .billDataList[index];
                                    return InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      onTap: () {
                                        cx.showBottomSheet.value = false;
                                        toPushNavigator(
                                            context: context,
                                            onBack: (_) {
                                              cx.showBottomSheet.value = true;
                                              searchScreenController
                                                  .setSearchMode(
                                                      searchScreenController
                                                          .searchbarController
                                                          .value
                                                          .text
                                                          .isNotEmpty);
                                              searchScreenController
                                                  .getSearchedBillDataAPI(
                                                context,
                                                searchScreenController
                                                    .searchbarController
                                                    .value
                                                    .text
                                                    .toString(),
                                              );
                                              FocusScopeNode currentFocus =
                                                  FocusScope.of(context);
                                              if (!currentFocus.hasPrimaryFocus)
                                                currentFocus.unfocus();
                                            },
                                            pageName: BillDetailsScreen(
                                              item: item,
                                            ));
                                      },
                                      child: homeCard(context, item,
                                          searchScreenController, index, () {
                                        setState(() {
                                          item.isFollow =
                                              (!(item.isFollow ?? false));
                                          TaskProvider().followAPI(
                                              item.id.toString(),
                                              item.isFollow ?? false
                                                  ? '1'
                                                  : '0',
                                              context);
                                        });
                                      }),
                                    );
                                  },
                                ))
                              : const SizedBox(),
                    ),
                    const HeightBox(30)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
