import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/follow.dart';
import 'package:mtb/utils/interText.dart';
import '../../controller/homeController/homeController.dart';
import '../../utils/commonCard.dart';
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
  @override
  Widget build(BuildContext context) {
    final homeController=Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: (){
              toPushNavigator(
                  context: context, pageName: const BillDetailsScreen());
            },
            child: Column(
              children: [
                const HeightBox(15),
                customAppBar(
                  title: 'User’s Legislative Feed',
                  isPrefix: false,
                  context: context,
                  onTapSuffix: (){
                    toPushNavigator(context: context,pageName: const FilterBillsScreen(),);
                  }
                ),
                const HeightBox(20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: Resp.size(4)),
                    itemCount: 10,
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
                                  trailing: followBill(width: 69,height: 31),
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
                                      const InterText(
                                        text: 'Status in Congress',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      const HeightBox(10),
                                      Container(
                                        decoration: ShapeDecoration(
                                          color: AppColors.lightBlack,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(Resp.size(5))),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            statusCard('Introduced', isActive: true),
                                            statusCard('Passed House'),
                                            statusCard('Passed Senate'),
                                            statusCard('In Effect'),
                                          ],
                                        ),
                                      ),
                                      const HeightBox(8),
                                      Container(
                                        decoration: ShapeDecoration(
                                          color: AppColors.lightBlack,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(Resp.size(5))),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal:Resp.size(11),
                                            vertical: Resp.size(13)),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InterText(
                                              text: 'Efficacy Rating',
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w400,
                                              fontSize:12,
                                            ),
                                            InterText(
                                              text: '4',
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w400,
                                              fontSize:12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const HeightBox(10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const InterText(text: 'Tags:',color: Colors.white),
                                              const WidthBox(8),
                                              commonContainer('#healthcare',)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const InterText(text: 'Type:',color: Colors.white),
                                              const WidthBox(8),
                                              commonContainer('Senate',isTag: false)
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          index==9?const HeightBox(75):const HeightBox(12),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }


  Widget commonContainer(String text, {bool isTag=true}){
    return Container(
      decoration: ShapeDecoration(
        color:isTag?AppColors.purple:AppColors.darkBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Resp.size(5))),
      ),
      padding: EdgeInsets.symmetric(
          vertical: Resp.size(10), horizontal: Resp.size(8)),
      child: InterText(
        text: text,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      ),
    );
  }
}
