
import 'dart:developer';

import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/model_post_account_info.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/model_post_general_info.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/model_post_skill_info.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mentorGeneralInfo2Repo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<EditConsultantProfileLogic>().generalInfoPostModel =
        GeneralInfoPostModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>().generalInfoPostModel.status == true) {
      Get.find<EditConsultantProfileLogic>()
          .stepperList[Get.find<EditConsultantProfileLogic>().stepperIndex!]
          .isSelected = false;
      Get.find<EditConsultantProfileLogic>()
          .stepperList[Get.find<EditConsultantProfileLogic>().stepperIndex!]
          .isCompleted = true;
      Get.find<EditConsultantProfileLogic>()
          .stepperList[Get.find<EditConsultantProfileLogic>().stepperIndex! + 1]
          .isSelected = true;
      Get.find<EditConsultantProfileLogic>().updateStepperIndex(1);
      Get.snackbar('${'profile_updated_successfully'.tr}!', '',
          colorText: Colors.black,
          backgroundColor: Colors.white);
      Get.find<GeneralController>().updateFormLoaderController(false);
      log('mentorGeneralInfoRepo ------>> ${Get.find<EditConsultantProfileLogic>().generalInfoPostModel.success}');
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
}


mentorSkillInfoRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<EditConsultantProfileLogic>().skillInfoPostModel =
        SkillInfoPostModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>().skillInfoPostModel.status == true) {
      // Get.find<MentorProfileLogic>()
      //     .stepperList[Get.find<MentorProfileLogic>().stepperIndex!]
      //     .isSelected = false;
      // Get.find<MentorProfileLogic>()
      //     .stepperList[Get.find<MentorProfileLogic>().stepperIndex!]
      //     .isCompleted = true;
      // Get.find<MentorProfileLogic>()
      //     .stepperList[Get.find<MentorProfileLogic>().stepperIndex! + 1]
      //     .isSelected = true;
      // Get.find<MentorProfileLogic>().updateStepperIndex(4);
      Get.snackbar('${'skill_added_successfully'.tr}!', '',
          colorText: Colors.black,
          backgroundColor: Colors.white);
      Get.find<GeneralController>().updateFormLoaderController(false);
      log('mentorSkillInfoRepo ------>> ${Get.find<EditConsultantProfileLogic>().skillInfoPostModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

mentorAccountInfoRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<EditConsultantProfileLogic>().accountInfoPostModel =
        AccountInfoPostModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>().accountInfoPostModel.status == true) {
      Get.find<EditConsultantProfileLogic>()
          .stepperList[Get.find<EditConsultantProfileLogic>().stepperIndex!]
          .isSelected = false;
      Get.find<EditConsultantProfileLogic>()
          .stepperList[Get.find<EditConsultantProfileLogic>().stepperIndex!]
          .isCompleted = true;
      postMethod(
          context,
          mentorProfileStatusUrl,
          {
            'token': '123',
            'mentor_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          mentorProfileStatusChangeRepo);
      log('mentorAccountInfoRepo ------>> ${Get.find<EditConsultantProfileLogic>().accountInfoPostModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}

mentorProfileStatusChangeRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      Get.find<EditConsultantProfileLogic>().showConfirmation = true;
      Get.find<EditConsultantProfileLogic>().update();
      // showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (BuildContext context) {
      //       return CustomDialogBox(
      //         title: 'success!'.tr,
      //         titleColor: customDialogSuccessColor,
      //         descriptions: '${'profile_updated_successfully'.tr}',
      //         text: 'ok'.tr,
      //         functionCall: () {
      //           Navigator.pop(context);
      //           Get.find<GeneralController>()
      //               .storageBox
      //               .write('mentorProfile', 'completed');
      //           Get.offAllNamed(PageRoutes.consultantDashboard);
      //         },
      //         img: 'assets/dialog_success.svg',
      //       );
      //     });
      Get.find<GeneralController>().updateFormLoaderController(false);
      log('mentorProfileStatusChangeRepo ------>> ${response['Status'].toString()}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}