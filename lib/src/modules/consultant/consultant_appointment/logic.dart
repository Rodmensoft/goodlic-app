import 'package:consultant_product/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class ConsultantAppointmentLogic extends GetxController {
  final ConsultantAppointmentState state = ConsultantAppointmentState();



  late TabController tabController;

  GetConsultantAppointmentModel getConsultantAppointmentModel = GetConsultantAppointmentModel();


  bool? getUserAppointmentLoader = true;
  updateGetUserAppointmentLoader(bool? newValue){
    getUserAppointmentLoader = newValue;
    update();
  }
  bool? getUserAppointmentMoreLoader = false;
  updateGetUserAppointmentMoreLoader(bool? newValue){
    getUserAppointmentMoreLoader = newValue;
    update();
  }


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

  List<Tab> tabBarList = const [
    Tab( text: "Pending",),
    Tab( text: "Accepted",),
    Tab( text: "Completed"),
    Tab( text: "Cancelled"),
  ];

  List imagesForAppointmentTypes = [
    ///---audio
    'assets/Icons/audio.svg',

    ///---video
    'assets/Icons/videoCallIcon.svg',

    ///---chat
    'assets/Icons/chatIcon.svg',

    ///---on-site
    'assets/Icons/physicalIcon.svg',

    ///---home-visit
    'assets/Icons/house-fill.svg',
  ];

}
