import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtb/screens/homeFlow/againstScreen.dart';
import 'package:mtb/screens/homeFlow/forScreen.dart';
import 'package:mtb/screens/homeFlow/relatedToScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/follow.dart';
import 'package:mtb/utils/interText.dart';
import '../../controller/homeController/billDetailsController.dart';
import '../../model/homeFlowModel/billListModel.dart';
import '../../model/homeFlowModel/relatedBillModel.dart';
import '../../services/api_call.dart';
import '../../utils/commonCard.dart';
import '../../utils/following.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';
import 'billDescriptionScreen.dart';
import 'filterDataScreen.dart';

class BillDetailsScreen extends StatefulWidget {
  final BillListModel item;

  const BillDetailsScreen({super.key, required this.item});

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  final myController = Get.put(BillDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    myController.relatedModel.value = (await myController.relatedBillApi(
        context, widget.item.number.toString(), widget.item.type.toString()))!;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BillDetailsController>(builder: (controller) {
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
                    title: 'Bill Details', isSuffix: false, context: context),
                const HeightBox(20),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: Resp.size(4)),
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          Resp.size(12),
                          0,
                          Resp.size(12),
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
                            ListTile(
                              leading: InkWell(
                                onTap: () {
                                  toPushNavigator(
                                      context: context,
                                      pageName: FilterDataScreen(
                                          metaData:
                                              "&topic_tag=${widget.item.topicSimplified.toString()}"));
                                },
                                child: SvgPicture.asset(
                                  getTopicImage(
                                      widget.item.topicSimplified.toString()),
                                  width: Resp.size(45),
                                  height: Resp.size(45),
                                ),
                              ),
                              title: InterText(
                                text: widget.item.billName,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              subtitle: InterText(
                                text: 'Proposed on ${widget.item.proposedDate}',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              trailing: InkWell(
                                child: (widget.item.isFollow ?? false)
                                    ? followingBill(
                                        width: 69,
                                      )
                                    : followBill(
                                        width: 69,
                                      ),
                                onTap: () {
                                  setState(() {
                                    widget.item.isFollow =
                                        (!(widget.item.isFollow ?? false));
                                    TaskProvider().followAPI(
                                        widget.item.id.toString(),
                                        widget.item.isFollow ?? false
                                            ? '1'
                                            : '0',
                                        context);
                                  });
                                },
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
                                  const InterText(
                                    text: 'Status in Congress',
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
                                        statusCard('Introduced',
                                            selectedText:
                                                widget.item.statusInCongress),
                                        statusCard('Passed House',
                                            selectedText:
                                                widget.item.statusInCongress),
                                        statusCard('Passed Senate',
                                            selectedText:
                                                widget.item.statusInCongress),
                                        statusCard('In Effect',
                                            selectedText:
                                                widget.item.statusInCongress),
                                      ],
                                    ),
                                  ),
                                  // const HeightBox(8),
                                  // Container(
                                  //   decoration: ShapeDecoration(
                                  //     color: AppColors.lightBlack,
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(
                                  //             Resp.size(5))),
                                  //   ),
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: Resp.size(11),
                                  //       vertical: Resp.size(13)),
                                  //   child: const Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       InterText(
                                  //         text: 'Efficacy Rating',
                                  //         textAlign: TextAlign.center,
                                  //         fontWeight: FontWeight.w400,
                                  //         fontSize: 12,
                                  //       ),
                                  //       InterText(
                                  //         text: '4',
                                  //         textAlign: TextAlign.center,
                                  //         fontWeight: FontWeight.w400,
                                  //         fontSize: 12,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const HeightBox(10),
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
                                  // InterText(
                                  //   text: 'Status in CongressLorem ipsum dolor sit amet, consectetur adcinge lit.Maecenas pretium lacus quis massa blandit, ettristilectus pretium. In sed turpis fertum, placerat auguenon, maximus lorem',
                                  //   fontSize: 10,
                                  //   fontWeight: FontWeight.w400,
                                  //   textOverflow: TextOverflow.clip,
                                  //   maxLines: 3,
                                  // ),
                                  handleDescription(
                                      widget.item.billText.toString()),
                                  // const HeightBox(10),
                                  // Container(
                                  //   decoration: ShapeDecoration(
                                  //     color: AppColors.lightBlack,
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(
                                  //             Resp.size(5))),
                                  //   ),
                                  //   // padding: EdgeInsets.symmetric(
                                  //   //     horizontal: Resp.size(11),
                                  //   //     vertical: Resp.size(13)),
                                  //   child: Column(
                                  //     children: [
                                  //       billCharacteristicsCard(
                                  //           'Efficacy Rating', 4),
                                  //       billCharacteristicsCard('Clarity', 4),
                                  //       billCharacteristicsCard(
                                  //           'Redundancy', 4),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const HeightBox(12),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          Resp.size(12),
                          Resp.size(12),
                          Resp.size(0),
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
                            Padding(
                              padding: EdgeInsets.only(right: Resp.size(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const InterText(
                                    text: 'For',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  InkWell(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    onTap: () {
                                      toPushNavigator(
                                          context: context,
                                          pageName: const ForScreen());
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
                            ),
                            const HeightBox(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                personCard(),
                                personCard(),
                                personCard(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const HeightBox(12),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          Resp.size(12),
                          Resp.size(12),
                          Resp.size(0),
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
                            Padding(
                              padding: EdgeInsets.only(right: Resp.size(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const InterText(
                                    text: 'Against',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  InkWell(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    onTap: () {
                                      toPushNavigator(
                                          context: context,
                                          pageName: const AgainstScreen());
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
                            ),
                            const HeightBox(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                personCard(),
                                personCard(),
                                personCard(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const HeightBox(12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Resp.size(10)),
                        child: Image.asset(
                          'assets/homeFlow/map.png',
                          width: double.infinity,
                          height: Resp.size(165),
                          scale: 2,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const HeightBox(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                widget.item.isTrending = 1;
                                myController.postTrending(
                                    context,
                                    widget.item.id.toString(),
                                    widget.item.isTrending == 1 ? '1' : '0');
                                myController.update();
                              },
                              child: SvgPicture.asset(
                                widget.item.isTrending == 1
                                    ? 'assets/homeFlow/up.svg'
                                    : 'assets/homeFlow/noneUp.svg',
                                width: Resp.size(55),
                                height: Resp.size(55),
                              )),
                          InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                widget.item.isTrending = 2;

                                myController.postTrending(
                                    context,
                                    widget.item.id.toString(),
                                    widget.item.isTrending == 2 ? '2' : '0');
                                myController.update();
                              },
                              child: SvgPicture.asset(
                                widget.item.isTrending == 2
                                    ? 'assets/homeFlow/down.svg'
                                    : 'assets/homeFlow/noneDown.svg',
                                width: Resp.size(55),
                                height: Resp.size(55),
                              )),
                        ],
                      ),
                      const HeightBox(30),
                      Obx(() {
                        RelatedBillModel model =
                            myController.relatedModel.value;

                        return model.relatedBillName != null &&
                                model.relatedBillName!.isNotEmpty
                            ? Container(
                                padding: EdgeInsets.fromLTRB(
                                  Resp.size(12),
                                  Resp.size(12),
                                  Resp.size(0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: Resp.size(12)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const InterText(
                                            text: 'Related To',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                          if ((model.relatedBillName?.length ??
                                                  0) >
                                              3) ...{
                                            InkWell(
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                              onTap: () {
                                                toPushNavigator(
                                                    context: context,
                                                    pageName: RelatedToScreen(
                                                      item: model,
                                                    ));
                                              },
                                              child: const InterText(
                                                text: 'View All',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          },
                                        ],
                                      ),
                                    ),
                                    const HeightBox(12),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: model.relatedBillName ==
                                                  null ||
                                              model.relatedBillName!.isEmpty
                                          ? 0
                                          : model.relatedBillName!.length >= 3
                                              ? 3
                                              : model.relatedBillName?.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          topicsCard(
                                              model.relatedBillName![index]
                                                      .topicSimplified ??
                                                  '',
                                              model.relatedBillName![index]
                                                      .billname ??
                                                  ''),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : myController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const InterText(
                                    text: 'No Related Bill Found',
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  );
                      }),
                      const HeightBox(24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // extendBody: true,
          // bottomNavigationBar: BottomSheet(
          //   backgroundColor: Colors.transparent,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(Resp.size(15)),
          //       topRight: Radius.circular(Resp.size(15)),
          //       bottomRight: Radius.circular(Resp.size(0)),
          //       bottomLeft: Radius.circular(Resp.size(0)),
          //     ),
          //   ),
          //   onClosing: () {},
          //   enableDrag: false,
          //   builder: (BuildContext context) {
          //     return Container(
          //       height: Resp.size(76),
          //       // color: AppColors.lightBlack,
          //
          //       decoration: ShapeDecoration(
          //         color: AppColors.lightBlack,
          //         shadows: const [
          //           BoxShadow(
          //               color: AppColors.lightBlack,
          //               spreadRadius: 0,
          //               blurRadius: 10),
          //         ],
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(Resp.size(15)),
          //             topRight: Radius.circular(Resp.size(15)),
          //             bottomRight: Radius.circular(Resp.size(0)),
          //             bottomLeft: Radius.circular(Resp.size(0)),
          //           ),
          //         ),
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               SvgPicture.asset(
          //                 'assets/homeFlow/news.svg',
          //                 width: Resp.size(26),
          //                 height: Resp.size(26),
          //               ),
          //               const HeightBox(10),
          //               const InterText(
          //                 text: 'News',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 14,
          //               )
          //             ],
          //           ),
          //           Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               SvgPicture.asset(
          //                 'assets/homeFlow/add.svg',
          //                 width: Resp.size(26),
          //                 height: Resp.size(26),
          //               ),
          //               const HeightBox(10),
          //               const InterText(
          //                 text: 'Follow',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 14,
          //               )
          //             ],
          //           ),
          //           InkWell(
          //             overlayColor:
          //                 MaterialStateProperty.all(Colors.transparent),
          //             onTap: () {
          //               onShareData(
          //                   text: "*Download Mind The Bill Now😍"
          //                       "*\n\nLink For iOS:\nhttps://apps.apple.com/us/app/domez/id6444339880"
          //                       "\n\nLink For Android:"
          //                       "\nhttps://play.google.com/store/apps/details?id=domez.io\n");
          //             },
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 SvgPicture.asset(
          //                   'assets/homeFlow/share.svg',
          //                   width: Resp.size(26),
          //                   height: Resp.size(26),
          //                 ),
          //                 const HeightBox(10),
          //                 const InterText(
          //                   text: 'Share',
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 14,
          //                 )
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ),
      );
    });
  }

  Widget billCharacteristicsCard(String text, int value) {
    return Container(
      padding: EdgeInsets.only(
          left: Resp.size(11),
          right: Resp.size(11),
          top: text == 'Efficacy Rating' ? Resp.size(12) : Resp.size(0),
          bottom: text == 'Redundancy' ? Resp.size(12) : Resp.size(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InterText(
            text: text,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          InterText(
            text: value.toString(),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  Widget handleDescription(String desc) {
    return RichText(
      maxLines: 10,
      overflow: TextOverflow.clip,
      text: TextSpan(
        text: '',
        style: GoogleFonts.inter(
          color: Colors.white.withOpacity(0.4),
          fontWeight: FontWeight.w500,
          fontSize: Resp.size(12),
        ),
        children: <TextSpan>[
          desc.length > 120
              ? TextSpan(
                  text: desc.substring(0, 120),
                )
              : TextSpan(
                  text: desc.toString(),
                ),
          desc.length > 120
              ? TextSpan(
                  text: '...See More',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    fontSize: Resp.size(12),
                    // decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      toPushNavigator(
                          context: context,
                          pageName: BillDescriptionScreen(
                            demoText: desc,
                          ));
                    },
                )
              : const TextSpan(text: ''),
        ],
      ),
    );
  }

  Widget personCard() {
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
                  const InterText(
                    text: 'Ralph Edwards',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    textAlign: TextAlign.center,
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
          const WidthBox(12),
        ],
      ),
    );
  }

  Widget topicsCard(
    String text,
    String billName,
  ) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.grey.withOpacity(0.13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Resp.size(8),
        vertical: Resp.size(12),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            getTopicImage(text),
            width: Resp.size(55),
            height: Resp.size(55),
          ),
          const HeightBox(10),
          InterText(
            text: billName,
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: Colors.white,
            textOverflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
