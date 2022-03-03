import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/my_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/my_appointment/model_get_user_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getUserAllAppointmentsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MyAppointmentLogic>().getUserAppointmentModel =
        GetUserAppointmentModel.fromJson(response);
    Get.find<MyAppointmentLogic>().update();
    if (Get.find<MyAppointmentLogic>()
            .getUserAppointmentModel
            .status
            .toString() ==
        'true') {



      Get.find<MyAppointmentLogic>().updateGetUserAppointmentLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<MyAppointmentLogic>().updateGetUserAppointmentLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<MyAppointmentLogic>().updateGetUserAppointmentLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
