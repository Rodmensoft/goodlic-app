import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/appointment_detail/logic.dart';
import 'package:consultant_product/src/modules/user/appointment_detail/modal_get_appointment_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getAppointmentDetailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<AppointmentDetailLogic>().getAppointmentDetailModel =
        ModalGetAppointmentDetail.fromJson(response);
    Get.find<AppointmentDetailLogic>().update();
    if (Get.find<AppointmentDetailLogic>()
            .getAppointmentDetailModel
            .status
            .toString() ==
        'true') {
      Get.find<AppointmentDetailLogic>()
          .updateGetAppointmentDetailLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<AppointmentDetailLogic>()
          .updateGetAppointmentDetailLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<AppointmentDetailLogic>().updateGetAppointmentDetailLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
