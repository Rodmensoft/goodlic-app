import 'package:consultant_product/src/modules/user/my_appointment/model_get_user_appointment.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'modal_get_appointment_detail.dart';
import 'state.dart';

class AppointmentDetailLogic extends GetxController {
  final AppointmentDetailState state = AppointmentDetailState();
  // ModalGetAppointmentDetail getAppointmentDetailModel =
  //     ModalGetAppointmentDetail();
  // bool? getAppointmentDetailLoader = true;
  // updateGetAppointmentDetailLoader(bool? newValue) {
  //   getAppointmentDetailLoader = newValue;
  //   update();
  // }

  UserAppointmentsData selectedAppointmentData = UserAppointmentsData();
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
