import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mtb/screens/trending/topicsForYou.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controller/trendingController/trendingController.dart';
import '../../utils/follow.dart';
import '../../utils/following.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';
import '../homeFlow/billDetailsScreen.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  CarouselController buttonCarouselController = CarouselController();
  TrendingController cx = Get.put(TrendingController());
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          toPushNavigator(
              context: context, pageName: const BillDetailsScreen());
        },
        child: Column(
          children: [
            const HeightBox(15),
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
                        cx.index.value = index;
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
                    controller: PageController(initialPage: cx.index.value),
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
                            padding:
                                EdgeInsets.symmetric(horizontal: Resp.size(12)),
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
                                const HeightBox(12)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const HeightBox(12),
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
                                borderRadius:
                                    BorderRadius.circular(Resp.size(10)),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const InterText(
                                      text: 'Top Bills',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    const HeightBox(12),
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
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const InterText(
                                              text: 'Immigration Bill',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                            const HeightBox(2),
                                            InterText(
                                              text: 'Proposed on 12/04/2023',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            )
                                          ],
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
                                                  BorderRadius.circular(
                                                      Resp.size(5)),
                                              color: AppColors.grey
                                                  .withOpacity(0.3)),
                                          alignment: Alignment.center,
                                          child: const InterText(
                                            text: 'Proposed',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const WidthBox(10),
                                        InkWell(
                                            onTap: () {

                                            },
                                            child: followBill()),
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
                                const HeightBox(15),
                                Column(
                                  children: [
                                    const HeightBox(12),
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
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const InterText(
                                              text: 'Immigration Bill',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                            const HeightBox(2),
                                            InterText(
                                              text: 'Proposed on 12/04/2023',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            )
                                          ],
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
                                                  BorderRadius.circular(5),
                                              color: AppColors.grey
                                                  .withOpacity(0.3)),
                                          alignment: Alignment.center,
                                          child: const InterText(
                                            text: 'Proposed',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const WidthBox(10),
                                        followingBill(),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const InterText(
                                text: 'Top Issues',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              const HeightBox(12),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/common/health.svg',
                                    width: Resp.size(45),
                                    height: Resp.size(45),
                                  ),
                                  const WidthBox(20),
                                  SvgPicture.asset(
                                    'assets/trending/trendingUp.svg',
                                    width: Resp.size(32),
                                    height: Resp.size(32),
                                  ),
                                ],
                              ),
                              const HeightBox(23),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/common/health.svg',
                                    width: Resp.size(45),
                                    height: Resp.size(45),
                                  ),
                                  const WidthBox(20),
                                  SvgPicture.asset(
                                    'assets/trending/trendingDown.svg',
                                    width: Resp.size(32),
                                    height: Resp.size(32),
                                  ),
                                ],
                              ),
                              const HeightBox(23),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/common/health.svg',
                                    width: Resp.size(45),
                                    height: Resp.size(45),
                                  ),
                                  const WidthBox(20),
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
                        borderRadius: BorderRadius.circular(Resp.size(10)),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const InterText(
                              text: 'For You',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                toPushNavigator(
                                    context: context,
                                    pageName: const TopicsForYou());
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/common/health.svg',
                              width: Resp.size(45),
                              height: Resp.size(45),
                            ),
                            SvgPicture.asset(
                              'assets/common/taxes.svg',
                              width: Resp.size(45),
                              height: Resp.size(45),
                            ),
                            SvgPicture.asset(
                              'assets/common/tech.svg',
                              width: Resp.size(45),
                              height: Resp.size(45),
                            ),
                            SvgPicture.asset(
                              'assets/common/welfare.svg',
                              width: Resp.size(45),
                              height: Resp.size(45),
                            ),
                            SvgPicture.asset(
                              'assets/common/environment.svg',
                              width: Resp.size(45),
                              height: Resp.size(45),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const HeightBox(75),
                ],
              ),
            ),
          ],
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
