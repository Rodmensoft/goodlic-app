
import 'dart:developer';
import 'dart:io';
import 'package:consultant_product/src/api_services/header.dart';
import 'package:consultant_product/src/api_services/logic.dart';
import 'package:consultant_product/src/modules/user/edit_user_profile/logic.dart';
import 'package:dio/dio.dart' as dio_instance;

import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/home/get_repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

menteeUpdateProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      getMethod(
          context,
          getUserProfileURL,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'SUCCESS!'.tr,
              titleColor: customDialogSuccessColor,
              descriptions: 'Profile Updated Successfully',
              text: 'OK'.tr,
              functionCall: () {
                Navigator.pop(context);
                Get.back();
              },
              img: 'assets/Icons/dialog_success.svg',
            );
          });
      Get.find<GeneralController>().updateFormLoaderController(false);
      log('menteeUpdateProfileRepo ------>> ${response['Status'].toString()}');
    } else {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: 'Try Again!'.tr,
              text: 'OK'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'FAILED!'.tr,
            titleColor: customDialogErrorColor,
            descriptions: 'Try Again!'.tr,
            text: 'OK'.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

menteeUpdateProfileImageRepo(File? file1) async {
  dio_instance.FormData formData =
  dio_instance.FormData.fromMap(<String, dynamic>{
    'token': '123',
    'user_id': Get.find<GeneralController>().storageBox.read('userID'),
    'first_name': Get.find<EditUserProfileLogic>().firstNameController.text,
    'last_name': Get.find<EditUserProfileLogic>().lastNameController.text,
    'gender': Get.find<EditUserProfileLogic>().selectedGender,
    'country': Get.find<EditUserProfileLogic>()
        .menteeProfileGenericDataModel
        .data!
        .countries![Get.find<EditUserProfileLogic>()
        .countryDropDownList
        .indexOf(Get.find<EditUserProfileLogic>().selectedCountry!)]
        .id,
    'city': Get.find<EditUserProfileLogic>().selectedCity,
    'image': await dio_instance.MultipartFile.fromFile(
      file1!.path,
    )
  });
  dio_instance.Dio dio = dio_instance.Dio();
  setCustomHeader(dio, 'Authorization',
      'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
  dio_instance.Response response;
  try {
    log('postData--->> ${formData.fields}');

    response = await dio.post(updateMenteeProfileUrl, data: formData);

    log('StatusCode------>> ${response.statusCode}');
    log('Response $updateMenteeProfileUrl------>> ${response.data}');
    if (response.statusCode == 200) {
      if (response.data['Status'].toString() == 'true') {
        getMethod(
            Get.context!,
            getUserProfileURL,
            {
              'token': '123',
              'user_id':
              Get.find<GeneralController>().storageBox.read('userID')
            },
            true,
            getUserProfileRepo);
        showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'SUCCESS!'.tr,
                titleColor: customDialogSuccessColor,
                descriptions: 'Profile Updated Successfully',
                text: 'OK'.tr,
                functionCall: () {
                  Navigator.pop(context);
                  Get.back();
                },
                img: 'assets/Icons/dialog_success.svg',
              );
            });
        Get.find<GeneralController>().updateFormLoaderController(false);
        log('menteeUpdateProfileImageRepo ------>> ${response.statusCode}');
      } else {
        showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'FAILED!'.tr,
                titleColor: customDialogErrorColor,
                descriptions: 'Try Again!'.tr,
                text: 'OK'.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
        Get.find<GeneralController>().updateFormLoaderController(false);
        log('menteeUpdateProfileImageRepo ------>> ${response.statusCode}');
      }
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: 'Try Again!'.tr,
              text: 'OK'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
    }
  } on dio_instance.DioError catch (e) {
    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'FAILED!'.tr,
            titleColor: customDialogErrorColor,
            descriptions: 'Try Again!'.tr,
            text: 'OK'.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
    log('Exception..${e.response}');

  }
}