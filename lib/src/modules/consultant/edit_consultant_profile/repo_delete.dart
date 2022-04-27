import 'dart:developer';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

deleteEducationRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'] == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);

      Get.snackbar('${LanguageConstant.deleteSuccessfully.tr}!', '',
          colorText: Colors.black, backgroundColor: Colors.white);
      log('deleteEducationRepo ------>> ${Get.find<EditConsultantProfileLogic>().citiesByIdModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
