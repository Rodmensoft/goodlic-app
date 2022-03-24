import 'package:consultant_product/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class ConsultantAppointmentDetailLogic extends GetxController {
  final ConsultantAppointmentDetailState state = ConsultantAppointmentDetailState();

  ConsultantAppointmentsData selectedAppointmentData = ConsultantAppointmentsData();
  int? appointmentStatus;

  List<Color> colorForAppointmentTypes = [
    customOrangeColor,
    customLightThemeColor,
    customGreenColor,
    customRedColor,
  ];
  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
}
