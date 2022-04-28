import 'dart:developer';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/agora_call/repo.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/get_repo.dart';
import 'package:consultant_product/src/modules/sms/logic.dart';
import 'package:consultant_product/src/modules/sms/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mentorCompleteAppointmentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getConsultantAllAppointmentsURL,
          {
            'token': '123',
            'mentor_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getConsultantAllAppointmentsRepo);

      ///----send-sms
      postMethod(
          context,
          sendSMSUrl,
          {
            'token': '123',
            'phone': Get.find<SmsLogic>().phoneNumber,
            'message': Get.find<GeneralController>().notificationTitle,
          },
          true,
          sendSMSRepo);

      ///----fcm-send-start
      getMethod(
          context,
          fcmGetUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().userIdForSendNotification
          },
          true,
          getFcmTokenRepo);
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar(LanguageConstant.appointmentCompletedSuccessfully.tr, '',
          colorText: Colors.black, backgroundColor: Colors.white);
      log('mentorChangeAppointmentStatusRepo ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    log('Exception........................');
  }
}

mentorAcceptAppointmentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getConsultantAllAppointmentsURL,
          {
            'token': '123',
            'mentor_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getConsultantAllAppointmentsRepo);

      ///----send-sms
      postMethod(
          context,
          sendSMSUrl,
          {
            'token': '123',
            'phone': Get.find<SmsLogic>().phoneNumber,
            'message': Get.find<GeneralController>().notificationTitle,
          },
          true,
          sendSMSRepo);

      ///----fcm-send-start
      getMethod(
          context,
          fcmGetUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().userIdForSendNotification
          },
          true,
          getFcmTokenRepo);

      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar(LanguageConstant.appointmentAcceptedSuccessfully.tr, '',
          colorText: Colors.black, backgroundColor: Colors.white);
      log('mentorChangeAppointmentStatusRepo ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    log('Exception........................');
  }
}

mentorRejectAppointmentRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getConsultantAllAppointmentsURL,
          {
            'token': '123',
            'mentor_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getConsultantAllAppointmentsRepo);

      ///----send-sms
      postMethod(
          context,
          sendSMSUrl,
          {
            'token': '123',
            'phone': Get.find<SmsLogic>().phoneNumber,
            'message': Get.find<GeneralController>().notificationTitle,
          },
          true,
          sendSMSRepo);

      ///----fcm-send-start
      getMethod(
          context,
          fcmGetUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().userIdForSendNotification
          },
          true,
          getFcmTokenRepo);
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar(LanguageConstant.appointmentRejectedSuccessfully.tr, '',
          colorText: Colors.black, backgroundColor: Colors.white);
      log('mentorChangeAppointmentStatusRepo ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    log('Exception........................');
  }
}
