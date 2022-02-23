import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
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
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .35,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 0,
                      backgroundColor: _bookAppointmentLogic.isShrink2
                          ? customThemeColor
                          : Colors.white,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
                          ],
                        ),
                      ),
                      actions: [
                        ///---notifications
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 15),
                          child: SvgPicture.asset(
                            'assets/Icons/notificationIcon.svg',
                          ),
                        )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                              color: customLightThemeColor,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40.r))),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .27,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.w, 25.h, 16.w, 16.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          Text(
                                            'Book Appointment',
                                            style: state.appBarTitleTextStyle,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'By just few easy steps',
                                                style: state
                                                    .appBarSubTitleTextStyle,
                                              ),
                                              Text(
                                                'Step 2 Of 3',
                                                style: state
                                                    .appBarSubTitleTextStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'You Will Pay',
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.medium,
                                        fontSize: 12.sp,
                                        color: Colors.white),
                                  ),
                                  // SizedBox(
                                  //   height: 8.h,
                                  // ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/Icons/videoCallIcon.svg',
                                        color: Colors.white,
                                        height: 12.h,
                                        width: 18.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text(
                                        '\$25',
                                        style: TextStyle(
                                            fontFamily: SarabunFontFamily.bold,
                                            fontSize: 28.sp,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                      ),
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
