import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/login/logic.dart';
import 'package:consultant_product/src/modules/login/model.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

loginWithEmailRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<LoginLogic>().loginModel = LoginModel.fromJson(response);
    if (Get.find<LoginLogic>().loginModel.status.toString() == 'true') {
      Get.find<GeneralController>()
          .storageBox
          .write('authToken', Get.find<LoginLogic>().loginModel.accessToken);
      Get.find<GeneralController>()
          .storageBox
          .write('userID', Get.find<LoginLogic>().loginModel.data!.user!.id);

      if (Get.find<LoginLogic>().loginModel.data!.role == 'Mentee') {
        Get.find<GeneralController>()
            .storageBox
            .write('userRole', Get.find<LoginLogic>().loginModel.data!.role);

        Get.find<GeneralController>().updateFormLoaderController(false);
        Get.offAllNamed(PageRoutes.userHome);
      } else {
        Get.find<GeneralController>()
            .storageBox
            .write('userRole', Get.find<LoginLogic>().loginModel.data!.role);

        Get.find<GeneralController>().updateFormLoaderController(false);
        Get.offAllNamed(PageRoutes.consultantDashboard);
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.failed.tr,
              titleColor: customDialogErrorColor,
              descriptions: '${Get.find<LoginLogic>().loginModel.msg}',
              text: LanguageConstant.ok.tr,
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
            title: LanguageConstant.failed.tr,
            titleColor: customDialogErrorColor,
            descriptions: '${LanguageConstant.tryAgain.tr}!',
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
  }
}
