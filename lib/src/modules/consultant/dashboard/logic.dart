import 'package:consultant_product/src/modules/consultant/dashboard/model_approval_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class DashboardLogic extends GetxController {
  final DashboardState state = DashboardState();

  bool? getTodayAppointmentLoader = true;
  MentorApprovalCheckModel mentorApprovalCheckModel = MentorApprovalCheckModel();

  updateGetTodayAppointmentLoader(bool? newValue) {
    getTodayAppointmentLoader = newValue;
    update();
  }

  List getTodayAppointmentList = [];

  emptyGetTodayAppointmentList() {
    getTodayAppointmentList = [];
    update();
  }

  /// rating loader

  bool ratingLoader = true;
  updateRatingLoader(bool value) {
    ratingLoader = value;
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


  bool? approvalCheckerApiLoader = true;

  updateApprovalCheckerApiLoader(bool? newValue) {
    approvalCheckerApiLoader = newValue;
    update();
  }
  bool? approvalCheckerApiStopLoader = false;
  updateApprovalCheckerApiStopLoader(bool? newValue) {
    approvalCheckerApiStopLoader = newValue;
    update();
  }
}
