import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/homeFlowModel/relatedBillModel.dart';
import '../../utils/appColors.dart';
import '../../utils/interText.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class RelatedToScreen extends StatefulWidget {
  final RelatedBillModel item;

  const RelatedToScreen({super.key, required this.item});

  @override
  State<RelatedToScreen> createState() => _RelatedToScreenState();
}

class _RelatedToScreenState extends State<RelatedToScreen> {
  @override
  Widget build(BuildContext context) {
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
                  title: 'Related To', isSuffix: false, context: context),
              const HeightBox(20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    Resp.size(0),
                    Resp.size(12),
                    Resp.size(12),
                    Resp.size(10),
                  ),
                  // margin: EdgeInsets.only(bottom: Resp.size(25),),
                  decoration: ShapeDecoration(
                    color: AppColors.lightBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Resp.size(10)),
                    ),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.item.relatedBillName?.length,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // maxCrossAxisExtent: 200,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(
                          Resp.size(12),
                          Resp.size(0),
                          Resp.size(0),
                          Resp.size(6),
                        ),
                        decoration: ShapeDecoration(
                          color: AppColors.lightBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Resp.size(10)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            topicCard(
                                widget.item.relatedBillName?[index].topicSimplified
                                        .toString() ??
                                    "",
                                widget.item.relatedBillName?[index].billname
                                        .toString() ??
                                    ""),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topicCard(String topicSimplified, String billName) {
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
                  Resp.size(7), Resp.size(8), Resp.size(7), Resp.size(8)),
              child: Column(
                children: [
                  SizedBox(
                    height: Resp.size(55),
                    width: Resp.size(55),
                    child: SvgPicture.asset(getTopicImage(topicSimplified)),
                  ),
                  const HeightBox(10),
                  InterText(
                    text: billName,
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
          // WidthBox(12),
        ],
      ),
    );
  }
}
