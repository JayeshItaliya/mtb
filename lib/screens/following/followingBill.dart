import 'package:flutter/material.dart';
import 'package:mtb/model/followingModel/followModel.dart';

import '../../services/api_call.dart';
import '../../utils/appColors.dart';
import '../../utils/commonCard.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';
import '../homeFlow/billDetailsScreen.dart';

class FollowingBill extends StatefulWidget {
  List<FollowModel> followList;

  FollowingBill(this.followList, {super.key});

  @override
  State<FollowingBill> createState() => _FollowingBillState();
}

class _FollowingBillState extends State<FollowingBill> {
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
                  title: 'Following Bill', isSuffix: false, context: context),
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
                    itemCount: widget.followList.length,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // maxCrossAxisExtent: 200,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      FollowModel model = widget.followList[index];
                      return InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          toPushNavigator(
                              context: context,
                              onBack: (_) {

                              },
                              pageName: BillDetailsScreen(
                                item: model.billdetail[0],
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                            Resp.size(12),
                            Resp.size(0),
                            Resp.size(0),
                            Resp.size(8),
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
                              topicCard(model, () {
                                setState(() {
                                  widget.followList.removeAt(index);
                                  TaskProvider().followAPI(
                                      model.billId.toString(), '0', context);
                                });
                              }),
                            ],
                          ),
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
}
