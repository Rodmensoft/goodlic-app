import 'package:consultant_product/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/get_ratings_model.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/model_all_appointment.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/model_approval_check.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/model_get_appointment_count_mentor.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/model_get_today_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class DashboardLogic extends GetxController {
  final DashboardState state = DashboardState();
  GetTodayAppointmentModel getTodayAppointmentModel =
      GetTodayAppointmentModel();
  GetRatingsModel getRatingsModel = GetRatingsModel();
  GetAppointmentCountMentorModel getAppointmentCountMentorModel =
      GetAppointmentCountMentorModel();

  TextEditingController searchController = TextEditingController();
  TextEditingController addChargesForGoLiveController = TextEditingController();

  bool? getTodayAppointmentLoader = true;
  MentorApprovalCheckModel mentorApprovalCheckModel =
      MentorApprovalCheckModel();

  updateGetTodayAppointmentLoader(bool? newValue) {
    getTodayAppointmentLoader = newValue;
    update();
  }

  List<ConsultantAppointmentsData> getTodayAppointmentList = [];

  updateGetTodayAppointmentList(
      ConsultantAppointmentsData mentorSingleAppointmentModel) {
    getTodayAppointmentList.add(mentorSingleAppointmentModel);
    update();
  }

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
