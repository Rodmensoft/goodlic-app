import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/chat/logic.dart';
import 'package:consultant_product/src/modules/user/my_appointment/model_get_user_appointment.dart';
import 'package:consultant_product/src/modules/user/ratings/rating_existance_model.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class AppointmentDetailLogic extends GetxController {
  final AppointmentDetailState state = AppointmentDetailState();

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

  chatOnTap(BuildContext context) {
    Get.find<ChatLogic>().userName = '${selectedAppointmentData.mentor!.firstName} '
        '${selectedAppointmentData.mentor!.lastName}';
    Get.find<ChatLogic>().userEmail = selectedAppointmentData.mentor!.email;
    Get.find<ChatLogic>().userImage = selectedAppointmentData.mentor!.imagePath;
    Get.find<ChatLogic>().updateGetMessagesLoader(true);
    Get.find<ChatLogic>().updateSenderMessageGetId(
        Get.find<GeneralController>().storageBox.read('userID'));
    Get.find<ChatLogic>()
        .updateReceiverMessageGetId(selectedAppointmentData.mentorId);
    Get.toNamed(PageRoutes.chatScreen);
  }


  RatingExistModel ratingExistModel = RatingExistModel();
  bool? getRatingDataController = true;

  updateGetRatingDataController(bool value) {
    getRatingDataController = value;
    update();
  }
  bool? isRated = false;
}
