import 'package:consultant_product/src/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:resize/resize.dart';

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'logic.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final logic = Get.put(ResetPasswordLogic());

  final state = Get.find<ResetPasswordLogic>().state;

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
                                'Reset Password',
                                style: state.headingTextStyle,
                              ),
                              SizedBox(height: 9.h),
                              Text(
                                'A Reset Link Will Be Share Via OTP',
                                style: state.descTextStyle,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      .075),
                              Text(
                                'Enter Phone',
                                style: state.subHeadingTextStyle,
                              ),
                              SizedBox(height: 25.h),

                              ///---field-area
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF6F7FC),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IntlPhoneField(
                                      initialCountryCode: 'PK',
                                      //  controller: _loginLogicController
                                      //  .loginTextEditingController,
                                      // style: GoogleFonts.poppins(
                                      //     color: Colors.black),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      keyboardType: TextInputType.phone,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                        filled: true,
                                        fillColor: customTextFieldColor,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        counterText: '',
                                        labelText: 'Enter Phone',
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      // onChanged: (phone) {
                                      //   setState(() {
                                      //     _loginLogicController
                                      //         .updateOtpSendCheckerLogin(
                                      //         false);
                                      //     _loginLogicController
                                      //         .loginPhoneNumber =
                                      //         phone.completeNumber;
                                      //   });
                                      //   log(phone.completeNumber);
                                      // },
                                      // onCountryChanged:
                                      //     (PhoneNumber? phone) {
                                      //   _loginLogicController
                                      //       .updateOtpSendCheckerLogin(
                                      //       false);
                                      //   _loginLogicController
                                      //       .loginTextEditingController
                                      //       .clear();
                                      //   _loginLogicController
                                      //       .loginPhoneNumber = null;
                                      //   setState(() {});
                                      //   log('Country code changed to: ' +
                                      //       phone!.countryISOCode
                                      //           .toString());
                                      // },
                                    ),
                                  ),
                                  // SizedBox(height: 250.h),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .4,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 20.h),
                                    child: InkWell(
                                      onTap: () {},
                                      child: const CustomButton(
                                        title: 'Confirm',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
