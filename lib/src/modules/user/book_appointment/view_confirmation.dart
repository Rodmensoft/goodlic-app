import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/modules/user/book_appointment/widget/detail_box.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class AppointmentConfirmationView extends StatefulWidget {
  const AppointmentConfirmationView({Key? key}) : super(key: key);

  @override
  _AppointmentConfirmationViewState createState() =>
      _AppointmentConfirmationViewState();
}

class _AppointmentConfirmationViewState
    extends State<AppointmentConfirmationView> {
  final state = Get.find<BookAppointmentLogic>().state;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: GetBuilder<GeneralController>(builder: (_generalController) {
        return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
          return GestureDetector(
            onTap: () {
              _generalController.focusOut(context);
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  ///---background
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      'assets/images/loginBackground.png',
                      width: MediaQuery.of(context).size.width * .8,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0.h),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .12),
                        ///---detail-area
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 15,
                                )
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 35.h, horizontal: 28.w),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ///---success-image
                                  SvgPicture.asset(
                                    'assets/images/successfullImage.svg',
                                    height: 120.h,
                                    width: 177.w,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          .03),

                                  ///---success-text
                                  Text(
                                    'Congratulations',
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.bold,
                                        fontSize: 28.sp,
                                        color: customTextBlackColor),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),

                                  ///---message-text
                                  Text(
                                    'Your Appointment Has Been Booked',
                                    style: TextStyle(
                                        fontFamily: SarabunFontFamily.regular,
                                        fontSize: 14.sp,
                                        color: const Color(0xff9D9D9D)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'with ',
                                        style: TextStyle(
                                            fontFamily: SarabunFontFamily.regular,
                                            fontSize: 14.sp,
                                            color: const Color(0xff9D9D9D)),
                                      ),

                                      ///---consultant-name
                                      Text(
                                        'William Smith',
                                        style: TextStyle(
                                            fontFamily: SarabunFontFamily.regular,
                                            fontSize: 14.sp,
                                            color: customOrangeColor),
                                      ),
                                    ],
                                  ),


                                  SizedBox(
                                    height: 30.h,
                                  ),

                                  ///---type-fee-boxes
                                  Row(
                                    children: [
                                      ///---type-box
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 8.w),
                                          child: const BookAppointmentDetailBox(
                                            title: 'Video Call',
                                            image:
                                                'assets/Icons/videoCallIcon.svg',
                                          ),
                                        ),
                                      ),
                                      ///---fee-box
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8.w),
                                          child: const BookAppointmentDetailBox(
                                            title: '\$25 Fees',
                                            image: 'assets/Icons/feeIcon.svg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),

                                  ///---date-time-boxes
                                  Row(
                                    children: [
                                      ///---date-box
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 8.w),
                                          child: const BookAppointmentDetailBox(
                                            title: '17/02/22',
                                            image:
                                                'assets/Icons/calenderIcon.svg',
                                          ),
                                        ),
                                      ),
                                      ///---time-box
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8.w),
                                          child: const BookAppointmentDetailBox(
                                            title: '9:10 AM',
                                            image: 'assets/Icons/timeIcon.svg',
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

                        SizedBox(
                          height: MediaQuery.of(context).size.height*.1,
                        ),
                        ///---my-appointment-button
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(40.w, 0, 40.w, 0),
                          child: InkWell(
                              onTap: () {
                                Get.offAllNamed(PageRoutes.myAppointment);
                              },
                              child: const MyCustomBottomBar(
                                  title: 'My Appointments', disable: false)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ///---home-button
                        InkWell(
                          onTap: (){
                            Get.offAllNamed(PageRoutes.userHome);
                          },
                          child: Container(

                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(40.w, 0, 40.w, 0),
                              child: Container(
                                height: 55.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: customOrangeColor),
                                    borderRadius: BorderRadius.circular(5.r),),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Go To Home',
                                          style: TextStyle(
                                              fontFamily: SarabunFontFamily.bold,
                                              fontSize: 16,
                                              color: customOrangeColor),
                                        ),
                                        SvgPicture.asset(
                                          'assets/Icons/forwardArrowOrangeIcon.svg',
                                          height: 29.h,
                                          width: 29.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        });
      }),
    );
  }
}
