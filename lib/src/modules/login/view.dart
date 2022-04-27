import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/login/repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_app_bar.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(LoginLogic());

  final state = Get.find<LoginLogic>().state;
  bool? obscureText = true;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GestureDetector(
        onTap: () {
          _generalController.focusOut(context);
        },
        child: GetBuilder<LoginLogic>(builder: (_loginLogic) {
          return ModalProgressHUD(
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
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.w, 0, 16.w, 0.h),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Form(
                                key: _loginFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageConstant.login.tr,
                                      style: state.headingTextStyle,
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      LanguageConstant
                                          .welcomeBackToYourAccount.tr,
                                      style: state.captionTextStyle,
                                    ),
                                    SizedBox(height: 25.h),

                                    ///---role-tabs
                                    Center(
                                      child: Container(
                                        height: 34.h,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            color: customTextFieldColor),
                                        child: TabBar(
                                            onTap: (index) {
                                              if (index == 0) {
                                                _loginLogic.selectedRole =
                                                    'Mentee';
                                                _loginLogic.update();
                                              } else {
                                                _loginLogic.selectedRole =
                                                    'Mentor';
                                                _loginLogic.update();
                                              }
                                            },
                                            indicator: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6.r), // Creates border
                                                color: customThemeColor),
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            automaticIndicatorColorAdjustment:
                                                true,
                                            controller:
                                                _loginLogic.tabController,
                                            labelColor: Colors.white,
                                            unselectedLabelColor:
                                                customThemeColor,
                                            indicatorColor: Colors.transparent,
                                            tabs: _loginLogic.loginRoleTabList),
                                      ),
                                    ),

                                    SizedBox(height: 40.h),
                                    Text(
                                      LanguageConstant.enterLoginDetails.tr,
                                      style: state.subHeadingTextStyle,
                                    ),
                                    SizedBox(height: 25.h),

                                    ///---email-field
                                    TextFormField(
                                      controller: _loginLogic.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                25.w, 15.h, 25.w, 15.h),
                                        hintText:
                                            LanguageConstant.emailAddress.tr,
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
                                                color: customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LanguageConstant
                                              .fieldRequired.tr;
                                        } else if (!GetUtils.isEmail(value)) {
                                          return LanguageConstant
                                              .enterValidEmail.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(height: 20.h),

                                    ///---password-field

                                    TextFormField(
                                      controller:
                                          _loginLogic.passwordController,
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
                                        hintText: LanguageConstant.password.tr,
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
                                                color: customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LanguageConstant
                                              .fieldRequired.tr;
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
                                          onTap: () {
                                            Get.toNamed(
                                                PageRoutes.resetPassword);
                                          },
                                          child: Text(
                                            '${LanguageConstant.forgotPassword.tr}?',
                                            style: state.forgotTextStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .05),

                                    ///---login-button
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w),
                                      child: InkWell(
                                          onTap: () {
                                            if (_loginFormKey.currentState!
                                                .validate()) {
                                              _generalController
                                                  .focusOut(context);
                                              _generalController
                                                  .updateFormLoaderController(
                                                      true);
                                              postMethod(
                                                  context,
                                                  loginWithEmailURL,
                                                  {
                                                    'email': _loginLogic
                                                        .emailController.text,
                                                    'password': _loginLogic
                                                        .passwordController
                                                        .text,
                                                    'role':
                                                        _loginLogic.selectedRole
                                                  },
                                                  false,
                                                  loginWithEmailRepo);
                                            }
                                          },
                                          child: MyCustomBottomBar(
                                              title: LanguageConstant.login.tr,
                                              disable: false)),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          LanguageConstant.orLoginWith.tr,
                                          style: state.orTextStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 28.h),

                                    ///---social-buttons
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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

                                    SizedBox(height: 30.h),

                                    ///---signup-route
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${LanguageConstant.doNotHaveAccount.tr}? ',
                                          style: state.descTextStyle,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(PageRoutes.signUp);
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5.h, 0, 5.h),
                                            child: Text(
                                              LanguageConstant.registerNow.tr,
                                              style: state.descTextStyle!
                                                  .copyWith(
                                                      color: customThemeColor,
                                                      decoration: TextDecoration
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
                                          '${LanguageConstant.byLoginYouAreAgreeWithOur.tr} ',
                                          style: state.descTextStyle,
                                        ),
                                        Text(
                                          LanguageConstant
                                              .termsAndConditions.tr,
                                          style: state.descTextStyle!.copyWith(
                                              color: customLightThemeColor,
                                              decoration:
                                                  TextDecoration.underline),
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
                    ],
                  ),
                ]),
              ),
            ),
          );
        }),
      );
    });
  }
}
