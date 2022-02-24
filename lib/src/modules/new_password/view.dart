import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../route_generator.dart';
import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'logic.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final logic = Get.put(NewPasswordLogic());

  final state = Get.find<NewPasswordLogic>().state;
  bool? obscureText = true;
  bool? confirmObscureText = true;

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
                                'New Password',
                                style: state.headingTextStyle,
                              ),
                              SizedBox(height: 9.h),
                              Text(
                                'Create New Password',
                                style: state.descTextStyle,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      .075),
                              Text(
                                'Enter Password',
                                style: state.subHeadingTextStyle,
                              ),
                              SizedBox(height: 25.h),

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
                                  hintText: 'New Password',
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

                              ///---confirm-password-field

                              TextFormField(
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
                                height:
                                    MediaQuery.of(context).size.height * .35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0.h,
                left: 55.w,
                right: 55.w,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 45.h),
                  child: InkWell(
                      onTap: () {
                        Get.toNamed(PageRoutes.createdPassword);
                      },
                      child: const MyCustomBottomBar(
                          title: 'Reset Password', disable: false)),
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
