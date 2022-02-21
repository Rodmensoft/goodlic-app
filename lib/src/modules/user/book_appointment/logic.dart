import 'package:consultant_product/src/modules/user/consultant_profile/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class BookAppointmentLogic extends GetxController {
  final BookAppointmentState state = BookAppointmentState();

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

///----app-bar-settings-----end


  List<AppointmentTypesCustomClass> appointmentTypes = [
    AppointmentTypesCustomClass(
        title: 'Video Appointment',
        image: 'assets/Icons/videoCallIcon.svg',
      fee: '\$25'
    ),
    AppointmentTypesCustomClass(
        title: 'Online Chat',
        image: 'assets/Icons/chatIcon.svg',
        fee: '\$15'

    ),
    AppointmentTypesCustomClass(
        title: 'Physical Appointment',
        image: 'assets/Icons/physicalIcon.svg',
        fee: '\$53'
    ),
  ];
}
