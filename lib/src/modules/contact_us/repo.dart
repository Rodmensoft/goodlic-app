import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/contact_us/logic.dart';
import 'package:consultant_product/src/modules/contact_us/model.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

contactUsRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<ContactUsLogic>().contactUsModel =
        ContactUsModel.fromJson(response);

    Get.find<GeneralController>().updateFormLoaderController(false);

    if (Get.find<ContactUsLogic>().contactUsModel.status == true) {

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'success!'.tr,
              titleColor: customDialogSuccessColor,
              descriptions: 'mail_sent_successfully'.tr,
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
                Get.back();
              },
              img: 'assets/Icons/dialog_success.svg',
            );
          });
      log('contactUsRepo ------>> ${Get.find<ContactUsLogic>().contactUsModel.success}');
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
