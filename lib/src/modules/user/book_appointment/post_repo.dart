import 'dart:developer';
import 'dart:io';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/header.dart';
import 'package:consultant_product/src/api_services/logic.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/book_appointment/model/book_appointment.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bookAppointmentFileRepo(File file1, BuildContext context) async {
  dio_instance.FormData formData =
      dio_instance.FormData.fromMap(<String, dynamic>{
    'token': '123',
    'mentee_id': Get.find<GeneralController>().storageBox.read('userID'),
    'mentor_id': Get.find<UserHomeLogic>().selectedConsultantID,
    'payment':
        Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee,
    'payment_id': Get.find<BookAppointmentLogic>().selectedPaymentType,
    'appointment_type_id': Get.find<BookAppointmentLogic>()
        .selectMentorAppointmentType!
        .appointmentType!
        .id,
    'questions': Get.find<BookAppointmentLogic>().questionController.text,
    'type': 'question',
    'appointment_type_string': Get.find<BookAppointmentLogic>()
        .selectMentorAppointmentType!
        .appointmentType!
        .name,
    'book_file': await dio_instance.MultipartFile.fromFile(
      file1.path,
    )
  });
  dio_instance.Dio dio = dio_instance.Dio();
  setCustomHeader(dio, 'Authorization',
      'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
  dio_instance.Response response;
  try {
    log('postData--->> ${formData.fields}');
    response = await dio.post(bookAppointmentUrl, data: formData);
    log('StatusCode------>> ${response.statusCode}');
    log('Response $bookAppointmentUrl------>> ${response.data}');
    if (response.statusCode == 200) {
      Get.find<BookAppointmentLogic>().bookAppointmentModel =
          BookAppointmentModel.fromJson(response.data);
      Get.find<GeneralController>().updateFormLoaderController(false);
      if (Get.find<BookAppointmentLogic>().bookAppointmentModel.status ==
          true) {

        if (Get.find<BookAppointmentLogic>().selectedPaymentType == 0) {
          Get.find<GeneralController>().updateFormLoaderController(false);
          Get.toNamed(PageRoutes.paymentStripeView);
        } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 1) {
          Get.find<GeneralController>().updateFormLoaderController(false);
          Get.toNamed(PageRoutes.paymentStripeView);
        } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 2) {
          Get.find<GeneralController>().updateFormLoaderController(false);
          Get.toNamed(PageRoutes.walletPaymentScreen);
        } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 3) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: '${LanguageConstant.info.tr}!',
                  titleColor: customDialogInfoColor,
                  descriptions:
                      '${LanguageConstant.thisPaymentMethodIs.tr}\n${LanguageConstant.notAvailableYet.tr}',
                  text: LanguageConstant.ok.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_Info.svg',
                );
              });
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: '${LanguageConstant.info.tr}!',
                  titleColor: customDialogInfoColor,
                  descriptions:
                      '${LanguageConstant.thisPaymentMethodIs.tr}\n${LanguageConstant.notAvailableYet.tr}',
                  text: LanguageConstant.ok.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_Info.svg',
                );
              });
        }
        log('bookAppointmentRepo ------>> ${Get.find<BookAppointmentLogic>().bookAppointmentModel.success}');
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
        showDialog(
            context: context,
            barrierDismissible: false,
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
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          barrierDismissible: false,
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
  } on dio_instance.DioError catch (e) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    log('putResponseError---->> ${e}');
  }
}

bookAppointmentWithoutFileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BookAppointmentLogic>().bookAppointmentModel =
        BookAppointmentModel.fromJson(response);
    Get.find<GeneralController>().updateFormLoaderController(false);
    if (Get.find<BookAppointmentLogic>().bookAppointmentModel.status == true) {

      if (Get.find<BookAppointmentLogic>().selectedPaymentType == 0) {
        Get.find<GeneralController>().updateFormLoaderController(false);
        Get.toNamed(PageRoutes.paymentStripeView);

      } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 1) {
        Get.find<GeneralController>().updateFormLoaderController(false);
        Get.toNamed(PageRoutes.paymentStripeView);
      } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 2) {
        Get.find<GeneralController>().updateFormLoaderController(false);
        Get.toNamed(PageRoutes.paymentStripeView);
      } else if (Get.find<BookAppointmentLogic>().selectedPaymentType == 3) {
        Get.find<GeneralController>().updateFormLoaderController(false);
        Get.toNamed(PageRoutes.walletPaymentScreen);
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: '${LanguageConstant.info.tr}!',
                titleColor: customDialogInfoColor,
                descriptions:
                    '${LanguageConstant.thisPaymentMethodIs.tr}\n${LanguageConstant.notAvailableYet.tr}',
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_Info.svg',
              );
            });
      }

      log('bookAppointmentRepo ------>> ${Get.find<BookAppointmentLogic>().bookAppointmentModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          barrierDismissible: false,
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
  } else {
    Get.find<GeneralController>().updateFormLoaderController(false);

    showDialog(
        context: context,
        barrierDismissible: false,
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
