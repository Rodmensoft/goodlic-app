
import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/get_ratings_model.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/logic.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/model_get_appointment_count_mentor.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/model_get_today_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getMentorTodayAppointmentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<DashboardLogic>().getTodayAppointmentModel =
        GetTodayAppointmentModel.fromJson(response);
    if (Get.find<DashboardLogic>()
        .getTodayAppointmentModel
        .status ==
        true) {
      Get.find<DashboardLogic>().emptyGetTodayAppointmentList();
      if (Get.find<DashboardLogic>()
          .getTodayAppointmentModel
          .data!.results!
          .isNotEmpty) {

        for (var element in Get.find<DashboardLogic>()
            .getTodayAppointmentModel
            .data!.results!) {
          Get.find<DashboardLogic>()
              .updateGetTodayAppointmentList(element);
        }
        Get.find<DashboardLogic>()
            .updateGetTodayAppointmentLoader(false);
      } else {
        Get.find<DashboardLogic>()
            .updateGetTodayAppointmentLoader(false);
      }

      log('getMentorTodayAppointmentRepo ------>> ${Get.find<DashboardLogic>().getTodayAppointmentModel.success}');
    } else {
      Get.find<DashboardLogic>()
          .updateGetTodayAppointmentLoader(false);
    }
  } else if (!responseCheck) {

    Get.find<DashboardLogic>()
        .updateGetTodayAppointmentLoader(false);
    log('Exception........................');
  }
}

getAppointmentCountMentorRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<DashboardLogic>().getAppointmentCountMentorModel =
        GetAppointmentCountMentorModel.fromJson(response);
    Get.find<GeneralController>().updateFormLoaderController(false);
    if (Get.find<DashboardLogic>().getAppointmentCountMentorModel.status == true) {
      log('getAppointmentCountMentorRepo ------>> ${Get.find<DashboardLogic>().getAppointmentCountMentorModel.status}');
    } else {}
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

getRatingMentorRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<DashboardLogic>().getRatingsModel =
        GetRatingsModel.fromJson(response);
    Get.find<DashboardLogic>().updateRatingLoader(false);
    if (Get.find<DashboardLogic>().getRatingsModel.status == true) {
      log('get rating------>> ${Get.find<DashboardLogic>().getRatingsModel.status}');
    } else {}
  } else if (!responseCheck) {
    Get.find<DashboardLogic>().updateRatingLoader(false);

    log('Exception........................');
  }
}