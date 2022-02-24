import 'dart:developer';

import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TopRatedConsultants extends StatefulWidget {
  const TopRatedConsultants({Key? key}) : super(key: key);

  @override
  _TopRatedConsultantsState createState() => _TopRatedConsultantsState();
}

class _TopRatedConsultantsState extends State<TopRatedConsultants> {
  final state = Get.find<UserHomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Rated Consultants',
                  style: state.subHeadingTextStyle,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'View All',
                    style: state.viewAllTextStyle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Center(
            child: Wrap(
              children: List.generate(
                  _userHomeLogic.topRatedConsultantList.length, (index) {
                return Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.w, 0.h, 15.w, 15.h),
                  child: Container(
                    height: 109.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: -2,
                            blurRadius: 15,
                            // offset: Offset(1,5)
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          18.w, 12.h, 18.w, 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///---profile-image
                          Material(
                            color: customLightThemeColor,
                            borderRadius: BorderRadius.circular(8.r),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.asset(
                                '${_userHomeLogic.topRatedConsultantList[index].image}',
                                width: 76.w,
                                height: 85.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 21.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 6.h,
                              ),

                              ///---title
                              Text(
                                '${_userHomeLogic.topRatedConsultantList[index].title}',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: state.topTitleTextStyle!
                                    .copyWith(color: customTextBlackColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),

                              ///---sub-title
                              Text(
                                '${_userHomeLogic.topRatedConsultantList[index].subTitle}',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: state.topSubTitleTextStyle!
                                    .copyWith(color: customTextBlackColor),
                              ),
                              const Spacer(),

                              ///---rating-bar
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: 5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 10,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => SvgPicture.asset(
                                    'assets/Icons/ratingStarIcon.svg'),
                                onRatingUpdate: (rating) {
                                  log('Rating--->>$rating');
                                },
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                            ],
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/Icons/forwardBlueIcon.svg',
                            width: 29.w,
                            height: 29.h,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      );
    });
  }
}
