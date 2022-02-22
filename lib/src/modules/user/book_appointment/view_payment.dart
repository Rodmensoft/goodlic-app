import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final state = Get.find<BookAppointmentLogic>().state;

  @override
  void initState() {
    super.initState();

    Get.find<BookAppointmentLogic>().scrollController3 = ScrollController()
      ..addListener(Get.find<BookAppointmentLogic>().scrollListener3);
  }

  @override
  void dispose() {
    Get.find<BookAppointmentLogic>()
        .scrollController3!
        .removeListener(Get.find<BookAppointmentLogic>().scrollListener3);
    Get.find<BookAppointmentLogic>().scrollController3!.dispose();
    super.dispose();
  }


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
                controller: _bookAppointmentLogic.scrollController3,
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
                      backgroundColor: _bookAppointmentLogic.isShrink3
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
                                                'Step 3 Of 3',
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
                          ///---card-heading
                          Text(
                            'Card Details',
                            style: state.headingTextStyle,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          SizedBox(
                              height: 250.h,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Image.asset('assets/images/cardBackground.png',fit: BoxFit.fill,
                                    height: 200.h,
                                    width: MediaQuery.of(context).size.width,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 27.h,
                                      horizontal: 21.w
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ///---card-number
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Enter Card Number',
                                                    style: TextStyle(
                                                      fontFamily: SarabunFontFamily.regular,
                                                      fontSize: 14.sp,
                                                      color: Colors.white
                                                    ),
                                                  ),

                                                  TextFormField(

                                                    style: const TextStyle(
                                                      fontFamily: SarabunFontFamily.semiBold,
                                                      fontSize: 16,
                                                      color: Colors.white
                                                    ),
                                                    cursorColor: Colors.white,
                                                    keyboardType: TextInputType.name,
                                                    maxLines: 1,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                          0.w, 0.h, 0.w, 0.h),
                                                      enabledBorder: UnderlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(8.r),
                                                          borderSide: const BorderSide(
                                                              color: Colors.transparent)),
                                                      border: UnderlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(8.r),
                                                          borderSide: const BorderSide(
                                                              color: Colors.transparent)),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(8.r),
                                                          borderSide: const BorderSide(
                                                              color: Colors.white)),
                                                      errorBorder: UnderlineInputBorder(
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
                                            SvgPicture.asset('assets/Icons/masterCardIcon.svg',height: 22.h,width: 37.w,)
                                          ],
                                        ),

                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              ///---card-holder-name
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'CARD HOLDER',
                                                        style: TextStyle(
                                                            fontFamily: SarabunFontFamily.regular,
                                                            fontSize: 12.sp,
                                                            color: Colors.white
                                                        ),
                                                      ),

                                                      TextFormField(
                                                        style: const TextStyle(
                                                            fontFamily: SarabunFontFamily.semiBold,
                                                            fontSize: 14,
                                                            color: Colors.white
                                                        ),
                                                        cursorColor: Colors.white,
                                                        keyboardType: TextInputType.text,
                                                        maxLines: 1,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                              0.w, 0.h, 0.w, 0.h),
                                                          enabledBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.transparent)),
                                                          border: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.transparent)),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.white)),
                                                          errorBorder: UnderlineInputBorder(
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


                                              ///---card-expiry
                                              Expanded(
                                                child: Align(

                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'EXPIRES',
                                                        style: TextStyle(
                                                            fontFamily: SarabunFontFamily.regular,
                                                            fontSize: 12.sp,
                                                            color: Colors.white
                                                        ),
                                                      ),

                                                      TextFormField(
                                                        style: const TextStyle(
                                                            fontFamily: SarabunFontFamily.semiBold,
                                                            fontSize: 14,
                                                            color: Colors.white
                                                        ),
                                                        cursorColor: Colors.white,
                                                        keyboardType: TextInputType.text,
                                                        maxLines: 1,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                              0.w, 0.h, 0.w, 0.h),
                                                          enabledBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.transparent)),
                                                          border: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.transparent)),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.white)),
                                                          errorBorder: UnderlineInputBorder(
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
                                              ///---card-cvv
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'CVV',
                                                        style: TextStyle(
                                                            fontFamily: SarabunFontFamily.regular,
                                                            fontSize: 12.sp,
                                                            color: Colors.white
                                                        ),
                                                      ),

                                                      TextFormField(
                                                        style: const TextStyle(
                                                            fontFamily: SarabunFontFamily.semiBold,
                                                            fontSize: 14,
                                                            color: Colors.white
                                                        ),
                                                        cursorColor: Colors.white,
                                                        keyboardType: TextInputType.text,
                                                        maxLines: 1,
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                              0.w, 0.h, 0.w, 0.h),
                                                          enabledBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.transparent)),
                                                          border: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.transparent)),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                              borderSide: const BorderSide(
                                                                  color: Colors.white)),
                                                          errorBorder: UnderlineInputBorder(
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
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              )),

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

                        },
                        child: const MyCustomBottomBar(
                          title: 'Continue',
                          disable: false,
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
