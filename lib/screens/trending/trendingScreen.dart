import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtb/screens/trending/topicsForYou.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () {
          toPushNavigator(
              context: context, PageName: const BillDetailsScreen());
        },
        child: Column(
          children: [
            const HeightBox(15),
            customAppBar(
                title: 'Trending',
                isPrefix: false,
                isSuffix: false,
                context: context),
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
                                index == 9
                                    ? const HeightBox(75)
                                    : const HeightBox(12),
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
                                    InterText(
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
                                            InterText(
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
                                                  BorderRadius.circular(Resp.size(5)),
                                              color: AppColors.grey
                                                  .withOpacity(0.3)),
                                          alignment: Alignment.center,
                                          child: InterText(
                                            text: 'Proposed',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const WidthBox(10),
                                        Container(
                                          width: Resp.size(75),
                                          height: Resp.size(31),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(Resp.size(5)),
                                              color: AppColors.primaryColor),
                                          alignment: Alignment.center,
                                          child: InterText(
                                            text: 'Following',
                                            fontWeight: FontWeight.w600,
                                          ),
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
                                            InterText(
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
                                          child: InterText(
                                            text: 'Proposed',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const WidthBox(10),
                                        Container(
                                          width: Resp.size(75),
                                          height: Resp.size(31),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(Resp.size(5)),
                                              color: AppColors.primaryColor),
                                          alignment: Alignment.center,
                                          child: InterText(
                                            text: 'Following',
                                            fontWeight: FontWeight.w600,
                                          ),
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
                              InterText(
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
                            InterText(
                              text: 'For You',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            InkWell(
                              onTap: () {
                                toPushNavigator(
                                    context: context,
                                    PageName: const TopicsForYou());
                              },
                              child: InterText(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget StatusCard(String text, {bool isActive = false}) {
    return Padding(
      padding: EdgeInsets.only(
        left: !isActive && text == 'Introduced' ? Resp.size(11) : 0,
        right: !isActive && text == 'In Effect' ? Resp.size(11) : 0,
      ),
      child: Container(
        decoration: ShapeDecoration(
          color:
              isActive ? AppColors.grey.withOpacity(0.25) : Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Resp.size(5))),
        ),
        padding: isActive
            ? EdgeInsets.symmetric(
                vertical: Resp.size(10), horizontal: Resp.size(8))
            : EdgeInsets.symmetric(vertical: Resp.size(13)),
        margin: EdgeInsets.all(Resp.size(3)),
        child: InterText(
          text: text,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget PersonCard() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.grey.withOpacity(0.13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              padding: EdgeInsets.fromLTRB(
                  Resp.size(7), Resp.size(12), Resp.size(7), Resp.size(8)),
              child: Column(
                children: [
                  SizedBox(
                    height: Resp.size(55),
                    width: Resp.size(55),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 55,
                      backgroundImage: AssetImage(
                        'assets/homeFlow/dummyPerson.png',
                      ),
                    ),
                  ),
                  const HeightBox(10),
                  InterText(
                    text: 'Ralph Edwards',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  const HeightBox(8),
                  SvgPicture.asset(
                    'assets/homeFlow/followPerson.svg',
                    width: Resp.size(85),
                    height: Resp.size(28),
                  ),
                ],
              ),
            ),
          ),
          WidthBox(12),
        ],
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
