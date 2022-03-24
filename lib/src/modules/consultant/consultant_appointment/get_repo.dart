import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getConsultantAllAppointmentsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<ConsultantAppointmentLogic>().getConsultantAppointmentModel =
        GetConsultantAppointmentModel.fromJson(response);
    Get.find<ConsultantAppointmentLogic>().update();
    if (Get.find<ConsultantAppointmentLogic>()
            .getConsultantAppointmentModel
            .status
            .toString() ==
        'true') {
      Get.find<ConsultantAppointmentLogic>().updateGetUserAppointmentLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<ConsultantAppointmentLogic>().updateGetUserAppointmentLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<ConsultantAppointmentLogic>().updateGetUserAppointmentLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

// getUserAllAppointmentsMoreRepo(
//     BuildContext context, bool responseCheck, Map<String, dynamic> response) {
//   if (responseCheck) {
//     Get.find<ConsultantAppointmentLogic>().getUserAppointmentModelMore =
//         GetUserAppointmentModelMore.fromJson(response);
//     Get.find<ConsultantAppointmentLogic>().update();
//     if (Get.find<ConsultantAppointmentLogic>()
//             .getUserAppointmentModelMore
//             .status
//             .toString() ==
//         'true') {
//       if (Get.find<ConsultantAppointmentLogic>()
//           .getUserAppointmentModelMore
//           .data!
//           .appointments!
//           .data!
//           .isNotEmpty) {
//         if (Get.find<ConsultantAppointmentLogic>()
//                 .getUserAppointmentModelMore
//                 .data!
//                 .appointments!
//                 .data![0]
//                 .appointmentStatus ==
//             0) {
//           Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModel
//                   .data!
//                   .pendingAppointments!
//                   .currentPage =
//               Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModelMore
//                   .data!
//                   .appointments!
//                   .currentPage;
//           Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModel
//                   .data!
//                   .pendingAppointments!
//                   .lastPage =
//               Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModelMore
//                   .data!
//                   .appointments!
//                   .lastPage;
//           for (var element in Get.find<ConsultantAppointmentLogic>()
//               .getUserAppointmentModelMore
//               .data!
//               .appointments!
//               .data!) {
//             Get.find<ConsultantAppointmentLogic>()
//                 .getUserAppointmentModel
//                 .data!
//                 .pendingAppointments!
//                 .data!
//                 .add(element);
//           }
//         } else if (Get.find<ConsultantAppointmentLogic>()
//                 .getUserAppointmentModelMore
//                 .data!
//                 .appointments!
//                 .data![0]
//                 .appointmentStatus ==
//             1) {
//           Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModel
//                   .data!
//                   .acceptedAppointments!
//                   .currentPage =
//               Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModelMore
//                   .data!
//                   .appointments!
//                   .currentPage;
//           Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModel
//                   .data!
//                   .acceptedAppointments!
//                   .lastPage =
//               Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModelMore
//                   .data!
//                   .appointments!
//                   .lastPage;
//           for (var element in Get.find<ConsultantAppointmentLogic>()
//               .getUserAppointmentModelMore
//               .data!
//               .appointments!
//               .data!) {
//             Get.find<ConsultantAppointmentLogic>()
//                 .getUserAppointmentModel
//                 .data!
//                 .acceptedAppointments!
//                 .data!
//                 .add(element);
//           }
//         } else if (Get.find<ConsultantAppointmentLogic>()
//                 .getUserAppointmentModelMore
//                 .data!
//                 .appointments!
//                 .data![0]
//                 .appointmentStatus ==
//             2) {
//           Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModel
//                   .data!
//                   .completedAppointments!
//                   .currentPage =
//               Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModelMore
//                   .data!
//                   .appointments!
//                   .currentPage;
//           Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModel
//                   .data!
//                   .completedAppointments!
//                   .lastPage =
//               Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModelMore
//                   .data!
//                   .appointments!
//                   .lastPage;
//           for (var element in Get.find<ConsultantAppointmentLogic>()
//               .getUserAppointmentModelMore
//               .data!
//               .appointments!
//               .data!) {
//             Get.find<ConsultantAppointmentLogic>()
//                 .getUserAppointmentModel
//                 .data!
//                 .completedAppointments!
//                 .data!
//                 .add(element);
//           }
//         } else if (Get.find<ConsultantAppointmentLogic>()
//                 .getUserAppointmentModelMore
//                 .data!
//                 .appointments!
//                 .data![0]
//                 .appointmentStatus ==
//             3) {
//           Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModel
//                   .data!
//                   .cancelledAppointments!
//                   .currentPage =
//               Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModelMore
//                   .data!
//                   .appointments!
//                   .currentPage;
//           Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModel
//                   .data!
//                   .cancelledAppointments!
//                   .lastPage =
//               Get.find<ConsultantAppointmentLogic>()
//                   .getUserAppointmentModelMore
//                   .data!
//                   .appointments!
//                   .lastPage;
//           for (var element in Get.find<ConsultantAppointmentLogic>()
//               .getUserAppointmentModelMore
//               .data!
//               .appointments!
//               .data!) {
//             Get.find<ConsultantAppointmentLogic>()
//                 .getUserAppointmentModel
//                 .data!
//                 .cancelledAppointments!
//                 .data!
//                 .add(element);
//           }
//         }
//       }
//
//       Get.find<ConsultantAppointmentLogic>().update();
//
//       Get.find<ConsultantAppointmentLogic>().updateGetUserAppointmentMoreLoader(false);
//       Get.find<GeneralController>().updateFormLoaderController(false);
//     } else {
//       Get.find<ConsultantAppointmentLogic>().updateGetUserAppointmentMoreLoader(false);
//       Get.find<GeneralController>().updateFormLoaderController(false);
//     }
//   } else if (!responseCheck) {
//     Get.find<ConsultantAppointmentLogic>().updateGetUserAppointmentMoreLoader(false);
//     Get.find<GeneralController>().updateFormLoaderController(false);
//
//     log('Exception........................');
//   }
// }
