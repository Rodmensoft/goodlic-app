import 'dart:developer';
import 'dart:io';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/login/repo.dart';
import 'package:consultant_product/src/modules/sign_up/repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_app_bar.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:resize/resize.dart';

import '../login/view.dart';
import 'logic.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  /// Google
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
      if (googleSignInAuthentication?.accessToken == null) {
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      postMethod(
          context,
          loginWithGoogleURL,
          {
            'email': user!.email,
            'name': user.displayName,
            'role': logic.selectedRole,
            'id': user.uid,
          },
          false,
          loginWithEmailRepo);
    } catch (e) {
      print('Google Login Error: $e');
    }
  }

  final logic = Get.put(SignUpLogic());

  final state = Get.find<SignUpLogic>().state;

  bool? obscureText = true;
  bool? confirmObscureText = true;

  final GlobalKey<FormState> _signUpFormKey = GlobalKey();
  TextEditingController? textEditingController1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.SignUptabController = TabController(length: 2, vsync: this);
    logic.signupTimerAnimationController = AnimationController(duration: Duration(seconds: 60), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<SignUpLogic>(builder: (_signUpLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            inAsyncCall: _generalController.formLoaderController!,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/loginBackground.png',
                      width: MediaQuery.of(context).size.width * .8,
                    ),
                    right: 0,
                    top: 0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///---appBar
                      const MyCustomAppBar(
                        drawerShow: false,
                        whiteBackground: true,
                      ),

                      ///---body
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0.h),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Form(
                                  key: _signUpFormKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageConstant.signUp.tr,
                                        style: state.headingTextStyle,
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        LanguageConstant.welcomToCreateYourAccount.tr,
                                        style: state.captionTextStyle,
                                      ),

                                      SizedBox(height: 25.h),

                                      ///---role-tabs
                                      Center(
                                        child: Container(
                                          height: 34.h,
                                          width: MediaQuery.of(context).size.width * .6,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6.r), color: customTextFieldColor),
                                          child: TabBar(
                                              onTap: (index) {
                                                if (index == 0) {
                                                  _signUpLogic.selectedRole = 'Mentee';
                                                  _signUpLogic.update();
                                                } else {
                                                  _signUpLogic.selectedRole = 'Mentor';
                                                  _signUpLogic.update();
                                                }
                                              },
                                              indicator: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6.r), // Creates border
                                                  color: customThemeColor),
                                              indicatorSize: TabBarIndicatorSize.tab,
                                              automaticIndicatorColorAdjustment: true,
                                              controller: _signUpLogic.SignUptabController,
                                              labelColor: Colors.white,
                                              unselectedLabelColor: customThemeColor,
                                              indicatorColor: Colors.transparent,
                                              tabs: _signUpLogic.signupRoleTabList),
                                        ),
                                      ),

                                      SizedBox(height: 40.h),
                                      Text(
                                        LanguageConstant.enterDetails.tr,
                                        style: state.subHeadingTextStyle,
                                      ),

                                      SizedBox(height: 25.h),
                                      Get.find<GeneralController>().storageBox.read('loginType') == 'phone'?
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ///---view
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height * .4,
                                            child: Stack(
                                              children: [
                                                SingleChildScrollView(
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    child: Form(
                                                      key: _signUpLogic.SignUpKey,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          /// OTP
                                                          ///---field-area
                                                          Padding(
                                                            padding: const EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                // Text(
                                                                //   'enter_your_phone'.tr,
                                                                //   style: state.loginPhoneFieldTextStyle,
                                                                // ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                                                  child: DecoratedBox(
                                                                    decoration: BoxDecoration(
                                                                      color: const Color(0xffF6F7FC),
                                                                      borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                    child: IntlPhoneField(
                                                                      initialCountryCode: _generalController.initialCountryCode.value,
                                                                      controller: _signUpLogic.SignUpTextEditingController,
                                                                      //  style: GoogleFonts.poppins(color: Colors.black),
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                      ],
                                                                      keyboardType: TextInputType.phone,
                                                                      textAlign: TextAlign.start,
                                                                      decoration: InputDecoration(
                                                                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                        filled: true,
                                                                        fillColor: const Color(0xffF6F7FC),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                        counterText: '',
                                                                        labelText: 'phone_number'.tr,
                                                                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
                                                                        border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          borderSide: BorderSide.none,
                                                                        ),
                                                                      ),
                                                                      onChanged: (phone) {
                                                                        setState(() {
                                                                          _signUpLogic.updateOtpSendCheckerSignup(false);
                                                                          _signUpLogic.SignUpPhoneNumber = phone.completeNumber;
                                                                        });
                                                                        log('This is my number${phone.completeNumber}');
                                                                      },
                                                                      onCountryChanged: (Country phone) {
                                                                        _signUpLogic.updateOtpSendCheckerSignup(false);
                                                                        _signUpLogic.SignUpTextEditingController.clear();
                                                                        _signUpLogic.SignUpPhoneNumber = null;
                                                                        setState(() {});
                                                                        log('Country code changed to: ' + phone.code);
                                                                      },
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),

                                                          _signUpLogic.otpSendCheckerSignup
                                                              ? Padding(
                                                            padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Center(
                                                                  child: Padding(
                                                                    padding: const EdgeInsetsDirectional.only(top: 15, bottom: 5),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        if (_signUpLogic.signupTimerAnimationController!.value == 0.0) {
                                                                          setState(() {
                                                                            _signUpLogic.otpFunction(Get.find<SignUpLogic>().SignUpPhoneNumber, context);
                                                                            _signUpLogic.signupTimerAnimationController!.reverse(
                                                                                from: _signUpLogic.signupTimerAnimationController!.value == 0.0
                                                                                    ? 1.0
                                                                                    : _signUpLogic.signupTimerAnimationController!.value);
                                                                          });
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                        ' resend_OTP_code'.tr,
                                                                        style: _signUpLogic.signupTimerAnimationController!.value != 0.0
                                                                            ? const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff727377))
                                                                            .copyWith(color: Colors.grey.withOpacity(0.5))
                                                                            : const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff727377)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(child: OtpTimer(_signUpLogic.signupTimerAnimationController!, 15.0, Colors.black)),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(16, 15, 16, 0),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        ' enter_OTP_code_below'.tr,
                                                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                                                        child: PinCodeTextField(
                                                                          controller: textEditingController1,
                                                                          appContext: context,
                                                                          pastedTextStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),
                                                                          textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),
                                                                          length: 6,
                                                                          blinkWhenObscuring: false,
                                                                          animationType: AnimationType.fade,
                                                                          validator: (v) {
                                                                            if (v!.length < 6) {
                                                                              return "enter_correct_pin".tr;
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                          pinTheme: PinTheme(
                                                                              shape: PinCodeFieldShape.box,
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              fieldHeight: 36,
                                                                              fieldWidth: 40,
                                                                              activeFillColor: Colors.white,
                                                                              disabledColor: Colors.white,
                                                                              activeColor: customThemeColor,
                                                                              inactiveFillColor: const Color(0xffF6F7FC),
                                                                              errorBorderColor: Colors.red,
                                                                              inactiveColor: customThemeColor,
                                                                              selectedFillColor: const Color(0xffF6F7FC),
                                                                              selectedColor: customThemeColor,
                                                                              borderWidth: 1),
                                                                          cursorColor: Colors.black,
                                                                          animationDuration: const Duration(milliseconds: 300),
                                                                          enableActiveFill: true,
                                                                          keyboardType: TextInputType.number,
                                                                          onCompleted: (v) {
                                                                            log("Completed");
                                                                          },
                                                                          onChanged: (value) {
                                                                            log(value);
                                                                            setState(() {
                                                                              _signUpLogic.signupOtp = value.toString();
                                                                            });
                                                                          },
                                                                          beforeTextPaste: (text) {
                                                                            log("Allowing to paste $text");
                                                                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                                                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                                                            return true;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                                  child: Center(
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        Get.find<GeneralController>().updateFormLoaderController(true);
                                                                        _signUpLogic.verifyOTP(context, _signUpLogic.signupOtp, true);
                                                                      },
                                                                      child: Container(
                                                                        height: 40,
                                                                        width: MediaQuery.of(context).size.width * .4,
                                                                        decoration: BoxDecoration(color: customThemeColor, borderRadius: BorderRadius.circular(8)),
                                                                        child: Center(
                                                                          child: Text(
                                                                            'submit'.tr,
                                                                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                                            // style: state.loginButtonTextStyle,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                              : Padding(
                                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                                            child: Center(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      if (_signUpLogic.SignUpKey.currentState!.validate()) {
                                                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                                                        if (!currentFocus.hasPrimaryFocus) {
                                                                          currentFocus.unfocus();
                                                                        }
                                                                        log("This is number ${_signUpLogic.SignUpPhoneNumber}");

                                                                        //     _generalController.updateFormLoaderController(true);
                                                                        Get.find<SignUpLogic>().otpFunction(Get.find<SignUpLogic>().SignUpPhoneNumber, context);
                                                                        Get.find<SignUpLogic>().updateOtpSendCheckerSignup(true);
                                                                        Get.find<SignUpLogic>().signupTimerAnimationController!.reverse(
                                                                            from: Get.find<SignUpLogic>().signupTimerAnimationController!.value == 0.0
                                                                                ? 1.0
                                                                                : Get.find<SignUpLogic>().signupTimerAnimationController!.value);

                                                                        //   postMethod(
                                                                        //       context,
                                                                        //       loginWithOtpURL,
                                                                        //       {
                                                                        //         'token': '123',
                                                                        //         'phone': _signUpLogic.SignUpPhoneNumber!.replaceFirst('+', ''),
                                                                        //         'role': _signUpLogic.selectedRole,
                                                                        //         'is_login_page': false
                                                                        //       },
                                                                        //       false,
                                                                        //       SignupOtpRepo);
                                                                      }
                                                                    },
                                                                    child: MyCustomBottomBar(title: LanguageConstant.signUp.tr, disable: false)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ):Column(
                                        children: [
                                          ///---first-name-field
                                          TextFormField(
                                            controller: _signUpLogic.firstNameController,
                                            keyboardType: TextInputType.name,
                                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]"))],
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                                              hintText: LanguageConstant.firstName.tr,
                                              hintStyle: state.hintTextStyle,
                                              fillColor: customTextFieldColor,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.red)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return LanguageConstant.fieldRequired.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(height: 20.h),

                                          ///---last-name-field
                                          TextFormField(
                                            controller: _signUpLogic.lastNameController,
                                            keyboardType: TextInputType.name,
                                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]"))],
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                                              hintText: LanguageConstant.lastName.tr,
                                              hintStyle: state.hintTextStyle,
                                              fillColor: customTextFieldColor,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.red)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return LanguageConstant.fieldRequired.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(height: 20.h),

                                          ///---email-field
                                          TextFormField(
                                            controller: _signUpLogic.emailController,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                                                hintText: LanguageConstant.emailAddress.tr,
                                                hintStyle: state.hintTextStyle,
                                                fillColor: customTextFieldColor,
                                                filled: true,
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.r),
                                                    borderSide: const BorderSide(color: Colors.transparent)),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.r),
                                                    borderSide: const BorderSide(color: Colors.transparent)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.r),
                                                    borderSide: const BorderSide(color: customLightThemeColor)),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.r),
                                                    borderSide: const BorderSide(color: Colors.red)),
                                                errorText: _signUpLogic.emailValidator),
                                            onChanged: (value) {
                                              _signUpLogic.emailValidator = null;
                                              _signUpLogic.update();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return LanguageConstant.fieldRequired.tr;
                                              } else if (!GetUtils.isEmail(value)) {
                                                return LanguageConstant.enterValidEmail.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(height: 20.h),

                                          ///---password-field

                                          TextFormField(
                                            controller: _signUpLogic.passwordController,
                                            keyboardType: TextInputType.text,
                                            obscureText: obscureText!,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                                              suffixIcon: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    obscureText = !obscureText!;
                                                  });
                                                },
                                                child: Icon(obscureText! ? Icons.visibility : Icons.visibility_off,
                                                    size: 20, color: const Color(0xff8085BA)),
                                              ),
                                              hintText: LanguageConstant.password.tr,
                                              hintStyle: state.hintTextStyle,
                                              fillColor: customTextFieldColor,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.red)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return LanguageConstant.fieldRequired.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),

                                          SizedBox(height: 20.h),

                                          ///---confirm-password-field

                                          TextFormField(
                                            controller: _signUpLogic.confirmPasswordController,
                                            keyboardType: TextInputType.text,
                                            obscureText: confirmObscureText!,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                                              suffixIcon: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    confirmObscureText = !confirmObscureText!;
                                                  });
                                                },
                                                child: Icon(confirmObscureText! ? Icons.visibility : Icons.visibility_off,
                                                    size: 20, color: const Color(0xff8085BA)),
                                              ),
                                              hintText: LanguageConstant.confirmPassword.tr,
                                              hintStyle: state.hintTextStyle,
                                              fillColor: customTextFieldColor,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.transparent)),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(color: Colors.red)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return LanguageConstant.fieldRequired.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * .055),

                                          ///---signup-button
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                                            child: InkWell(
                                                onTap: () {
                                                  if (_signUpFormKey.currentState!.validate()) {
                                                    _generalController.updateFormLoaderController(true);
                                                    postMethod(
                                                        context,
                                                        signUpWithEmailURL,
                                                        {
                                                          'first_name': _signUpLogic.firstNameController.text,
                                                          'last_name': _signUpLogic.lastNameController.text,
                                                          'email': _signUpLogic.emailController.text,
                                                          'password': _signUpLogic.passwordController.text,
                                                          'password_confirmation': _signUpLogic.confirmPasswordController.text,
                                                          'role': _signUpLogic.selectedRole
                                                        },
                                                        false,
                                                        signUpWithEmailRepo);
                                                  }
                                                },
                                                child: MyCustomBottomBar(title: LanguageConstant.signUp.tr, disable: false)),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height * .04),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.orSignUpWith.tr,
                                            style: state.orTextStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 28.h),

                                      ///---social-buttons
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ///---google-button
                                          InkWell(
                                            onTap: () async {
                                              await loginWithGoogle();
                                            },
                                            child: Container(
                                              height: 57.h,
                                              width: 57.w,
                                              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                BoxShadow(
                                                    color: customLightThemeColor.withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 30,
                                                    offset: const Offset(0, 15))
                                              ]),
                                              child: Center(child: SvgPicture.asset('assets/Icons/googleIcon.svg')),
                                            ),
                                          ),
                                          SizedBox(width: 17.w),

                                          ///---fb-button
                                          InkWell(
                                            onTap: () {
                                              loginWithFacebook();
                                            },
                                            child: Container(
                                              height: 57.h,
                                              width: 57.w,
                                              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                BoxShadow(
                                                    color: customLightThemeColor.withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 30,
                                                    offset: const Offset(0, 15))
                                              ]),
                                              child: Center(child: SvgPicture.asset('assets/Icons/fbIcon.svg')),
                                            ),
                                          ),
                                          SizedBox(width: 17.w),
                                        ],
                                      ),

                                      SizedBox(height: 30.h),

                                      ///---signup-route
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.haveAnAccount.tr,
                                            style: state.descTextStyle,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5.h, 0, 5.h),
                                              child: Text(
                                                LanguageConstant.letsLogin.tr,
                                                style: state.descTextStyle!
                                                    .copyWith(color: customThemeColor, decoration: TextDecoration.underline),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---T&C
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LanguageConstant.bySignUpYouAreAgreeWith.tr,
                                            style: state.descTextStyle,
                                          ),
                                          Text(
                                            LanguageConstant.termsAndConditions.tr,
                                            style: state.descTextStyle!
                                                .copyWith(color: customLightThemeColor, decoration: TextDecoration.underline),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        );
      });
    });
  }

  /// Facebook
  Future<void> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(permissions: ["email", "public_profile"]);
      if (result.accessToken == null) return;
      if (result.status == LoginStatus.success) {
        Map<String, dynamic> userData =
            await FacebookAuth.instance.getUserData(fields: "first_name,name,email,picture.width(200)");

        postMethod(
            context,
            loginWithGoogleURL,
            {
              'email': userData["email"],
              'name': userData["first_name"],
              'role': logic.selectedRole,
              'id': userData["id"],
            },
            false,
            loginWithEmailRepo);
      }
    } on PlatformException catch (e) {
      log("Error: ${e.toString()}");
    } on SocketException catch (e) {
      log("Error: ${e.toString()}");
    }
  }
}
