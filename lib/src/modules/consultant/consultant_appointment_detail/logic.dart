import 'dart:developer';

import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/agora_call/agora_logic.dart';
import 'package:consultant_product/src/modules/agora_call/repo.dart';
import 'package:consultant_product/src/modules/chat/logic.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'package:intl/intl.dart' as intl;
import 'state.dart';

class ConsultantAppointmentDetailLogic extends GetxController {
  final ConsultantAppointmentDetailState state =
      ConsultantAppointmentDetailState();

  ConsultantAppointmentsData selectedAppointmentData =
      ConsultantAppointmentsData();
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

  bool? showCallButton = false;

  Future<int> getDifference() async {
    log('---TIME-1-->>${DateTime.now().toString().substring(11, 19)}');
    log('---TIME-2-->>${intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse('${selectedAppointmentData.time.toString().substring(0, 5)}'
        '${selectedAppointmentData.time.toString().substring(5, 8).toUpperCase()}'))}');
    log('---TIME-3-->>${intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse('${selectedAppointmentData.endTime.toString().substring(0, 5)}'
        '${selectedAppointmentData.endTime.toString().substring(5, 8).toUpperCase()}'))}');

    String time1 = DateTime.now().toString().substring(11, 19);
    String time2 = intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse(
        '${selectedAppointmentData.time.toString().substring(0, 5)}'
        '${selectedAppointmentData.time.toString().substring(5, 8).toUpperCase()}'));
    String time3 = intl.DateFormat.Hms().format(intl.DateFormat('h:mm a').parse(
        '${selectedAppointmentData.endTime.toString().substring(0, 5)}'
        '${selectedAppointmentData.endTime.toString().substring(5, 8).toUpperCase()}'));

    // log('24-hrs--->>${intl.DateFormat.Hms().format(intl.DateFormat('h:mm a')
    //     .parse(
    //     '${selectedAppointmentData.endTime.toString().substring(0, 5)}'
    //         '${selectedAppointmentData.endTime.toString().substring(5, 8).toUpperCase()}'))}');
    intl.DateFormat dateFormat = intl.DateFormat("yyyy-MM-dd");

    var _date = dateFormat.format(DateTime.now());

    DateTime a = DateTime.parse('$_date $time1');
    DateTime b = DateTime.parse('${selectedAppointmentData.date} $time2');
    DateTime endDateTime =
        DateTime.parse('${selectedAppointmentData.date} $time3');

    log('a $a');
    log('b $a');
    log('EndDateTime $endDateTime');
    log('Comparison ${DateTime.now().isBefore(endDateTime)}');

    log("Min ${b.difference(a).inMinutes}");

    if ((b.difference(a).inMinutes <= 2) &&
        DateTime.now().isBefore(endDateTime)) {
      showCallButton = true;
      update();
    } else {
      showCallButton = false;

      update();
    }
    return b.difference(a).inMinutes;
  }

  chatOnTap(BuildContext context) {
    Get.find<ChatLogic>().userName = '${selectedAppointmentData.mentee!.firstName} '
        '${selectedAppointmentData.mentee!.lastName}';
    Get.find<ChatLogic>().userEmail = selectedAppointmentData.mentee!.email;
    Get.find<ChatLogic>().userImage = selectedAppointmentData.mentee!.imagePath;
    Get.find<ChatLogic>().updateGetMessagesLoader(true);
    Get.find<ChatLogic>().updateSenderMessageGetId(
        Get.find<GeneralController>().storageBox.read('userID'));
    Get.find<ChatLogic>()
        .updateReceiverMessageGetId(selectedAppointmentData.menteeId);
    Get.toNamed(PageRoutes.chatScreen);
  }


  videoOnTap(BuildContext context) {
    Get.find<AgoraLogic>().userName = '${selectedAppointmentData.mentee!.firstName} '
        '${selectedAppointmentData.mentee!.lastName}';
    Get.find<AgoraLogic>().userImage = selectedAppointmentData.mentee!.imagePath;
    Get.find<AgoraLogic>().update();
    Get.find<GeneralController>().updateSelectedChannel(
        Get.find<GeneralController>().getRandomString(10));
    Get.find<GeneralController>()
        .updateChannelForCall(Get.find<GeneralController>().selectedChannel);
    log('----------->>> ${Get.find<GeneralController>().selectedChannel}');
    getMethod(
        context,
        agoraTokenUrl,
        {
          'token': '123',
          'channel': Get.find<GeneralController>().selectedChannel
        },
        true,
        getAgoraTokenRepo);
    Get.find<GeneralController>().updateGoForCall(true);
    Get.toNamed(PageRoutes.videoCallWaiting);
  }

  audioOnTap(BuildContext context) {

    Get.find<AgoraLogic>().userName = '${selectedAppointmentData.mentee!.firstName} '
        '${selectedAppointmentData.mentee!.lastName}';
    Get.find<AgoraLogic>().userImage = selectedAppointmentData.mentee!.imagePath;
    Get.find<AgoraLogic>().update();
    Get.find<GeneralController>().updateSelectedChannel(
        Get.find<GeneralController>().getRandomString(10));
    Get.find<GeneralController>()
        .updateChannelForCall(Get.find<GeneralController>().selectedChannel);
    log('----------->>> ${Get.find<GeneralController>().selectedChannel}');
    getMethod(
        context,
        agoraTokenUrl,
        {
          'token': '123',
          'channel': Get.find<GeneralController>().selectedChannel
        },
        true,
        getAgoraTokenForAudioRepo);
    Get.find<GeneralController>().updateGoForCall(true);
    Get.toNamed(PageRoutes.videoCallWaiting);
  }
}
