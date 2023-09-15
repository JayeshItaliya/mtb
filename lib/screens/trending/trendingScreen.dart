import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mtb/model/homeFlowModel/billListModel.dart';
import 'package:mtb/screens/trending/topicsForYou.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/trendingController/trendingController.dart';
import '../../model/trendingModel/ForYouModel.dart';
import '../../model/trendingModel/TopIssuesModel.dart';
import '../../model/trendingModel/topTrendingBillsModel.dart';
import '../../services/api_call.dart';
import '../../utils/customLoader.dart';
import '../../utils/follow.dart';
import '../../utils/following.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';
import '../homeFlow/billDetailsScreen.dart';
import '../homeFlow/filterDataScreen.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  CarouselController buttonCarouselController = CarouselController();
  TrendingController trendingController = Get.put(TrendingController());
  int i = 0;
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

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!trendingController.isForYouLoading.value) {
        getData();
      }
    });
    super.initState();
  }

  getData() async {
    trendingController.billData.value =
        (await trendingController.getTrendingBillData(context))!;
    trendingController.topIssuesData.value =
        (await trendingController.getTopIssuesData(context))!;
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
                          title: 'Trending',
                          isPrefix: false,
                          isSuffix: false,
                          context: context),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CarouselSlider.builder(
                            itemCount: 6,
                            carouselController: buttonCarouselController,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                Image.asset('assets/common/slider_img.png'),
                            options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                onPageChanged: (index, reason) {
                                  trendingController.index.value = index;
                                },
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 2),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                                padEnds: false),
                          ),
                          Obx(
                            () => SmoothPageIndicator(
                              controller: PageController(
                                  initialPage: trendingController.index.value),
                              count: 6,
                              effect: ExpandingDotsEffect(
                                dotColor: AppColors.grey.withOpacity(0.35),
                                activeDotColor: Colors.white,
                                dotWidth: Resp.size(8),
                                dotHeight: Resp.size(8),
                              ),
                            ),
                          )
                        ],
                      ),
                      const HeightBox(20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const InterText(
                          text: 'Congress Response',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const HeightBox(12),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: Resp.size(76),
                              // width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                // padding: EdgeInsets.symmetric(horizontal: Resp.size(4)),
                                scrollDirection: Axis.horizontal,
                                itemCount: 15,

                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      width: Resp.size(350),
                                      // height: Resp.size(69),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            Resp.size(10),
                                          ),
                                          color: AppColors.lightBlack),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Resp.size(12)),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: SvgPicture.asset(
                                              'assets/common/health.svg',
                                              width: Resp.size(45),
                                              height: Resp.size(45),
                                            ),
                                            title: const InterText(
                                              text: 'Healthcare Bill',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                            subtitle: InterText(
                                              text: 'Proposed on 12/04/2023',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                            trailing: SvgPicture.asset(
                                              'assets/homeFlow/followBill.svg',
                                              width: Resp.size(69),
                                              height: Resp.size(31),
                                            ),
                                            dense: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          const HeightBox(12)
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const HeightBox(12),
                            Obx(()=>
                            trendingController.isForYouLoading.value ||
                                  trendingController.isTopIssueLoading.value ||
                                  trendingController.isTrendingLoading.value
                                  ? const CustomLoader(topHeight: 20,)
                                  : Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Container(
                                            padding: EdgeInsets.all(
                                              Resp.size(12),
                                            ),
                                            decoration: ShapeDecoration(
                                              color: AppColors.lightBlack,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    Resp.size(10)),
                                              ),
                                            ),
                                            child: Obx(() {
                                              TopTrendingBillsModel item =
                                                  trendingController.billData.value;
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const InterText(
                                                    text: 'Top Bills',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                  const HeightBox(12),
                                                  InkWell(
                                                    onTap: () {
                                                      cx.showBottomSheet.value =
                                                          false;
                                                      toPushNavigator(
                                                          context: context,
                                                          onBack: (_) async {
                                                            cx.showBottomSheet.value =
                                                                true;
                                                            trendingController
                                                                    .billData.value =
                                                                (await trendingController
                                                                    .getTrendingBillData(
                                                                        context))!;
                                                          },
                                                          pageName: BillDetailsScreen(
                                                              item: item.newBill ??
                                                                  BillListModel()));
                                                    },
                                                    child: Column(
                                                      children: [
                                                        const HeightBox(12),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                cx.showBottomSheet
                                                                    .value = false;
                                                                toPushNavigator(
                                                                    context: context,
                                                                    onBack: (value) {
                                                                      cx.showBottomSheet
                                                                              .value =
                                                                          true;
                                                                    },
                                                                    pageName:
                                                                        FilterDataScreen(
                                                                            metaData:
                                                                                "&topic_tag=${item.newBill?.topicSimplified.toString() ?? ""}"));
                                                              },
                                                              child: SvgPicture.asset(
                                                                getTopicImage(item
                                                                        .newBill
                                                                        ?.topicSimplified
                                                                        .toString() ??
                                                                    ""),
                                                                width: Resp.size(45),
                                                                height: Resp.size(45),
                                                              ),
                                                            ),
                                                            const WidthBox(10),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  InterText(
                                                                    text: item.newBill
                                                                            ?.billName ??
                                                                        "",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: 14,
                                                                  ),
                                                                  const HeightBox(2),
                                                                  InterText(
                                                                    text:
                                                                        'Proposed on ${item.newBill?.proposedDate ?? ""}',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: 12,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const HeightBox(10),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Resp.size(69),
                                                              height: Resp.size(31),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: AppColors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3)),
                                                              alignment:
                                                                  Alignment.center,
                                                              child: const InterText(
                                                                text: 'Proposed',
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                              ),
                                                            ),
                                                            const WidthBox(10),
                                                            InkWell(
                                                              child: (item.newBill
                                                                          ?.isFollow ??
                                                                      false)
                                                                  ? followingBill(
                                                                      width: 69,
                                                                    )
                                                                  : followBill(
                                                                      width: 69,
                                                                    ),
                                                              onTap: () {
                                                                setState(() {
                                                                  item.newBill
                                                                      ?.isFollow = (!(item
                                                                          .newBill
                                                                          ?.isFollow ??
                                                                      false));
                                                                  TaskProvider().followAPI(
                                                                      item.newBill?.id
                                                                              .toString() ??
                                                                          "",
                                                                      item.newBill?.isFollow ??
                                                                              false
                                                                          ? '1'
                                                                          : '0',
                                                                      context);
                                                                });
                                                              },
                                                            ),
                                                            const WidthBox(12),
                                                            SvgPicture.asset(
                                                              'assets/trending/trendingUp.svg',
                                                              width: Resp.size(32),
                                                              height: Resp.size(32),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const HeightBox(15),
                                                  InkWell(
                                                    onTap: () {
                                                      cx.showBottomSheet.value =
                                                          false;
                                                      toPushNavigator(
                                                          context: context,
                                                          onBack: (_) {
                                                            cx.showBottomSheet.value =
                                                                true;
                                                          },
                                                          pageName: BillDetailsScreen(
                                                              item: item.newBill ??
                                                                  BillListModel()));
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/common/immigration.svg',
                                                              width: Resp.size(45),
                                                              height: Resp.size(45),
                                                            ),
                                                            const WidthBox(10),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  InterText(
                                                                    text: item.oldBill
                                                                            ?.billName ??
                                                                        "",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: 14,
                                                                    maxLines: 1,
                                                                    textOverflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  const HeightBox(2),
                                                                  InterText(
                                                                    text:
                                                                        'Proposed on ${item.oldBill?.proposedDate ?? ""}',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    maxLines: 1,
                                                                    fontSize: 12,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const HeightBox(10),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: Resp.size(69),
                                                              height: Resp.size(31),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              Resp.size(
                                                                                  5)),
                                                                  color: AppColors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3)),
                                                              alignment:
                                                                  Alignment.center,
                                                              child: const InterText(
                                                                text: 'Proposed',
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                              ),
                                                            ),
                                                            const WidthBox(10),
                                                            InkWell(
                                                              child: (item.oldBill
                                                                          ?.isFollow ??
                                                                      false)
                                                                  ? followingBill(
                                                                      width: 69,
                                                                    )
                                                                  : followBill(
                                                                      width: 69,
                                                                    ),
                                                              onTap: () {
                                                                setState(() {
                                                                  item.oldBill
                                                                      ?.isFollow = (!(item
                                                                          .oldBill
                                                                          ?.isFollow ??
                                                                      false));
                                                                  TaskProvider().followAPI(
                                                                      item.oldBill?.id
                                                                              .toString() ??
                                                                          "",
                                                                      item.oldBill?.isFollow ??
                                                                              false
                                                                          ? '1'
                                                                          : '0',
                                                                      context);
                                                                });
                                                              },
                                                            ),
                                                            const WidthBox(12),
                                                            SvgPicture.asset(
                                                              'assets/trending/trendingDown.svg',
                                                              width: Resp.size(32),
                                                              height: Resp.size(32),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child: Obx(() {
                                          TopIssuesModel data =
                                              trendingController.topIssuesData.value;
                                          data.topissues = data.topissues ?? '';
                                          data.secondaryTopIssues =
                                              data.secondaryTopIssues ?? '';
                                          data.bottomIssue = data.bottomIssue ?? '';
                                          return Container(
                                            height: Resp.size(250),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Resp.size(8),
                                              vertical: Resp.size(12),
                                            ),
                                            decoration: ShapeDecoration(
                                              color: AppColors.lightBlack,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    Resp.size(10)),
                                              ),
                                            ),
                                            child: data.topissues!.isNotEmpty &&
                                                    data.secondaryTopIssues!
                                                        .isNotEmpty &&
                                                    data.bottomIssue!.isNotEmpty
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      const InterText(
                                                        text: 'Top Issues',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                      Column(
                                                        children: [
                                                          if (data.topissues!
                                                              .isNotEmpty) ...{
                                                            const HeightBox(12),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    cx.showBottomSheet
                                                                            .value =
                                                                        false;
                                                                    toPushNavigator(
                                                                        context:
                                                                            context,
                                                                        onBack:
                                                                            (value) {
                                                                          cx.showBottomSheet
                                                                                  .value =
                                                                              true;
                                                                        },
                                                                        pageName: FilterDataScreen(
                                                                            metaData:
                                                                                "&topic_tag=${data.topissues?[0] ?? ''}"));
                                                                  },
                                                                  child: SvgPicture
                                                                      .asset(
                                                                    getTopicImage(
                                                                        data.topissues?[
                                                                                0] ??
                                                                            ''),
                                                                    width:
                                                                        Resp.size(45),
                                                                    height:
                                                                        Resp.size(45),
                                                                  ),
                                                                ),
                                                                const WidthBox(13),
                                                                SvgPicture.asset(
                                                                  'assets/trending/trendingUp.svg',
                                                                  width:
                                                                      Resp.size(32),
                                                                  height:
                                                                      Resp.size(32),
                                                                ),
                                                              ],
                                                            ),
                                                          },
                                                          if (data.secondaryTopIssues!
                                                              .isNotEmpty) ...{
                                                            const HeightBox(23),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    cx.showBottomSheet
                                                                            .value =
                                                                        false;
                                                                    toPushNavigator(
                                                                        context:
                                                                            context,
                                                                        onBack:
                                                                            (value) {
                                                                          cx.showBottomSheet
                                                                                  .value =
                                                                              true;
                                                                        },
                                                                        pageName: FilterDataScreen(
                                                                            metaData:
                                                                                "&topic_tag=${data.secondaryTopIssues?[0] ?? ''}"));
                                                                  },
                                                                  child: SvgPicture
                                                                      .asset(
                                                                    getTopicImage(
                                                                        data.secondaryTopIssues?[
                                                                                0] ??
                                                                            ''),
                                                                    width:
                                                                        Resp.size(45),
                                                                    height:
                                                                        Resp.size(45),
                                                                  ),
                                                                ),
                                                                const WidthBox(13),
                                                                SvgPicture.asset(
                                                                  'assets/trending/trendingDown.svg',
                                                                  width:
                                                                      Resp.size(32),
                                                                  height:
                                                                      Resp.size(32),
                                                                ),
                                                              ],
                                                            ),
                                                          },
                                                          if (data.bottomIssue!
                                                              .isNotEmpty) ...{
                                                            const HeightBox(23),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    cx.showBottomSheet
                                                                            .value =
                                                                        false;
                                                                    toPushNavigator(
                                                                        context:
                                                                            context,
                                                                        onBack:
                                                                            (value) {
                                                                          cx.showBottomSheet
                                                                                  .value =
                                                                              true;
                                                                        },
                                                                        pageName: FilterDataScreen(
                                                                            metaData:
                                                                                "&topic_tag=${data.bottomIssue?[0] ?? ''}"));
                                                                  },
                                                                  child: SvgPicture
                                                                      .asset(
                                                                    getTopicImage(
                                                                        data.bottomIssue?[
                                                                                0] ??
                                                                            ''),
                                                                    width:
                                                                        Resp.size(45),
                                                                    height:
                                                                        Resp.size(45),
                                                                  ),
                                                                ),
                                                                const WidthBox(13),
                                                                SvgPicture.asset(
                                                                  'assets/trending/trendingUp.svg',
                                                                  width:
                                                                      Resp.size(32),
                                                                  height:
                                                                      Resp.size(32),
                                                                ),
                                                              ],
                                                            ),
                                                          }
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : const Center(
                                                    child: InterText(
                                                      text: 'No Top Issues',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  const HeightBox(12),
                                  Container(
                                    padding: EdgeInsets.all(
                                      Resp.size(12),
                                    ),
                                    decoration: ShapeDecoration(
                                      color: AppColors.lightBlack,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(Resp.size(10)),
                                      ),
                                    ),
                                    child: Obx(() {
                                      ForYouModel model =
                                          trendingController.forYouData.value;
                                      model.isFollow = [];
                                      if (model.topicTags != null &&
                                          model.topicTags!.isNotEmpty) {
                                        for (String s in topicList) {
                                          if (!model.topicTags!.contains(s)) {
                                            model.topicTags!.add(s);
                                            model.isFollow!.add(false);
                                          } else {
                                            model.isFollow!.add(true);
                                          }
                                        }
                                        customPrint("topics::$model");
                                      } else {
                                        model.topicTags = [];
                                        for (String s in topicList) {
                                          if (!model.topicTags!.contains(s)) {
                                            model.topicTags!.add(s);
                                            model.isFollow!.add(false);
                                          }
                                        }
                                      }
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const InterText(
                                                text: 'For You',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              InkWell(
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                onTap: () {
                                                  cx.showBottomSheet.value = false;
                                                  toPushNavigator(
                                                      context: context,
                                                      onBack: (_) async {
                                                        trendingController
                                                                .forYouData.value =
                                                            (await trendingController
                                                                .getForYouData(
                                                                    context))!;
                                                        cx.showBottomSheet.value =
                                                            true;
                                                      },
                                                      pageName: TopicsForYou(model));
                                                },
                                                child: const InterText(
                                                  text: 'See More',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const HeightBox(12),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics: const ClampingScrollPhysics(),
                                            itemCount: model.topicTags == null ||
                                                    model.topicTags!.isEmpty
                                                ? 0
                                                : model.topicTags!.length >= 5
                                                    ? 5
                                                    : model.topicTags!.length,
                                            itemBuilder: (context, index) => InkWell(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 15, bottom: 5),
                                                child: SvgPicture.asset(
                                                  getTopicImage(
                                                      model.topicTags?[index] ?? ''),
                                                  width: Resp.size(45),
                                                  height: Resp.size(45),
                                                ),
                                              ),
                                              onTap: () {
                                                cx.showBottomSheet.value = false;
                                                toPushNavigator(
                                                    context: context,
                                                    onBack: (value) {
                                                      cx.showBottomSheet.value = true;
                                                    },
                                                    pageName: FilterDataScreen(
                                                        metaData:
                                                            "&topic_tag=${model.topicTags?[index] ?? ''}"));
                                              },
                                            ),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 5,
                                                    childAspectRatio: 1.2),
                                          )
                                        ],
                                      );
                                    }),
                                  ),
                                  const HeightBox(90),
                                ],
                              ),
                            ),
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

  Widget commonContainer(String text, {bool isTag = true}) {
    return Container(
      decoration: ShapeDecoration(
        color: isTag ? AppColors.purple : AppColors.darkBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Resp.size(5))),
      ),
      padding: EdgeInsets.symmetric(
          vertical: Resp.size(10), horizontal: Resp.size(8)),
      child: InterText(
        text: text,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
