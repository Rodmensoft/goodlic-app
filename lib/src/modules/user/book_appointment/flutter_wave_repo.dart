import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/book_appointment/model_flutter_wave.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_confirmation.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

flutterWaveRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BookAppointmentLogic>().modelFlutterWave =
        ModelFlutterWave.fromJson(response);

    Get.find<GeneralController>().updateFormLoaderController(false);

    if (Get.find<BookAppointmentLogic>().modelFlutterWave.status == true) {
      Get.to(const AppointmentConfirmationView());
    } else {
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
