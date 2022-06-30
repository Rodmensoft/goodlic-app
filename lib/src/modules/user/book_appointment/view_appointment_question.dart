import 'dart:io';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/book_appointment/post_repo.dart';
import 'package:consultant_product/src/modules/user/book_appointment/razorpay_payment/view_razorpay.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_flutterWave_payment.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class AppointmentQuestionPage extends StatefulWidget {
  const AppointmentQuestionPage({Key? key}) : super(key: key);

  @override
  _AppointmentQuestionPageState createState() =>
      _AppointmentQuestionPageState();
}

class _AppointmentQuestionPageState extends State<AppointmentQuestionPage> {
  final state = Get.find<BookAppointmentLogic>().state;

  @override
  void initState() {
    super.initState();

    Get.find<BookAppointmentLogic>().scrollController2 = ScrollController()
      ..addListener(Get.find<BookAppointmentLogic>().scrollListener2);
    Get.find<BookAppointmentLogic>().selectedPaymentType = null;
    Get.find<BookAppointmentLogic>().questionController.clear();
  }

  @override
  void dispose() {
    Get.find<BookAppointmentLogic>()
        .scrollController2!
        .removeListener(Get.find<BookAppointmentLogic>().scrollListener2);
    Get.find<BookAppointmentLogic>().scrollController2!.dispose();
    super.dispose();
  }

