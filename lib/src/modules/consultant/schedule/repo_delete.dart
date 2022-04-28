import 'dart:developer';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/schedule/repo_get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

deleteMentorScheduleRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'] == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      getMethod(
          context,
          getMentorSchedulesUrl,
          {
            'token': '123',
            'mentor_id':
                Get.find<GeneralController>().storageBox.read('userID'),
          },
          false,
          getMentorScheduleRepo);
      Get.snackbar('${LanguageConstant.deleteSuccessfully.tr}!', '',
          colorText: Colors.black, backgroundColor: Colors.white);
      log('deleteMentorScheduleRepo ------>> ${response['Status']}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
