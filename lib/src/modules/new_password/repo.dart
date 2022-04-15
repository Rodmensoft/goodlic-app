import 'dart:developer';

import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/new_password/logic.dart';
import 'package:consultant_product/src/modules/new_password/model.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

newPasswordRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<NewPasswordLogic>().newPasswordModel =
        NewPasswordModel.fromJson(response);

    Get.find<GeneralController>().updateFormLoaderController(false);

    if (Get.find<NewPasswordLogic>().newPasswordModel.status == true) {
      Get.toNamed(PageRoutes.createdPassword);
      // showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (BuildContext context) {
      //       return CustomDialogBox(
      //         title: 'success!'.tr,
      //         titleColor: customDialogSuccessColor,
      //         descriptions: 'mail_sent_successfully'.tr,
      //         text: 'ok'.tr,
      //         functionCall: () {
      //           Navigator.pop(context);
      //           Get.back();
      //         },
      //         img: 'assets/Icons/dialog_success.svg',
      //       );
      //     });
      log('newPasswordRepo ------>> ${Get.find<NewPasswordLogic>().newPasswordModel.success}');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: 'try_again!'.tr,
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'failed!'.tr,
            titleColor: customDialogErrorColor,
            descriptions: 'try_again!'.tr,
            text: 'ok'.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
    log('Exception........................');
  }
}
