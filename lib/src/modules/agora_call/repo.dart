import 'dart:developer';

import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/agora_call/get_agora_token_model.dart';
import 'package:consultant_product/src/modules/agora_call/get_fcm_token_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getAgoraTokenRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getAgoraTokenModel =
        GetAgoraTokenModel.fromJson(response);
    if (Get.find<GeneralController>().getAgoraTokenModel.status == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.find<GeneralController>().updateCallerType(1);
      log('getAgoraTokenRepo ------>> ${Get.find<GeneralController>().getAgoraTokenModel.success}');
      if (Get.find<GeneralController>().goForCall!) {
        Get.find<GeneralController>().updateTokenForCall(
            Get.find<GeneralController>().getAgoraTokenModel.data!.token);

        ///---make-notification
        Get.find<GeneralController>().updateNotificationBody(
            'CALLING.....',
            'Your ${Get.find<GeneralController>().storageBox.read('userRole')} is calling you',
            '/videoCall',
            '/appointment-detail/${Get.find<GeneralController>().appointmentIdForSendNotification}'
                '?auth_tocken=${Get.find<GeneralController>().getAgoraTokenModel.data!.token}'
                '&channel_name=${Get.find<GeneralController>().channelForCall}','ring_ring');
        getMethod(
            context,
            fcmGetUrl,
            {
              'token': '123',
              'user_id': Get.find<GeneralController>().userIdForSendNotification
            },
            true,
            getFcmTokenRepo);

        Get.offNamed(PageRoutes.videoCall);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
getAgoraTokenForAudioRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getAgoraTokenModel =
        GetAgoraTokenModel.fromJson(response);
    if (Get.find<GeneralController>().getAgoraTokenModel.status == true) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.find<GeneralController>().updateCallerType(1);
      log('getAgoraTokenForAudioRepo ------>> ${Get.find<GeneralController>().getAgoraTokenModel.success}');
      if (Get.find<GeneralController>().goForCall!) {
        Get.find<GeneralController>().updateTokenForCall(
            Get.find<GeneralController>().getAgoraTokenModel.data!.token);

        ///---make-notification
        Get.find<GeneralController>().updateNotificationBody(
            'CALLING.....',
            'Your ${Get.find<GeneralController>().storageBox.read('userRole')} is calling you',
            '/audioCall',
            '/appointment-detail/${Get.find<GeneralController>().appointmentIdForSendNotification}'
                '?auth_tocken=${Get.find<GeneralController>().getAgoraTokenModel.data!.token}'
                '&channel_name=${Get.find<GeneralController>().channelForCall}','ring_ring');
        getMethod(
            context,
            fcmGetUrl,
            {
              'token': '123',
              'user_id': Get.find<GeneralController>().userIdForSendNotification
            },
            true,
            getFcmTokenRepo);

        Get.offNamed(PageRoutes.audioCall);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

updateFcmTokenRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      log('<<----FCM UPDATED SUCCESSFULLY---->>');
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

getFcmTokenRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getFcmTokenModel =
        GetFcmTokenModel.fromJson(response);
    if (Get.find<GeneralController>().getFcmTokenModel.status == true) {
      for (var element in Get.find<GeneralController>()
          .getFcmTokenModel
          .data!
          .tokens!) {
        postMethod(
            context,
            fcmService,
            {
              'notification': <String, dynamic>{
                'body': Get.find<GeneralController>().notificationBody,
                'title': Get.find<GeneralController>().notificationTitle,
                'sound': Get.find<GeneralController>().sound,
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "data": Get.find<GeneralController>().notificationRouteWeb,
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'sound': Get.find<GeneralController>().sound,
                'routeApp': Get.find<GeneralController>().notificationRouteApp,
                'channel': Get.find<GeneralController>().channelForCall,
                'channel_token': Get.find<GeneralController>().tokenForCall,
              },
              'to': element.deviceKey
              // 'to': 'dE6d0GSgSo2a0Xzrit9Y2L:APA91bH0AkbyEduFL2VK_SPFakObDXzIiGnne0Q9cs0ZgeSCTdbhszMYa9or6o-yx0Xw_D7bEtInDqs95x7_'
              //     '_kNL-IMWetZqAyNT_INvTMoNFp6_5qLlkACduyxzjCQxZui16IN47Y8M',
            },
            false,
            method1);
      }
    } else {
      log('----->>else');
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

method1(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  log('---->>> NotificationResponse $response');
  if (response['success'].toString() == '1') {}
}
