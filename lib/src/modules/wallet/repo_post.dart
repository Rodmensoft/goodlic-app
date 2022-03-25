import 'dart:developer';

import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/wallet/repo_get.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


depositTransactionJazzcashRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getWalletBalanceUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getWalletBalanceRepo);
      getMethod(
          context,
          getWalletTransactionUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getWalletTransactionRepo);
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.back();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'success!'.tr,
              titleColor: customDialogSuccessColor,
              descriptions: '${'amount_added_successfully'.tr}!',
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_success.svg',
            );
          });
      log('depositTransactionJazzcashRepo ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: '${response['msg']}',
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else {
    Get.find<GeneralController>().updateFormLoaderController(false);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'failed!'.tr,
            titleColor: customDialogErrorColor,
            descriptions: 'try_again!'.tr,
            text: 'ok'.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/dialog_error.svg',
          );
        });
  }
}
withdrawTransactionRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getWalletBalanceUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getWalletBalanceRepo);
      getMethod(
          context,
          getWalletTransactionUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getWalletTransactionRepo);
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar('success!'.tr, response['msg'].toString(),
          colorText: Colors.black,
          backgroundColor: customThemeColor.withOpacity(0.5));
      log('depositTransactionJazzcashRepo ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      Get.snackbar('failed!'.tr, response['msg'].toString(),
          colorText: Colors.black,
          backgroundColor: customThemeColor.withOpacity(0.5));
    }
  } else {
    Get.find<GeneralController>().updateFormLoaderController(false);
    Get.snackbar('failed!'.tr, 'try_again!'.tr,
        colorText: Colors.black,
        backgroundColor: customThemeColor.withOpacity(0.5));

  }
}
