import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../controller/general_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import 'logic.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final logic = Get.put(MyProfileLogic());

  final state = Get.find<MyProfileLogic>().state;

  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<MyProfileLogic>().scrollController = ScrollController()
      ..addListener(Get.find<MyProfileLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<MyProfileLogic>()
        .scrollController!
        .removeListener(Get.find<MyProfileLogic>().scrollListener);
    Get.find<MyProfileLogic>().scrollController!.dispose();
    super.dispose();
  }

  ///

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<MyProfileLogic>(builder: (_myProfileLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                controller: _myProfileLogic.scrollController,
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

                      backgroundColor: _myProfileLogic.isShrink
                          ? customLightThemeColor
                          : Colors.white,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(30),
                        child: Container(
                          height: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0.r)),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 3,
                                    offset: Offset(0, 1))
                              ]),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: SafeArea(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -9,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: customLightThemeColor,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(25.r),
                                            bottomLeft: Radius.circular(25.r))),
                                    // color: customLightThemeColor,
                                    width: MediaQuery.of(context).size.width,

                                    child: Center(
                                        child: Image.asset(
                                      'assets/images/stackImage.png',
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      fit: BoxFit.cover,
                                    )),
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
                            // '${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.firstName ?? '...'} '
                            //     '${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.lastName ?? ''}',
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
                                // _consultantProfileLogic
                                //             .consultantProfileModel
                                //             .data!
                                //             .userDetail!
                                //             .mentor!
                                //             .categories!
                                //             .category ==
                                //         null
                                //     ? '...'
                                //     : '${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.mentor!.categories!.category!.name}',
                                'Financial Advisor',
                                style: state.categoryTextStyle,
                              ),

                              ///---rating-bar
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: 5.0,
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
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
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
                                            //  '${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.ratingsAvg}.0',
                                            '5.0',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.extraBold,
                                                fontSize: 16,
                                                color: customThemeColor),
                                          )
                                        ],
                                      ),
                                      Text('Positive Rating',
                                          style: state.ratingTextStyle)
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
                                            //  '${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.appointmentCount}+',
                                            '200+',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.extraBold,
                                                fontSize: 16,
                                                color: customThemeColor),
                                          )
                                        ],
                                      ),
                                      Text('Consultancy',
                                          style: state.ratingTextStyle)
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
                                            // '${_consultantProfileLogic.consultantProfileModel.data!.userDetail!.mentor!.experience}+',
                                            '4+',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.extraBold,
                                                fontSize: 16,
                                                color: customThemeColor),
                                          )
                                        ],
                                      ),
                                      Text('Years Of Exp',
                                          style: state.ratingTextStyle)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 5.h,
                          ),

                          /// General Info

                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'General Info',
                                        style: state.sectionHeadingTextStyle,
                                      ),
                                      SvgPicture.asset(
                                        'assets/Icons/editIcon.svg',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  ///---name-gender-status.
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ///---name
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Name',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'Mentor Name',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),

                                      ///---gender
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Gender',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'Male',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),

                                      ///---status
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Status',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'Active Member',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle
                                                ?.copyWith(
                                                    color: customGreenColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),

                                  ///---phone-city-cnic
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ///---phone
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Phone',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            '0315-123456789',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),

                                      ///---city
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'City',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'Faisalabad',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),

                                      ///---cnic
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'CNIC',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            '331005255526',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),

                                  ///---reg.date-address
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ///---reg.date
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Reg. Date',
                                              style:
                                                  state.sectionLabelTextStyle,
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                              '26-2-22',
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: state.sectionDataTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///---address
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  30.w, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Address',
                                                style:
                                                    state.sectionLabelTextStyle,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                '102-c Peoples Colony 1, Fsd',
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style:
                                                    state.sectionDataTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 20.h,
                            color: const Color(0xffF6F6F6),
                          ),

                          /// Educational Info

                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Educational Info',
                                        style: state.sectionHeadingTextStyle,
                                      ),
                                      SvgPicture.asset(
                                        'assets/Icons/editIcon.svg',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  ///---name-gender-status.
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ///---name
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Name',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'Mentor Name',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),

                                      ///---gender
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Gender',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'Male',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),

                                      ///---status
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Status',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'Active Member',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle
                                                ?.copyWith(
                                                    color: customGreenColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),

                                  ///---phone-city-cnic
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ///---phone
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Phone',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            '0315-123456789',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),

                                      ///---city
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'City',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'Faisalabad',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),

                                      ///---cnic
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'CNIC',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            '331005255526',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),

                                  ///---reg.date-address
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ///---reg.date
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Reg. Date',
                                              style:
                                                  state.sectionLabelTextStyle,
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                              '26-2-22',
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: state.sectionDataTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///---address
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  30.w, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Address',
                                                style:
                                                    state.sectionLabelTextStyle,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                '102-c Peoples Colony 1, Fsd',
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style:
                                                    state.sectionDataTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ],
                )),
          ),
        );
      });
    });
  }
}
