import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/my_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/my_appointment/model_get_user_appointment.dart';
import 'package:consultant_product/src/modules/user/my_appointment/model_get_user_appointment_more.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getUserAllAppointmentsRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MyAppointmentLogic>().getUserAppointmentModel = GetUserAppointmentModel.fromJson(response);
    Get.find<MyAppointmentLogic>().update();
    if (Get.find<MyAppointmentLogic>().getUserAppointmentModel.status.toString() == 'true') {
      Get.find<MyAppointmentLogic>().updateRefreshController();
      Get.find<MyAppointmentLogic>().updateGetUserAppointmentLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<MyAppointmentLogic>().updateRefreshController();
      Get.find<MyAppointmentLogic>().updateGetUserAppointmentLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
    return;
  }
  // Get.find<MyAppointmentLogic>().updateRefreshController();
  Get.find<MyAppointmentLogic>().updateGetUserAppointmentLoader(false);
  Get.find<GeneralController>().updateFormLoaderController(false);
}

getUserAllAppointmentsMoreRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MyAppointmentLogic>().getUserAppointmentModelMore = GetUserAppointmentModelMore.fromJson(response);
    Get.find<MyAppointmentLogic>().update();
    if (Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.status.toString() == 'true') {
      if (Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data!.isNotEmpty) {
        if (Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data![0].appointmentStatus == 0) {
          Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.pendingAppointments!.currentPage =
              Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.currentPage;
          Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.pendingAppointments!.lastPage =
              Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.lastPage;
          for (var element in Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data!) {
            Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.pendingAppointments!.data!.add(element);
          }
        } else if (Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data![0].appointmentStatus ==
            1) {
          Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.acceptedAppointments!.currentPage =
              Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.currentPage;
          Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.acceptedAppointments!.lastPage =
              Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.lastPage;
          for (var element in Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data!) {
            Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.acceptedAppointments!.data!.add(element);
          }
        } else if (Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data![0].appointmentStatus ==
            2) {
          Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.completedAppointments!.currentPage =
              Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.currentPage;
          Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.completedAppointments!.lastPage =
              Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.lastPage;
          for (var element in Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data!) {
            Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.completedAppointments!.data!.add(element);
          }
        } else if (Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data![0].appointmentStatus ==
            3) {
          Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.cancelledAppointments!.currentPage =
              Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.currentPage;
          Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.cancelledAppointments!.lastPage =
              Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.lastPage;
          for (var element in Get.find<MyAppointmentLogic>().getUserAppointmentModelMore.data!.appointments!.data!) {
            Get.find<MyAppointmentLogic>().getUserAppointmentModel.data!.cancelledAppointments!.data!.add(element);
          }
        }
      }

      Get.find<MyAppointmentLogic>().update();

      Get.find<MyAppointmentLogic>().updateRefreshController();
      Get.find<MyAppointmentLogic>().updateGetUserAppointmentMoreLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<MyAppointmentLogic>().updateRefreshController();
      Get.find<MyAppointmentLogic>().updateGetUserAppointmentMoreLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<MyAppointmentLogic>().updateRefreshController();
    Get.find<MyAppointmentLogic>().updateGetUserAppointmentMoreLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
