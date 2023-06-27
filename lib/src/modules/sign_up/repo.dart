import 'dart:developer';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/sign_up/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../route_generator.dart';
import '../login/login_otp_model.dart';
import '../user/consultant_profile/view.dart';

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
              title: '${LanguageConstant.success.tr}!',
              titleColor: customDialogSuccessColor,
              descriptions: LanguageConstant.letsLogin.tr,
              text: LanguageConstant.ok.tr,
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

      }else if (response['errors'].containsKey('password')) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: LanguageConstant.failed.tr,
                titleColor: customDialogErrorColor,
                descriptions: response['errors']['password'][0],
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
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
SignupOtpRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {

    Get.find<SignUpLogic>().loginOtpModel = LoginOtpModel.fromJson(response);
    Get.find<GeneralController>().updateFormLoaderController(false);

    if (Get.find<SignUpLogic>().loginOtpModel.status == true) {
      log("user id is ${Get.find<SignUpLogic>().loginOtpModel.data!.userDetail![0].id}");

      ///--------------------------------------------------------------------------------------------

      Get.find<GeneralController>().storageBox.write('userID', Get.find<SignUpLogic>().loginOtpModel.data!.userDetail![0].id);
      Get.find<GeneralController>().storageBox.write('authToken', Get.find<SignUpLogic>().loginOtpModel.data!.accessToken);

      if (Get.find<SignUpLogic>().loginOtpModel.data!.role == 'Mentee') {
        Get.find<GeneralController>().storageBox.write('userRole', Get.find<SignUpLogic>().loginOtpModel.data!.role);
        Get.find<GeneralController>().storageBox.hasData('route') ? Get.to(ConsultantProfilePage()) : Get.offAllNamed(PageRoutes.userHome);
        log('loginRepoMentee ------>> ${Get.find<SignUpLogic>().loginOtpModel.data}');
      } else {
        Get.find<GeneralController>().storageBox.write('userRole', Get.find<SignUpLogic>().loginOtpModel.data!.role);

        Get.offAllNamed(PageRoutes.consultantDashboard);
        log('loginRepoMentor ------>> ${Get.find<SignUpLogic>().loginOtpModel.data}');
      }

      // Get.find<GeneralController>().storageBox.write(
      //     'userId', Get.find<LoginLogic>().loginModel.data!.userDetail![0].id);
      // Get.find<GeneralController>().storageBox.write(
      //     'authToken', Get.find<LoginLogic>().loginModel.data!.accessToken);
      //
      // if (Get.find<LoginLogic>().loginModel.data!.role == 'Mentee') {
      //   Get.find<GeneralController>()
      //       .storageBox
      //       .write('userRole', Get.find<LoginLogic>().loginModel.data!.role);
      //
      //   Get.offAllNamed(PageRoutes.bottomNavBar);
      //   log('loginSignupRepoMentee ------>> ${Get.find<LoginLogic>().loginModel.data}');
      // } else {
      //   Get.find<GeneralController>()
      //       .storageBox
      //       .write('userRole', Get.find<LoginLogic>().loginModel.data!.role);
      //
      //   Get.offAllNamed(PageRoutes.mentorBottomNavBar);
      //   log('loginSignupRepoMentor ------>> ${Get.find<LoginLogic>().loginModel.data}');
      // }

      ///--------------------------------------------------------------------------------------------
      // Get.find<SignUpLogic>().otpFunction(Get.find<SignUpLogic>().SignUpPhoneNumber, context);
      // Get.find<SignUpLogic>().updateOtpSendCheckerSignup(true);
      // Get.find<SignUpLogic>()
      //     .signupTimerAnimationController!
      //     .reverse(from: Get.find<SignUpLogic>().signupTimerAnimationController!.value == 0.0 ? 1.0 : Get.find<SignUpLogic>().signupTimerAnimationController!.value);

      log('loginSignupRepo ------>> ${Get.find<SignUpLogic>().loginOtpModel.data}');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: '${Get.find<SignUpLogic>().loginOtpModel.msg}',
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
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
            img: 'assets/dialog_error.svg',
          );
        });
    log('Exception........................');
  }
}