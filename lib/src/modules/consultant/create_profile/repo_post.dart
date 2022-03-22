
import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/model_post_general_info.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mentorGeneralInfo2Repo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().generalInfoPostModel =
        GeneralInfoPostModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().generalInfoPostModel.status == true) {
      Get.find<CreateProfileLogic>()
          .stepperList[Get.find<CreateProfileLogic>().stepperIndex!]
          .isSelected = false;
      Get.find<CreateProfileLogic>()
          .stepperList[Get.find<CreateProfileLogic>().stepperIndex!]
          .isCompleted = true;
      Get.find<CreateProfileLogic>()
          .stepperList[Get.find<CreateProfileLogic>().stepperIndex! + 1]
          .isSelected = true;
      Get.find<CreateProfileLogic>().updateStepperIndex(1);
      Get.snackbar('${'profile_updated_successfully'.tr}!', '',
          colorText: Colors.black,
          backgroundColor: customThemeColor.withOpacity(0.5));
      Get.find<GeneralController>().updateFormLoaderController(false);
      log('mentorGeneralInfoRepo ------>> ${Get.find<CreateProfileLogic>().generalInfoPostModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: 'try_again!'.tr,
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
    }
  } else {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'failed!'.tr,
            titleColor: customDialogErrorColor,
            descriptions: 'try_again!'.tr,
            text: 'ok'.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
  }
}