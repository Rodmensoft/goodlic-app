import 'dart:developer';

import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class ConsultantProfilePage extends StatefulWidget {
  const ConsultantProfilePage({Key? key}) : super(key: key);

  @override
  State<ConsultantProfilePage> createState() => _ConsultantProfilePageState();
}

class _ConsultantProfilePageState extends State<ConsultantProfilePage> {
  final logic = Get.put(ConsultantProfileLogic());

  final state = Get.find<ConsultantProfileLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ConsultantProfileLogic>(
          builder: (_consultantProfileLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .35,
                      // floating: true,
                      pinned: true,
                      // snap: true,
                      elevation: 0,
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
                      backgroundColor: customLightThemeColor,
                      actions: [
                        ///---notifications

                        CustomNotificationIcon(color:Colors.white)
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(30),
                        child: Container(
                          height: 30.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.r)),
                              color: Colors.white),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: SafeArea(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/stackImage.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    ListView(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                        children: [
                          ///---name
                          Text(
                            'William Smith',
                            style: state.profileNameTextStyle,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          ///---category-rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///---category
                              Text(
                                'Financial Advisor',
                                style: state.categoryTextStyle,
                              ),

                              ///---rating-bar
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: 5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => SvgPicture.asset(
                                    'assets/Icons/ratingStarIcon.svg'),
                                onRatingUpdate: (rating) {
                                  log('Rating--->>$rating');
                                },
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 25.h,
                          ),

                          ///---about-detail
                          Row(
                            children: [
                              ///---rating
                              Container(
                                height: 73.h,
                                width: 106.w,
                                decoration: BoxDecoration(
                                    color: customTextFieldColor,
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/Icons/ratingStarIcon.svg'),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          const Text(
                                            '5.0',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.extraBold,
                                                fontSize: 16,
                                                color: customThemeColor),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        'Positive Rating',
                                        style: TextStyle(
                                            fontFamily:
                                                SarabunFontFamily.medium,
                                            fontSize: 12,
                                            color: customTextBlackColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),

                              ///---consultancy-count
                              Container(
                                height: 73.h,
                                width: 106.w,
                                decoration: BoxDecoration(
                                    color: customTextFieldColor,
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/Icons/consultancyCountIcon.svg'),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          const Text(
                                            '200+',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.extraBold,
                                                fontSize: 16,
                                                color: customThemeColor),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        'Consultancy',
                                        style: TextStyle(
                                            fontFamily:
                                                SarabunFontFamily.medium,
                                            fontSize: 12,
                                            color: customTextBlackColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              const Spacer(),

                              ///---experience
                              Container(
                                height: 73.h,
                                width: 106.w,
                                decoration: BoxDecoration(
                                    color: customTextFieldColor,
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/Icons/checkIcon.svg'),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          const Text(
                                            '4+',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.extraBold,
                                                fontSize: 16,
                                                color: customThemeColor),
                                          )
                                        ],
                                      ),
                                      const Text(
                                        'Years Of Exp',
                                        style: TextStyle(
                                            fontFamily:
                                                SarabunFontFamily.medium,
                                            fontSize: 12,
                                            color: customTextBlackColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 30.h,
                          ),

                          ///---about
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'About',
                                style: state.headingTextStyle,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lorem nunc, pellentesque et rhoncus ac, sodales vel tellus.',
                                style: state.dataTextStyle,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 30.h,
                          ),

                          ///---types
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Available Options',
                                style: state.headingTextStyle,
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                              Wrap(
                                children: List.generate(
                                    _consultantProfileLogic
                                        .appointmentTypes.length, (index) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 18.w, 11.h),
                                    child: Container(
                                      height: 47.h,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: -2,
                                              blurRadius: 15,
                                              // offset: Offset(1,5)
                                            )
                                          ]),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                                '${_consultantProfileLogic.appointmentTypes[index].image}'),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              '${_consultantProfileLogic.appointmentTypes[index].title}',
                                              style: state.typesTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ]),

                    ///---bottom-bar

                    Positioned(
                      bottom: 0.h,
                      left: 15.w,
                      right: 15.w,
                      child: InkWell(
                        onTap: (){
                          Get.toNamed(PageRoutes.slotSelection);
                        },
                        child: const MyCustomBottomBar(
                          title: 'Book Appointment',
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
