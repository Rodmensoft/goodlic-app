import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_app_bar.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logic = Get.put(LoginLogic());

  final state = Get.find<LoginLogic>().state;
  bool? obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GestureDetector(
        onTap: () {
          _generalController.focusOut(context);
        },
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
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0.h),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
                                style: state.headingTextStyle,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Welcome Back To Your Account',
                                style: state.captionTextStyle,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .06),
                              Text(
                                'Enter Login Details',
                                style: state.subHeadingTextStyle,
                              ),
                              SizedBox(height: 25.h),

                              ///---email-field
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  hintText: 'Email Address',
                                  hintStyle: state.hintTextStyle,
                                  fillColor: customTextFieldColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
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
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field is required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 24.h),

                              ///---forgot-password
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Get.toNamed(PageRoutes.resetPassword);
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: state.forgotTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      .055),

                              ///---login-button
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                                child: InkWell(
                                    onTap: (){},
                                    child: const MyCustomBottomBar(title: 'Login', disable: false)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .055),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'or login with',
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
                                  Container(
                                    height: 57.h,
                                    width: 57.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: customLightThemeColor
                                                  .withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 30,
                                              offset: const Offset(0, 15))
                                        ]),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            'assets/Icons/googleIcon.svg')),
                                  ),
                                  SizedBox(width: 17.w),

                                  ///---fb-button
                                  Container(
                                    height: 57.h,
                                    width: 57.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: customLightThemeColor
                                                  .withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 30,
                                              offset: const Offset(0, 15))
                                        ]),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            'assets/Icons/fbIcon.svg')),
                                  ),
                                  SizedBox(width: 17.w),

                                  ///---twitter-button
                                  Container(
                                    height: 57.h,
                                    width: 57.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: customLightThemeColor
                                                  .withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 30,
                                              offset: const Offset(0, 15))
                                        ]),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            'assets/Icons/twitterIcon.svg')),
                                  ),
                                ],
                              ),

                              SizedBox(height: 35.h),

                              ///---signup-route
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don’t have an account? ',
                                    style: state.descTextStyle,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(PageRoutes.signUp);
                                    },
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5.h, 0, 5.h),
                                      child: Text(
                                        'Register now',
                                        style: state.descTextStyle!.copyWith(
                                            color: customThemeColor,
                                            decoration:
                                                TextDecoration.underline),
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
                                    'By login, you are agree with our ',
                                    style: state.descTextStyle,
                                  ),
                                  Text(
                                    'Terms & Conditions',
                                    style: state.descTextStyle!.copyWith(
                                        color: customLightThemeColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                            ],
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
      );
    });
  }
}
