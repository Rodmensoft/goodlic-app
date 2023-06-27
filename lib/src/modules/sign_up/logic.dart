import 'dart:developer';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/modules/sign_up/repo.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../route_generator.dart';
import '../../api_services/post_service.dart';
import '../../api_services/urls.dart';
import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_dialog.dart';
import '../login/login_otp_model.dart';

import '../user/consultant_profile/view.dart';
import 'model.dart';
import 'state.dart';

class SignUpLogic extends GetxController {
  final SignUpState state = SignUpState();

  SignupModel signupModel = SignupModel();

  // LoginModel loginModel = LoginModel();
  LoginOtpModel loginOtpModel = LoginOtpModel();

  late TabController SignUptabController;

  List<Tab> signupRoleTabList = [Tab(text: LanguageConstant.user.tr), Tab(text: LanguageConstant.mentor.tr)];

  String? selectedRole = 'Mentee';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? emailValidator;

////////////////////////////

  AnimationController? loginTimerAnimationController;
  AnimationController? signupTimerAnimationController;

  /// Otp logics

  final GlobalKey<FormState> SignUpKey = GlobalKey();
  TextEditingController SignUpTextEditingController = TextEditingController();
  String? SignUpPhoneNumber;
  String? verificationIDForVerify;

  // bool otpSendCheckerLogin = false;
  // updateOtpSendCheckerLogin(bool newValue) {
  //   otpSendCheckerLogin = newValue;
  //   update();
  // }

  bool otpSendCheckerSignup = false;
  updateOtpSendCheckerSignup(bool newValue) {
    otpSendCheckerSignup = newValue;
    update();
  }

  //String? loginOtp;
  String? signupOtp;

  Future<bool?> otpFunction(String? phone, BuildContext context) async {
    log('-----------------OtpFunctionStartHere-----------------');
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone!,
      timeout: const Duration(seconds: 55),
      verificationCompleted: (AuthCredential credential) async {
        log('Credential from verificationCompleted ---->> $credential');
       // Get.find<GeneralController>().updateFormLoaderController(true);
       // User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        // if (user != null) {
        //   log('user added by otp');
        //
        //   Get.find<GeneralController>().storageBox.write('userID', Get.find<SignUpLogic>().loginOtpModel.data!.userDetail![0].id);
        //   Get.find<GeneralController>().storageBox.write('authToken', Get.find<SignUpLogic>().loginOtpModel.data!.accessToken);
        //
        //   if (Get.find<SignUpLogic>().signupModel.data!.role == 'Mentee') {
        //     Get.find<GeneralController>().storageBox.write('userRole', Get.find<SignUpLogic>().signupModel.data!.role);
        //
        //     //Get.offAllNamed(PageRoutes.userHome);
        //     log('loginRepoMentee ------>> ${Get.find<SignUpLogic>().signupModel.data}');
        //   } else {
        //     Get.find<GeneralController>().storageBox.write('userRole', Get.find<SignUpLogic>().signupModel.data!.role);
        //
        //     //Get.offAllNamed(PageRoutes.consultantDashboard);
        //     log('loginRepoMentor ------>> ${Get.find<SignUpLogic>().signupModel.data}');
        //   }
        // } else {
        //   Get.find<GeneralController>().updateFormLoaderController(false);
        //   Get.find<GeneralController>().update();
        //   log("Error");
        // }
      },
      verificationFailed: (FirebaseAuthException exception) {
        log('Exception ---->> ${exception.message}');
      },
      codeSent: (String? verificationId, [int? forceResendingToken]) {
        verificationIDForVerify = verificationId;
        log('verificationId ---->> $verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('autoGetOTP ---->> $verificationId');
      },
    );
  }

  verifyOTP(BuildContext context, var otp, bool fromSignup) async {
    log('--------------VerifyOtpStartsHere--------------');
    try {
      log('verificationId ---->> $verificationIDForVerify');
      log('verificationId ---->> $otp');
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDForVerify!,
        smsCode: otp,
      );

      User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      print(user.toString());

      if (user != null) {
        log('user added by otp');

        if (fromSignup) {
          postMethod(context, loginWithOtpURL,
              {'token': '123', 'phone': Get.find<SignUpLogic>().SignUpPhoneNumber!.replaceFirst('+', ''), 'role': Get.find<SignUpLogic>().selectedRole, 'is_login_page': false}, false, SignupOtpRepo);
        } else {
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
        }
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);

        log("Error");
      }
      log('Credential ---->> $credential');
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: 'incorrect_OTP'.tr,
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
      log('Exception --->> ${e}');
    }
  }
}
