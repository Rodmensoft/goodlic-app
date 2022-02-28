import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/sign_up/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

signUpWithEmailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    if (response['Status'].toString() == 'true') {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'SUCCESS!',
              titleColor: customDialogSuccessColor,
              descriptions: 'Lets Login',
              text: 'OK'.tr,
              functionCall: () {
                Navigator.pop(context);
                Get.back();
              },
              img: 'assets/Icons/dialog_success.svg',
            );
          });
    } else {
      if (response['errors'].containsKey('email')) {
        Get.find<SignUpLogic>().emailValidator = response['errors']['email'][0];
        Get.find<SignUpLogic>().update();
      }
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'FAILED!',
            titleColor: customDialogErrorColor,
            descriptions: 'Try Again!',
            text: 'OK'.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
    log('Exception........................');
  }
}
