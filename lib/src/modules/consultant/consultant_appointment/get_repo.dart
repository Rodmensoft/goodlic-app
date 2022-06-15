import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getConsultantAllAppointmentsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  log('testing it please $response');
  if (responseCheck) {
    Get.find<ConsultantAppointmentLogic>().getConsultantAppointmentModel =
        GetConsultantAppointmentModel.fromJson(response);
    Get.find<ConsultantAppointmentLogic>().update();
    if (Get.find<ConsultantAppointmentLogic>()
            .getConsultantAppointmentModel
            .status
            .toString() ==
        'true') {
      Get.find<ConsultantAppointmentLogic>().updateRefreshController();
      Get.find<ConsultantAppointmentLogic>()
          .updateGetUserAppointmentLoader(false);

      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<ConsultantAppointmentLogic>().updateRefreshController();
      Get.find<ConsultantAppointmentLogic>()
          .updateGetUserAppointmentLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<ConsultantAppointmentLogic>().updateRefreshController();
    Get.find<ConsultantAppointmentLogic>()
        .updateGetUserAppointmentLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
