import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: NestedScrollView(
                controller: _bookAppointmentLogic.scrollController2,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: 'Book Appointment',
                      subHeading: 'By just few easy steps',
                      trailing: 'Step 2 Of 3',
                      isShrink: _bookAppointmentLogic.isShrink2,
                      fee: '25',
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    ListView(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Type Your Question',
                                    style: state.headingTextStyle,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  ///---question-field

                                  TextFormField(
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
                                              color: customLightThemeColor)),
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
                                ],
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
                                  Text(
                                    'Upload File',
                                    style: state.headingTextStyle,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    height: 69.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: customLightOrangeColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            'assets/Icons/dottedBorder.svg',
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/Icons/uploadIcon.svg',
                                                height: 23.h,
                                                width: 25.w,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              const Text(
                                                'Upload Here',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .medium,
                                                    fontSize: 12,
                                                    color: customOrangeColor),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
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
                                    'Payment Method',
                                    style: state.headingTextStyle,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Wrap(
                                    children: List.generate(
                                        _bookAppointmentLogic
                                            .paymentMethodList.length, (index) {
                                      return Padding(
                                        padding: index % 2 == 0
                                            ? EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 8.w, 18.h)
                                            : EdgeInsetsDirectional.fromSTEB(
                                                8.w, 0.h, 0.w, 18.h),
                                        child: InkWell(
                                          onTap: () {
                                            _bookAppointmentLogic
                                                .paymentMethodList
                                                .forEach((element) {
                                              element.isSelected = false;
                                            });
                                            _bookAppointmentLogic
                                                .paymentMethodList[index]
                                                .isSelected = true;
                                            _bookAppointmentLogic.update();
                                            setState(() {
                                              disableButton = false;
                                            });
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
                                                    BorderRadius.circular(8.r),
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
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  '${_bookAppointmentLogic.paymentMethodList[index].image}',
                                                  width: MediaQuery.of(context)
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
                    Positioned(
                      bottom: 0.h,
                      left: 15.w,
                      right: 15.w,
                      child: InkWell(
                        onTap: () {
                          if (!disableButton!) {
                            Get.toNamed(PageRoutes.paymentView);
                          }
                        },
                        child: MyCustomBottomBar(
                          title: 'Continue',
                          disable: disableButton!,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      });
    });
  }
}
