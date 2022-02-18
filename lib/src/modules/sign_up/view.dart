import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
                                'Sign Up',
                                style: state.headingTextStyle,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Welcome To Create Your Account',
                                style: state.captionTextStyle,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .06),
                              Text(
                                'Enter Details',
                                style: state.subHeadingTextStyle,
                              ),
                              SizedBox(height: 25.h),

                              ///---name-field
                              TextFormField(
                                keyboardType: TextInputType.name,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-z A-Z ]"))
                                ],
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  hintText: 'Full Name',
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
                              SizedBox(height: 20.h),

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
                                    onTap: (){
                                      setState(() {
                                        obscureText = !obscureText!;
                                      });
                                    },
                                    child:  Icon(
                                        obscureText!
                                            ?Icons.visibility
                                            :Icons.visibility_off,
                                        size: 20, color: const Color(0xff8085BA)),
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
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      .055),

                              ///---signup-button
                              Center(
                                child: Container(
                                  height: 55.h,
                                  width:
                                      MediaQuery.of(context).size.width * .73,
                                  decoration: BoxDecoration(
                                      color: customThemeColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                      boxShadow: [
                                        BoxShadow(
                                            color: customThemeColor
                                                .withOpacity(0.5),
                                            spreadRadius: -18,
                                            blurRadius: 30,
                                            offset: const Offset(0, 35))
                                      ]),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sign Up',
                                          style: state.buttonTextStyle,
                                        ),
                                        SvgPicture.asset(
                                          'assets/Icons/whiteForwardIcon.svg',
                                          width: 29.w,
                                          height: 29.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .07),

                              ///---signup-route
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5.h, 0, 5.h),
                                      child: Text(
                                        'Lets Login',
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
                                    'By Sign Up, you are agree with our ',
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
