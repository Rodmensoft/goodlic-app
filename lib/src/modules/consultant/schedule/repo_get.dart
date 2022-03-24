import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/schedule/logic.dart';
import 'package:consultant_product/src/modules/consultant/schedule/model_get_appointment_types.dart';
import 'package:consultant_product/src/modules/consultant/schedule/model_get_available_days.dart';
import 'package:consultant_product/src/modules/consultant/schedule/model_get_schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getAppointmentTypesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MentorScheduleLogic>().getAppointmentTypesModel =
        GetAppointmentTypesModel.fromJson(response);
    if (Get.find<MentorScheduleLogic>().getAppointmentTypesModel.status ==
        true) {
      ///---appointment-types
      Get.find<MentorScheduleLogic>().emptyScheduleTypeDropDownList();
      Get.find<MentorScheduleLogic>()
          .getAppointmentTypesModel
          .data!
          .appointmenttype!
          .forEach((element) {
            if(element.name!.toUpperCase() != 'LIVE'){
              Get.find<MentorScheduleLogic>()
                  .updateScheduleTypeDropDownList(element.name!.toUpperCase());
            }

      });

      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getAppointmentTypesRepo ------>> ${Get.find<MentorScheduleLogic>().getAppointmentTypesModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

getAvailableDaysRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MentorScheduleLogic>().getAvailableDaysModel =
        GetAvailableDaysModel.fromJson(response);
    if (Get.find<MentorScheduleLogic>().getAvailableDaysModel.status == true) {
      ///---available-days-list
      Get.find<MentorScheduleLogic>().emptyAvailableDaysList();
      Get.find<MentorScheduleLogic>()
          .getAvailableDaysModel
          .data!
          .mentorSchedules!
          .forEach((element) {
        if (element.isHoliday == 0) {
          Get.find<MentorScheduleLogic>()
              .updateAvailableDaysList(element.day!.toUpperCase());
          Get.find<MentorScheduleLogic>()
              .dayListForHoliday[Get.find<MentorScheduleLogic>()
              .getAvailableDaysModel
              .data!
              .mentorSchedules!
              .indexOf(element)]
              .isSelected = false;
        } else {
          Get.find<MentorScheduleLogic>()
              .dayListForHoliday[Get.find<MentorScheduleLogic>()
                  .getAvailableDaysModel
                  .data!
                  .mentorSchedules!
                  .indexOf(element)]
              .isSelected = true;
        }
      });

      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getAvailableDaysRepo ------>> ${Get.find<MentorScheduleLogic>().getAvailableDaysModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

getMentorScheduleRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MentorScheduleLogic>().getMentorScheduleModel =
        GetMentorScheduleModel.fromJson(response);
    if (Get.find<MentorScheduleLogic>().getMentorScheduleModel.status == true) {

      Get.find<MentorScheduleLogic>().emptyForDisplayWithoutScheduleList();
      Get.find<MentorScheduleLogic>().getMentorScheduleModel.data!.mentorWithoutSchedule!.forEach((element) {
        Get.find<MentorScheduleLogic>().updateForDisplayWithoutScheduleList(element);
      });

      Get.find<MentorScheduleLogic>().emptyForDisplayScheduleList();
      Get.find<MentorScheduleLogic>().getMentorScheduleModel.data!.mentorSchedules!.forEach((element) {
        if(element.scheduleSlots!.isNotEmpty){
          Get.find<MentorScheduleLogic>().updateForDisplayScheduleList(element);
        }
      });

      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getMentorScheduleRepo ------>> ${Get.find<MentorScheduleLogic>().getMentorScheduleModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
