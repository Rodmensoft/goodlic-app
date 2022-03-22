import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

deleteEducationRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'] == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);

      Get.snackbar('${'delete_successfully'.tr}!', '',
          colorText: Colors.black,
          backgroundColor: customThemeColor.withOpacity(0.5));
      log('deleteEducationRepo ------>> ${Get.find<CreateProfileLogic>().citiesByIdModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
