import 'dart:developer';

import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/schedule/logic.dart';
import 'package:consultant_product/src/modules/consultant/schedule/repo_get.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

markHolidayPostRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getAvailableDaysUrl,
          {
            'token': '123',
            'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
            'appointment_type_id': Get.find<MentorScheduleLogic>().selectedScheduleTypeId,
          },
          false,
          getAvailableDaysRepo);
      log('markHolidayPostRepo ------>> ${response['Status']}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

saveSchedulePostRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {

      Get.find<MentorScheduleLogic>().selectedScheduleType = null;
      Get.find<MentorScheduleLogic>().selectedAvailableDay = null;
      Get.find<MentorScheduleLogic>().selectedTimeForStart = null;
      Get.find<MentorScheduleLogic>().selectedTimeForStartForCalculate = null;
      Get.find<MentorScheduleLogic>().selectedTimeForEnd = null;
      Get.find<MentorScheduleLogic>().selectedTimeForEndForCalculate = null;
      Get.find<MentorScheduleLogic>().slotsList = [];
      Get.find<MentorScheduleLogic>().chargesController.clear();
      Get.find<MentorScheduleLogic>().durationController.clear();
      Get.find<MentorScheduleLogic>().slotsList = [];
      getMethod(
          context,
          getMentorSchedulesUrl,
          {
            'token': '123',
            'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          false,
          getMentorScheduleRepo);
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar('${'added_successfully'.tr}!', '',
          colorText: Colors.black,
          backgroundColor: customThemeColor.withOpacity(0.5));
      log('saveSchedulePostRepo ------>> ${response['Status']}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}