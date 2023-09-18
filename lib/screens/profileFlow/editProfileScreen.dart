import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtb/controller/profileController/getProfileDataController.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:mtb/utils/commonButton.dart';
import 'package:mtb/utils/interText.dart';
import 'package:mtb/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../utils/responsiveUi.dart';
import '../../utils/textFormFields.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = Get.put(GetProfileDataController());
  final editProfileKey = GlobalKey<FormState>();

  File? image;
  Directory? dir;
  final ImagePicker _picker = ImagePicker();

  XFile? photo;
  bool isImage = false;

  @override
  void initState() {
    super.initState();
    getPath();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserProfileApiCall(context);
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
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: defaultScreenPadding(),
          child: Form(
            key: editProfileKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                customAppBar(
                    title: 'Edit Profile',
                    context: context,
                    isSuffix: false,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        // const HeightBox(50),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                isImage
                                    ? Obx(
                                        () => cx.isDataProcessing.value
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  width: Resp.size(110),
                                                  height: Resp.size(110),
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
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  width: Resp.size(110),
                                                  height: Resp.size(110),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(
                                                          color: AppColors.grey,
                                                          width: 3),
                                                      image: DecorationImage(
                                                        image: FileImage(
                                                            File(image!.path)),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                              ),
                                      )
                                    : SizedBox(
                                  width: Resp.size(110),
                                  height: Resp.size(110),
                                      // decoration: BoxDecoration(
                                      //     borderRadius:
                                      //     BorderRadius.circular(
                                      //         200),
                                      //     image: DecorationImage(
                                      //         image: NetworkImage(controller
                                      //             .userProfileModel.image ??
                                      //             dummyProfileUrl)
                                      //     ),
                                      //   ),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(200),
                                        child: CachedNetworkImage(
                                            imageUrl: controller
                                                    .userProfileModel.image ??
                                                dummyProfileUrl,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    CircleAvatar(
                                                      backgroundColor: Colors.transparent,
                                                      radius: Resp.size(25),
                                                      backgroundImage: NetworkImage(
                                                        controller.userProfileModel.image??dummyProfileUrl,

                                                      ),
                                                    ),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                  'assets/common/avatar.png',
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                                        'assets/common/avatar.png'
                                                    ),
                                          ),
                                      ),
                                    ),
                                Positioned(
                                  bottom: Resp.size(4),
                                  right: Resp.size(4),
                                  child: GestureDetector(
                                    onTap: () {
                                      onEditProfile(context: context);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/common/camera.svg',
                                      width: Resp.size(30),
                                      height: Resp.size(30),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const HeightBox(65),
                            AppWidget.getTextField(
                                hintText: "Full Name",
                                inputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                textEditingController:
                                    controller.fullNameController.value,
                                inputFormatter: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z]+|\s")),
                                ],
                                validationFunction: (val) {
                                  if (val.toString().isEmpty) {
                                    return "Please Enter Full Name";
                                  } else if (val.toString().length < 8) {
                                    return "Full Name Length Must Be 8 Or Greater";
                                  }
                                  return null;
                                }),
                            const HeightBox(15),
                            AppWidget.getTextField(
                                hintText: "Email",
                                inputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                textEditingController:
                                    controller.emailController.value,
                                validationFunction: (val) {
                                  if (val.toString().isEmpty) {
                                    return "Please Enter Email";
                                  } else if (!isValid(val.toString())) {
                                    return "Please Enter Valid Email";
                                  }
                                  return null;
                                }),
                            const HeightBox(15),
                            AppWidget.getTextField(
                                hintText: "Location",
                                inputAction: TextInputAction.next,
                                isEnabled: false,
                                keyboardType: TextInputType.emailAddress,
                                textEditingController:
                                    controller.locationController.value,
                                validationFunction: (val) {
                                  if (val.toString().isEmpty) {
                                    return "Please Enter Location";
                                  }
                                  return null;
                                }),
                          ],
                        ),
                        // const HeightBox(100),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      CommonButton(
                        onTap: () {
                          if(!cx.isDataProcessing.value){
                            if (editProfileKey.currentState!.validate()) {
                              controller.postUserProfile(
                                  context,
                                  image?.path ?? "",
                                  (image?.path.toString() ?? "").isEmpty
                                      ? false
                                      : true);
                            }
                          }
                        },
                        text: 'Save',
                      ),
                      const HeightBox(25),
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

  void onEditProfile({
    required BuildContext context,
  }) {
    Alert(
      style: AlertStyle(
          buttonsDirection: ButtonsDirection.column,
          backgroundColor: AppColors.lightBlack,
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            // side: const BorderSide(
            //   color: Color(0xFF9BD9C1),
            //   width: 2.5,
            // ),
          ),
          alertElevation: 100,
          isButtonVisible: false),
      onWillPopActive: false,

      context: context,
      content: Column(
        children: <Widget>[
          const HeightBox(5),
          const InterText(
              text: "Change Profile Image",
              fontSize: 17,
              fontWeight: FontWeight.w700),
          const HeightBox(15),
          CommonButton(
            text: "Open Camera",
            topHeight: 20,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            onTap: () async {
              var photosStatus = await Permission.storage.status;
              if (!photosStatus.isGranted) {
                await Permission.storage.request();
              } else if (photosStatus.isPermanentlyDenied) {
                showOpenAppSettingsDialog(context);
                await Permission.storage.request();
              } else if (photosStatus.isDenied) {
                showOpenAppSettingsDialog(context);
                await Permission.storage.request();
              } else if (photosStatus.isRestricted) {
                showOpenAppSettingsDialog(context);
                await Permission.storage.request();
              } else {
                photo = await _picker.pickImage(source: ImageSource.camera);
                setState(() {
                  image = (File(photo!.path));
                });

                if (image == null) {
                  setState(() {
                    isImage = false;
                  });
                } else {
                  setState(() {
                    isImage = true;
                    compressImage(photo!).then((value) {
                      cx.isDataProcessing.value = false;

                      image = value;
                      customPrint("value.toString()");
                      customPrint(image!.path);
                      customPrint(value.toString());
                      customPrint(value.path.toString());
                    });
                  });
                }
                customPrint(photo!.path);
                customPrint(image!.path);
                Get.back();
              }

              // Duration du = const Duration(seconds: 2);
              // Timer(du, () {
              //   // Get.offAll(WonderEvents());
              //   Get.back();
              // });
            },
          ),
          CommonButton(
            text: "Open Gallery",
            topHeight: 20,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            onTap: () async {
              var photosStatus = await Permission.storage.status;
              if (!photosStatus.isGranted) {
                await Permission.storage.request();
              } else {
                photo = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  image = (File(photo!.path));
                });
                Get.back();
                customPrint(photo!.path);
                customPrint(image!.path);

                if (image == null) {
                  setState(() {
                    isImage = false;
                  });
                } else {
                  customPrint("image!.absolute");
                  customPrint(image!.absolute);
                  customPrint(dir.toString());
                  setState(() {
                    isImage = true;

                    compressImage(photo!).then((value) {
                      cx.isDataProcessing.value = false;

                      image = value;
                      customPrint("value.toString()");
                      customPrint(image!.path);
                      customPrint(value.toString());
                      customPrint(value.path.toString());
                    });
                  });
                }
              }

              // Duration du = const Duration(seconds: 2);
              // Timer(du, () {
              //   Get.back();
              // });
            },
          ),
        ],
      ),

      closeIcon: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      ),
      // onWillPopActive:true ,
    ).show();
  }

  Future<File> compressImage(XFile file) async {
    cx.isDataProcessing.value = true;
    customPrint("File Path");
    customPrint(file.path);
    final ImageFile input =
        ImageFile(filePath: file.path, rawBytes: await file.readAsBytes());
    final Configuration config = Configuration(
      outputType: ImageOutputType.webpThenPng,
      useJpgPngNativeCompressor: false,
      quality: (input.sizeInBytes / 1048576) < 2
          ? 90
          : (input.sizeInBytes / 1048576) < 5
              ? 50
              : (input.sizeInBytes / 1048576) < 10
                  ? 10
                  : 1,
    );
    final ImageFile output = await compressor
        .compress(ImageFileConfiguration(input: input, config: config));
    if (kDebugMode) {
      customPrint('Input size : ${input.sizeInBytes / 1048576}');
      customPrint('Output size : ${output.sizeInBytes / 1048576}');
      // print(output.pa);
    }
    File file1 = await _createFileFromString(output.rawBytes);
    return file1;
  }

  Future<File> _createFileFromString(bytes) async {
    // final result = await ImageGallerySaver.saveImage(bytes, name: "signature");
    // Directory dir;
    // if (Platform.isIOS) {
    //   dir = await getApplicationDocumentsDirectory();
    //   print(dir);
    //
    //   if (!dir.existsSync()) {
    //     dir.createSync();
    //   }
    // } else {
    //   dir = Directory("/storage/emulated/0/Download");
    //   if (!dir.existsSync()) {
    //     dir.createSync();
    //   }
    // }

    String dir = (await getApplicationDocumentsDirectory()).path;
    var rng = Random();
    for (var i = 0; i < 10; i++) {
      customPrint(rng.nextInt(100));
    }
    String fullPath = '$dir/mtb${DateTime.now().millisecondsSinceEpoch}.png';
    customPrint("local file full path $fullPath");
    File file = File(fullPath);
    await file.writeAsBytes(bytes);
    customPrint(file.path);

    final result = await ImageGallerySaver.saveImage(bytes);
    customPrint(result);
    customPrint("local file full path ${result['filePath']}");
    customPrint("local file full path ${result.toString()}");
    return file;
  }
}
