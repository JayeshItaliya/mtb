import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtb/controller/profileController/getProfileDataController.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/utils.dart';

import '../../utils/responsiveUi.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = Get.put(GetProfileDataController());
  @override
  void initState() {
    controller.getUserProfileApiCall(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Resp.size(12)),
          child: Column(
            children: [
              const HeightBox(15),
              customAppBar(
                  title: 'Edit Profile',
                  context: context,
                  isSuffix: false,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              Obx(() =>controller.isLoading.value==true? Center(child: CircularProgressIndicator()):
              Column(
                children: [
                  const HeightBox(58),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/common/avatar.png',
                          width: Resp.size(110),
                          height: Resp.size(110),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          'assets/common/camera.svg',
                          width: Resp.size(30),
                          height: Resp.size(30),
                        ),
                      )
                    ],
                  ),
                  const HeightBox(65),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(Resp.size(12)),
                    ),
                    padding: EdgeInsets.all(Resp.size(16)),
                    child: InterText(
                      text: controller.userProfileModel.name,
                      fontSize: Resp.size(14),
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const HeightBox(20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(Resp.size(12)),
                    ),
                    padding: EdgeInsets.all(Resp.size(16)),
                    child: InterText(
                      text: controller.userProfileModel.email,
                      fontSize: Resp.size(14),
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const HeightBox(20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(Resp.size(12)),
                    ),
                    padding: EdgeInsets.all(Resp.size(16)),
                    child: InterText(
                      text: controller.userProfileModel.state,
                      fontSize: Resp.size(14),
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const HeightBox(100),
                  CommonButton(
                    onTap: () {},
                    text: 'Save',
                  )
                ],
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
