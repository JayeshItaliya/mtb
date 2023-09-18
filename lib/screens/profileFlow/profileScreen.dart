import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtb/screens/following/followingScreen.dart';
import 'package:mtb/screens/profileFlow/editProfileScreen.dart';
import 'package:mtb/screens/profileFlow/settingScreen.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

import '../../controller/profileController/getProfileDataController.dart';
import '../../utils/pageNavgation.dart';
import '../../utils/responsiveUi.dart';
import '../authFlow/demographicsScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final myController = Get.put(GetProfileDataController());

  File? image;
  Directory? dir;

  XFile? photo;
  bool isImage = false;

  @override
  void initState() {
    super.initState();
    getPath();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      myController.getUserProfileApiCall(context);
    });
  }

  Future<void> getPath() async {
    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
      customPrint(dir);

      if (!dir!.existsSync()) {
        dir?.createSync();
      }
    } else {
      dir = Directory("/storage/emulated/0/Download");
      if (!dir!.existsSync()) {
        dir?.createSync();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetProfileDataController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: defaultScreenPadding(),
          child: Column(
            children: [
              customAppBar(
                  title: 'Profile',
                  context: context,
                  isSuffix: false,
                  isPrefix: false,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              const HeightBox(20),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Obx(()=> myController.isLoading.value
                          ? Container(
                              alignment: Alignment.center,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.lightBlack,
                                borderRadius:
                                    BorderRadius.circular(Resp.size(12)),
                              ),
                              padding: EdgeInsets.all(Resp.size(20)),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cx.showBottomSheet.value = false;
                                      toPushNavigator(
                                          context: context,
                                          onBack: (value) {
                                            cx.showBottomSheet.value = true;
                                            myController.getUserProfileApiCall(context);
                                          },
                                          pageName: const EditProfileScreen());
                                    },
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                              width: Resp.size(90),
                                              height: Resp.size(90),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              imageUrl: myController.userProfileModel.image??dummyProfileUrl,
                                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                radius: Resp.size(25),
                                                backgroundImage: NetworkImage(
                                                  myController.userProfileModel.image??dummyProfileUrl,

                                                ),
                                              ),
                                              fit: BoxFit
                                                  .cover,
                                              placeholder: (context, url) =>ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(100),
                                                child: Container(
                                                  width: Resp.size(90),
                                                  height: Resp.size(90),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          200),
                                                      border: Border.all(
                                                          color: AppColors.grey,
                                                          width: 3)),
                                                  child: const Center(
                                                      child:
                                                      CircularProgressIndicator(
                                                        color:
                                                        AppColors.primaryColor,
                                                      )),
                                                ),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  Image.asset(
                                                      'assets/common/avatar.png'
                                                  ),
                                            ),
                                          ),
                                        ),
                                        // ClipRRect(
                                        //   borderRadius:
                                        //       BorderRadius.circular(100),
                                        //   child: Image.asset(
                                        //     'assets/common/avatar.png',
                                        //     width: Resp.size(90),
                                        //     height: Resp.size(90),
                                        //   ),
                                        // ),
                                        Positioned(
                                          bottom: 3,
                                          right: 3,
                                          child: SvgPicture.asset(
                                            'assets/common/edit.svg',
                                            width: Resp.size(25),
                                            height: Resp.size(25),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const HeightBox(12),
                                  InterText(
                                    text: myController.userProfileModel.name ??
                                        "MTB User",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const HeightBox(8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/profileFlow/location.svg',
                                        width: Resp.size(15),
                                        height: Resp.size(15),
                                      ),
                                      Text(
                                        ' ${myController.userProfileModel.city ?? "Middletown"}',
                                        style: GoogleFonts.poppins(
                                            fontSize: Resp.size(13),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                    ),
                    const HeightBox(12),
                    profileCard('Demographics', 'demographics', () {
                      cx.showBottomSheet.value = false;
                      toPushNavigator(
                          context: context,
                          onBack: (value) {
                            cx.showBottomSheet.value = true;
                          },
                          pageName: const DemoGraphicsScreen(
                            isFromProfile: true,
                          ));
                    }),
                    const HeightBox(12),
                    profileCard('Notifications', 'notifications', () {}),
                    const HeightBox(12),
                    profileCard('Following', 'following', () {
                      cx.showBottomSheet.value = false;
                      toPushNavigator(
                          context: context,
                          onBack: (value) {
                            cx.showBottomSheet.value = true;
                          },
                          pageName: const FollowingScreen(
                            isFromProfile: true,
                          ));
                    }),
                    const HeightBox(12),
                    profileCard('Invite Friends', 'share', () {
                      onShareData(
                          text: "*Download Mind The Bill Now😍"
                              "*\n\nLink For iOS:\nhttps://apps.apple.com/us/app/mtb/id8AZK4JLW8R"
                              "\n\nLink For Android:"
                              "\nhttps://play.google.com/store/apps/details?id=com.mtb\n");
                    }),
                    const HeightBox(12),
                    profileCard('Settings ', 'settings', () {
                      cx.showBottomSheet.value = false;
                      toPushNavigator(
                          context: context,
                          onBack: (value) {
                            cx.showBottomSheet.value = true;
                          },
                          pageName: const SettingScreen());
                    }),
                    HeightBox(Resp.size(100)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget profileCard(String title, String img, Function onTap) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.lightBlack,
          borderRadius: BorderRadius.circular(Resp.size(12)),
        ),
        padding: EdgeInsets.all(Resp.size(12)),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/profileFlow/$img.svg',
              width: Resp.size(45),
              height: Resp.size(45),
            ),
            InterText(
              text: '    $title',
              fontSize: Resp.size(14),
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
