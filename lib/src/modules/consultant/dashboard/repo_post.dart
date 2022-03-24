
import 'dart:developer';

import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user_profile/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

changeMentorOnlineStatusRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    // Get.find<GeneralController>().updateFormLoaderController(false);
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getUserProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
      log('changeMentorOnlineStatusRepo ------>> ${response['Status'].toString()}');
    } else {}
  } else if (!responseCheck) {
    // Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

goLiveRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    // Get.find<GeneralController>().updateFormLoaderController(false);
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getUserProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
      log('goLiveRepo ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
inActiveLiveRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    // Get.find<GeneralController>().updateFormLoaderController(false);
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getUserProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
      log('logout ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

logOutRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    // Get.find<GeneralController>().updateFormLoaderController(false);
    if (response['Status'].toString() == 'true') {


    } else {}
  } else if (!responseCheck) {
    // Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}