  bool? disableButton = true;
  bool? wave = false;
  bool? razorPay = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: ModalProgressHUD(
            inAsyncCall: _generalController.formLoaderController!,
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: NestedScrollView(
                  controller: _bookAppointmentLogic.scrollController2,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      MyCustomSliverAppBar(
                        heading: LanguageConstant.bookAppointment.tr,
                        subHeading: LanguageConstant.byJustFewEasySteps.tr,
                        trailing: LanguageConstant.step2Of3.tr,
                        isShrink: _bookAppointmentLogic.isShrink2,
                        fee:
                            '\$${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].fee}',
                        feeImage:
                            '${_bookAppointmentLogic.consultantProfileLogic.imagesForAppointmentTypes[_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].appointmentTypeId! - 1]}',
                      ),
                    ];
                  },
                  body: Stack(
                    children: [
                      ListView(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 20.h, 15.w, 0),
                          children: [
                            ///---question-area
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 15,
                                      // offset: Offset(1,5)
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25.h, horizontal: 20.w),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageConstant.typeYourQuestion.tr,
                                        style: state.headingTextStyle,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      ///---question-field

                                      TextFormField(
                                        controller: _bookAppointmentLogic
                                            .questionController,
                                        keyboardType: TextInputType.text,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
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
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 25.h,
                            ),

                            ///---upload-file-area
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 15,
                                      // offset: Offset(1,5)
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25.h, horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          LanguageConstant.uploadFile.tr,
                                          style: state.headingTextStyle,
                                        ),
                                        Text(
                                          '  (${LanguageConstant.ifAny.tr})',
                                          style: TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.medium,
                                              fontSize: 12.sp,
                                              color: customTextBlackColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (_bookAppointmentLogic
                                                .selectedFileName ==
                                            null) {
                                          _bookAppointmentLogic
                                                  .filePickerResult =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.any,
                                            // allowedExtensions: ["jpg", "png", "pdf", "doc"],
                                          );
                                          if (_bookAppointmentLogic
                                                  .filePickerResult !=
                                              null) {
                                            final file = File(
                                                _bookAppointmentLogic
                                                    .filePickerResult!
                                                    .files[0]
                                                    .path!);
                                            setState(() {});
                                            int sizeInBytes = file.lengthSync();
                                            double sizeInMb =
                                                sizeInBytes / (1024 * 1024);
                                            if (sizeInMb > 10) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CustomDialogBox(
                                                      title: LanguageConstant
                                                          .failed.tr,
                                                      titleColor:
                                                          customDialogErrorColor,
                                                      descriptions: LanguageConstant
                                                          .fileIsGreaterThan10mb
                                                          .tr,
                                                      text: LanguageConstant
                                                          .ok.tr,
                                                      functionCall: () {
                                                        Navigator.pop(context);
                                                      },
                                                      img:
                                                          'assets/Icons/dialog_error.svg',
                                                    );
                                                  });
                                            } else {
                                              _bookAppointmentLogic
                                                  .updateSelectedFileName(
                                                      _bookAppointmentLogic
                                                          .filePickerResult!
                                                          .files[0]
                                                          .name);
                                              setState(() {});
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 69.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: customLightOrangeColor,
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                'assets/Icons/dottedBorder.svg',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Center(
                                              child: _bookAppointmentLogic
                                                          .selectedFileName !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              _bookAppointmentLogic
                                                                  .selectedFileName!,
                                                              softWrap: true,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      SarabunFontFamily
                                                                          .medium,
                                                                  fontSize:
                                                                      12.sp,
                                                                  color:
                                                                      customOrangeColor),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              _bookAppointmentLogic
                                                                  .updateSelectedFileName(
                                                                      null);
                                                            },
                                                            child: const Icon(
                                                              Icons.cancel,
                                                              color:
                                                                  customOrangeColor,
                                                              size: 25,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/Icons/uploadIcon.svg',
                                                          height: 23.h,
                                                          width: 25.w,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text(
                                                          LanguageConstant
                                                              .uploadHere.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .medium,
                                                              fontSize: 12.sp,
                                                              color:
                                                                  customOrangeColor),
                                                        )
                                                      ],
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),

                            ///---payment-method-area
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: customTextBlackColor, width: 1)),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.w, 25.h, 20.w, 7.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageConstant.paymentMethod.tr,
                                      style: state.headingTextStyle,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Wrap(
                                      children: List.generate(
                                          _bookAppointmentLogic
                                              .paymentMethodList
                                              .length, (index) {
                                        return Padding(
                                          padding: index % 2 == 0
                                              ? EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8.w, 18.h)
                                              : EdgeInsetsDirectional.fromSTEB(
                                                  8.w, 0.h, 0.w, 18.h),
                                          child: InkWell(
                                            onTap: () {
                                              for (var element
                                                  in _bookAppointmentLogic
                                                      .paymentMethodList) {
                                                element.isSelected = false;
                                              }
                                              _bookAppointmentLogic
                                                  .paymentMethodList[index]
                                                  .isSelected = true;
                                              _bookAppointmentLogic
                                                  .selectedPaymentType = index;
                                              _bookAppointmentLogic.update();
                                              setState(() {
                                                disableButton = false;
                                              });

                                              /// Show flutterwave payment button
                                              if (_bookAppointmentLogic
                                                  .paymentMethodList[index]
                                                  .image!
                                                  .contains('flutterwave')) {
                                                setState(() {
                                                  wave = true;
                                                });
                                              } else {
                                                setState(() {
                                                  wave = false;
                                                });
                                              }

                                              /// Show razorPay payment button
                                              if (_bookAppointmentLogic
                                                  .paymentMethodList[index]
                                                  .image!
                                                  .contains('razorpay')) {
                                                setState(() {
                                                  razorPay = true;
                                                });
                                              } else {
                                                setState(() {
                                                  razorPay = false;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 61.h,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .38,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: _bookAppointmentLogic
                                                              .paymentMethodList[
                                                                  index]
                                                              .isSelected!
                                                          ? customLightThemeColor
                                                          : Colors.white,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: _bookAppointmentLogic
                                                              .paymentMethodList[
                                                                  index]
                                                              .isSelected!
                                                          ? customLightThemeColor
                                                              .withOpacity(0.2)
                                                          : Colors.grey
                                                              .withOpacity(0.2),
                                                      spreadRadius: -2,
                                                      blurRadius: 15,
                                                      // offset: Offset(1,5)
                                                    )
                                                  ]),
                                              child: _bookAppointmentLogic
                                                      .paymentMethodList[index]
                                                      .image!
                                                      .contains(
                                                          'braintreePayment')
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      child: SvgPicture.asset(
                                                        '${_bookAppointmentLogic.paymentMethodList[index].image}',
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          '${_bookAppointmentLogic.paymentMethodList[index].image}',
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .15,
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .15,
                            ),
                          ]),

                      ///---bottom-bar
                      razorPay == true
                          ? Positioned(
                              bottom: 0.h,
                              left: 15.w,
                              right: 15.w,
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    Get.to(RazorPayView(
                                        amount: _bookAppointmentLogic
                                            .selectMentorAppointmentType!.fee
                                            .toString()));
                                  }
                                },
                                child: const MyCustomBottomBar(
                                  title: 'Razor Pay',
                                  disable: false,
                                ),
                              ),
                            )
                          : wave == true
                              ? Positioned(
                                  bottom: 0.h,
                                  left: 15.w,
                                  right: 15.w,
                                  child: InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        Get.to(FlutterWave(
                                            amount: _bookAppointmentLogic
                                                .selectMentorAppointmentType!
                                                .fee
                                                .toString()));
                                      }
                                    },
                                    child: const MyCustomBottomBar(
                                      title: 'Flutter Wave',
                                      disable: false,
                                    ),
                                  ),
                                )
                              : Positioned(
                                  bottom: 0.h,
                                  left: 15.w,
                                  right: 15.w,
                                  child: InkWell(
                                    onTap: () {
                                      if (!disableButton! &&
                                          _formKey.currentState!.validate()) {
                                        if (_bookAppointmentLogic
                                                .selectedFileName ==
                                            null) {
                                          _generalController
                                              .updateFormLoaderController(true);
                                          if (_bookAppointmentLogic
                                                  .selectMentorAppointmentType!
                                                  .appointmentType!
                                                  .isScheduleRequired ==
                                              1) {
                                            postMethod(
                                                context,
                                                bookAppointmentUrl,
                                                {
                                                  'token': '123',
                                                  'mentee_id': Get.find<
                                                          GeneralController>()
                                                      .storageBox
                                                      .read('userID'),
                                                  'mentor_id':
                                                      Get.find<UserHomeLogic>()
                                                          .selectedConsultantID,
                                                  'payment': _bookAppointmentLogic
                                                      .selectMentorAppointmentType!
                                                      .fee,
                                                  'payment_id':
                                                      _bookAppointmentLogic
                                                          .selectedPaymentType,
                                                  'questions':
                                                      _bookAppointmentLogic
                                                          .questionController
                                                          .text,
                                                  'appointment_type_string':
                                                      _bookAppointmentLogic
                                                          .selectMentorAppointmentType!
                                                          .appointmentType!
                                                          .name,
                                                  'appointment_type_id':
                                                      _bookAppointmentLogic
                                                          .selectMentorAppointmentType!
                                                          .appointmentType!
                                                          .id,
                                                  'date': _bookAppointmentLogic
                                                      .selectedDateForAppointment
                                                      .substring(0, 11),
                                                  'time': _bookAppointmentLogic
                                                      .selectedTimeForAppointment,
                                                },
                                                true,
                                                bookAppointmentWithoutFileRepo);
                                          } else {
                                            postMethod(
                                                context,
                                                bookAppointmentUrl,
                                                {
                                                  'token': '123',
                                                  'mentee_id': Get.find<
                                                          GeneralController>()
                                                      .storageBox
                                                      .read('userID'),
                                                  'mentor_id':
                                                      Get.find<UserHomeLogic>()
                                                          .selectedConsultantID,
                                                  'payment': _bookAppointmentLogic
                                                      .selectMentorAppointmentType!
                                                      .fee,
                                                  'payment_id':
                                                      _bookAppointmentLogic
                                                          .selectedPaymentType,
                                                  'questions':
                                                      _bookAppointmentLogic
                                                          .questionController
                                                          .text,
                                                  'appointment_type_string':
                                                      _bookAppointmentLogic
                                                          .selectMentorAppointmentType!
                                                          .appointmentType!
                                                          .name,
                                                  'appointment_type_id':
                                                      _bookAppointmentLogic
                                                          .selectMentorAppointmentType!
                                                          .appointmentType!
                                                          .id,
                                                },
                                                true,
                                                bookAppointmentWithoutFileRepo);
                                          }
                                        } else {
                                          _generalController
                                              .updateFormLoaderController(true);
                                          bookAppointmentFileRepo(
                                              File(_bookAppointmentLogic
                                                  .filePickerResult!
                                                  .files[0]
                                                  .path!),
                                              context);
                                        }
                                        // Get.toNamed(PageRoutes.paymentView);
                                      }
                                    },
                                    child: MyCustomBottomBar(
                                      title: LanguageConstant.continueText.tr,
                                      disable: disableButton!,
                                    ),
                                  ),
                                )
                    ],
                  )),
            ),
          ),
        );
      });
    });
  }
}
