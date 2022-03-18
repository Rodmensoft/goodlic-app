import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/book_appointment/model/get_date_schedule.dart';
import 'package:consultant_product/src/modules/user/book_appointment/model/get_schedule_available_days.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

getScheduleAvailableDaysRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BookAppointmentLogic>().getScheduleAvailableDays =
        GetScheduleAvailableDays.fromJson(response);
    Get.find<BookAppointmentLogic>().update();
    if (Get.find<BookAppointmentLogic>()
            .getScheduleAvailableDays
            .status
            .toString() ==
        'true') {
      List.generate(30, (index) {
        DateTime current = DateTime.now();

        for (var element in Get.find<BookAppointmentLogic>()
            .getScheduleAvailableDays
            .data!
            .mentorSchedules!) {
          if (intl.DateFormat('EEEE')
                  .format(DateTime.now().add(Duration(days: index)))
                  .toLowerCase() ==
              element.day) {
            // log('test ${element.day}');
            current = DateTime.now().add(Duration(days: index));
            Get.find<BookAppointmentLogic>()
                .availableScheduleDaysList!
                .add(current);
          }
        }
        // log('DAYS LIST ${Get.find<BookAppointmentLogic>().availableScheduleDaysList}');
      });

      Get.find<BookAppointmentLogic>().updateCalenderLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<BookAppointmentLogic>().updateCalenderLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<BookAppointmentLogic>().updateCalenderLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

getScheduleSlotsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BookAppointmentLogic>().getScheduleSlotsForUserModel =
        GetScheduleSlotsForUserModel.fromJson(response);
    if (Get.find<BookAppointmentLogic>().getScheduleSlotsForUserModel.status ==
        true) {
      Get.find<BookAppointmentLogic>()
          .updateGetScheduleSlotsForMenteeLoader(false);

      if (Get.find<BookAppointmentLogic>()
              .getScheduleSlotsForUserModel
              .data!
              .schedule !=
          null) {
        if (Get.find<BookAppointmentLogic>()
            .getScheduleSlotsForUserModel
            .data!
            .schedule!
            .scheduleSlots!
            .isNotEmpty) {
          for (var element in Get.find<BookAppointmentLogic>()
              .getScheduleSlotsForUserModel
              .data!
              .schedule!
              .scheduleSlots!) {
            if (element.isBooked == 0) {
              String? temp =
                  element.startTime!.replaceAll(' ', '').toUpperCase();
              DateTime date = intl.DateFormat("hh:mma").parse(temp);
              String dateFinal = intl.DateFormat("HH:mm").format(date);

              if (int.parse(dateFinal.substring(0, 2)) >= 01 &&
                  int.parse(dateFinal.substring(0, 2)) < 07) {
                // log('Hour Evening---->>>${dateFinal.substring(0,2)}');
                Get.find<BookAppointmentLogic>().updateEveningSlots(element);
              } else if (int.parse(dateFinal.substring(0, 2)) >= 07 &&
                  int.parse(dateFinal.substring(0, 2)) < 12) {
                // log('Hour Morning---->>>${dateFinal.substring(0,2)}');
                Get.find<BookAppointmentLogic>().updateMorningSlots(element);
              } else if (int.parse(dateFinal.substring(0, 2)) >= 12 &&
                  int.parse(dateFinal.substring(0, 2)) < 18) {
                // log('Hour AfterNoon---->>>${dateFinal.substring(0,2)}');
                Get.find<BookAppointmentLogic>().updateAfterNoonSlots(element);
              } else if (int.parse(dateFinal.substring(0, 2)) >= 18) {
                // log('Hour Evening---->>>${dateFinal.substring(0,2)}');
                Get.find<BookAppointmentLogic>().updateEveningSlots(element);
              }
            } else {
              log('BookedSlot--->>${element}');
            }
          }

          if (Get.find<BookAppointmentLogic>().morningSlots.isNotEmpty) {
            Get.find<BookAppointmentLogic>().updateAppointmentShiftType(0);
          } else if (Get.find<BookAppointmentLogic>()
              .afterNoonSlots
              .isNotEmpty) {
            Get.find<BookAppointmentLogic>().updateAppointmentShiftType(1);
          } else if (Get.find<BookAppointmentLogic>().eveningSlots.isNotEmpty) {
            Get.find<BookAppointmentLogic>().updateAppointmentShiftType(2);
          }
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: 'INFO!'.tr,
                  titleColor: customDialogInfoColor,
                  descriptions: 'Record Not Found',
                  text: 'ok'.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_Info.svg',
                );
              });
        }
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'INFO!'.tr,
                titleColor: customDialogInfoColor,
                descriptions: 'Record Not Found',
                text: 'ok'.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_Info.svg',
              );
            });
      }

      log('getScheduleSlotsRepo ------>> ${Get.find<BookAppointmentLogic>().getScheduleSlotsForUserModel.success}');
    } else {
      Get.find<BookAppointmentLogic>()
          .updateGetScheduleSlotsForMenteeLoader(false);
    }
  } else {
    Get.find<BookAppointmentLogic>()
        .updateGetScheduleSlotsForMenteeLoader(false);
    log('Exception........................');
  }
}