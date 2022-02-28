import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/sign_up/repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_app_bar.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final logic = Get.put(SignUpLogic());

  final state = Get.find<SignUpLogic>().state;

  bool? obscureText = true;
  bool? confirmObscureText = true;

  final GlobalKey<FormState> _signUpFormKey = GlobalKey();

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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0, 16.w, 0.h),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Form(
                                  key: _signUpFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sign Up',
                                        style: state.headingTextStyle,
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        'Welcome To Create Your Account',
                                        style: state.captionTextStyle,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .06),
                                      Text(
                                        'Enter Details',
                                        style: state.subHeadingTextStyle,
                                      ),
                                      SizedBox(height: 25.h),

                                      ///---first-name-field
                                      TextFormField(
                                        controller:
                                            _signUpLogic.firstNameController,
                                        keyboardType: TextInputType.name,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-z A-Z ]"))
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          hintText: 'First Name',
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color:
                                                      customLightThemeColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.red)),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Field is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---last-name-field
                                      TextFormField(
                                        controller:
                                            _signUpLogic.lastNameController,
                                        keyboardType: TextInputType.name,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-z A-Z ]"))
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          hintText: 'Last Name',
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color:
                                                      customLightThemeColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.red)),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Field is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---email-field
                                      TextFormField(
                                        controller:
                                            _signUpLogic.emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          hintText: 'Email Address',
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color:
                                                      customLightThemeColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.red)),
                                          errorText: _signUpLogic.emailValidator
                                        ),
                                        onChanged: (value){
                                          _signUpLogic.emailValidator = null;
                                          _signUpLogic.update();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Field is required';
                                          } else if (!GetUtils.isEmail(value)) {
                                            return 'Enter Valid Email';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---password-field

                                      TextFormField(
                                        controller:
                                            _signUpLogic.passwordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: obscureText!,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                obscureText = !obscureText!;
                                              });
                                            },
                                            child: Icon(
                                                obscureText!
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 20,
                                                color: const Color(0xff8085BA)),
                                          ),
                                          hintText: 'Password',
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color:
                                                      customLightThemeColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.red)),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Field is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),

                                      SizedBox(height: 20.h),

                                      ///---confirm-password-field

                                      TextFormField(
                                        controller: _signUpLogic
                                            .confirmPasswordController,
                                        keyboardType: TextInputType.text,
                                        obscureText: confirmObscureText!,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                confirmObscureText =
                                                    !confirmObscureText!;
                                              });
                                            },
                                            child: Icon(
                                                confirmObscureText!
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 20,
                                                color: const Color(0xff8085BA)),
                                          ),
                                          hintText: 'Confirm Password',
                                          hintStyle: state.hintTextStyle,
                                          fillColor: customTextFieldColor,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color:
                                                      customLightThemeColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.red)),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Field is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .055),

                                      ///---signup-button
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        child: InkWell(
                                            onTap: () {
                                              if (_signUpFormKey.currentState!
                                                  .validate()) {
                                                _generalController.updateFormLoaderController(true);
                                                postMethod(
                                                    context,
                                                    signUpWithEmailURL,
                                                    {
                                                      'first_name': _signUpLogic
                                                          .firstNameController
                                                          .text,
                                                      'last_name': _signUpLogic
                                                          .lastNameController
                                                          .text,
                                                      'email': _signUpLogic
                                                          .emailController
                                                          .text,
                                                      'password': _signUpLogic
                                                          .passwordController
                                                          .text,
                                                      'password_confirmation':
                                                          _signUpLogic
                                                              .confirmPasswordController
                                                              .text,
                                                    },
                                                    false,
                                                    signUpWithEmailRepo);
                                              }
                                            },
                                            child: const MyCustomBottomBar(
                                                title: 'Sign Up',
                                                disable: false)),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .04),

                                      ///---signup-route
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Have an account? ',
                                            style: state.descTextStyle,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5.h, 0, 5.h),
                                              child: Text(
                                                'Lets Login',
                                                style: state.descTextStyle!
                                                    .copyWith(
                                                        color: customThemeColor,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),

                                      ///---T&C
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'By Sign Up, you are agree with our ',
                                            style: state.descTextStyle,
                                          ),
                                          Text(
                                            'Terms & Conditions',
                                            style: state.descTextStyle!
                                                .copyWith(
                                                    color:
                                                        customLightThemeColor,
                                                    decoration: TextDecoration
                                                        .underline),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
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
}
