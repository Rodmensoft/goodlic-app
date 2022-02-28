import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/modules/user/home/model_get_categories.dart';
import 'package:consultant_product/src/modules/user/home/model_user_profile.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getUserProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().getUserProfileModel = GetUserProfileModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().getUserProfileModel.status.toString() == 'true') {

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);

    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

getCategoriesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().getCategoriesModel = GetCategoriesModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().getCategoriesModel.status.toString() == 'true') {
      Get.find<UserHomeLogic>().categoriesList.clear();
      for (var element in Get.find<UserHomeLogic>().getCategoriesModel.data!.mentorCategories!) {
        Get.find<UserHomeLogic>().categoriesList.add(
          HomeStyling(
            title: element.name,
            subTitle: element.mentorPCount.toString(),
            image: element.imagePath,
            color: customThemeColor
          )
        );
      }
      Get.find<UserHomeLogic>().updateCategoriesLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);

    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}