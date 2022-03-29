import 'dart:developer';

import 'package:consultant_product/src/modules/user/appointment_detail/logic.dart';
import 'package:consultant_product/src/modules/user/ratings/rating_existance_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ratingExistRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<AppointmentDetailLogic>().ratingExistModel =
        RatingExistModel.fromJson(response);
    if (Get.find<AppointmentDetailLogic>().ratingExistModel
        .status ==
        true) {
      Get.find<AppointmentDetailLogic>().isRated=Get.find<AppointmentDetailLogic>().ratingExistModel.data!.ratingExist;
      log('rating details ------>> ${Get.find<AppointmentDetailLogic>().ratingExistModel.success}');
    } else {
      // Get.find<AppointmentDetailLogic>()
      //     .updateGetNewAppointmentLoader(false);
    }
    Get.find<AppointmentDetailLogic>().updateGetRatingDataController(false);
  } else if (!responseCheck) {
    Get.find<AppointmentDetailLogic>().updateGetRatingDataController(false);
    // Get.find<AppointmentDetailLogic>()
    //     .updateGetNewAppointmentLoader(false);

    log('Exception........................');
  }
}