import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/appColors.dart';
import '../../utils/interText.dart';
import '../../utils/responsiveUi.dart';
import '../../utils/utils.dart';

class FollowingCongressPerson extends StatefulWidget {
  const FollowingCongressPerson({super.key});

  @override
  State<FollowingCongressPerson> createState() => _FollowingCongressPersonState();
}

class _FollowingCongressPersonState extends State<FollowingCongressPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const HeightBox(15),
          customAppBar(
              title: 'Congress Person',
              isSuffix: false,
              context: context
          ),
          const HeightBox(20),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(Resp.size(0),Resp.size(12),Resp.size(12),Resp.size(0),),
              // margin: EdgeInsets.only(bottom: Resp.size(25),),
              decoration: ShapeDecoration(
                color: AppColors.lightBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Resp.size(10)),
                ),
              ),
              child:GridView.builder(
                shrinkWrap: true,
                itemCount: 31,
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  // maxCrossAxisExtent: 200,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    padding: EdgeInsets.fromLTRB(Resp.size(12),Resp.size(0),Resp.size(0),Resp.size(12),),
                    decoration: ShapeDecoration(
                      color: AppColors.lightBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Resp.size(10)),
                      ),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PersonCard(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget PersonCard(){
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.grey.withOpacity(0.13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              padding: EdgeInsets.fromLTRB(Resp.size(7), Resp.size(12), Resp.size(7), Resp.size(8)),
              child: Column(
                children: [
                  SizedBox(
                    height: Resp.size(55),
                    width: Resp.size(55),
                    child: const CircleAvatar(
                      backgroundColor:
                      Colors.transparent,
                      radius: 55,
                      backgroundImage: AssetImage(
                        'assets/homeFlow/dummyPerson.png',
                      ),
                    ),
                  ),
                  const HeightBox(10),
                  InterText(
                    text: 'Albert Obama',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  const HeightBox(8),
                  SvgPicture.asset(
                    'assets/homeFlow/following.svg',
                    width: Resp.size(85),
                    height: Resp.size(28),
                  ),
                ],
              ),
            ),
          ),
          // WidthBox(Resp.size(12)),
        ],
      ),
    );
  }

}
