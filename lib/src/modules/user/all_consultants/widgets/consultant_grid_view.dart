import 'dart:developer';

import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:resize/resize.dart';

import '../logic.dart';

class ConsultantGridView extends StatefulWidget {
  const ConsultantGridView({Key? key, required this.parentIndex})
      : super(key: key);

  final int? parentIndex;

  @override
  _ConsultantGridViewState createState() => _ConsultantGridViewState();
}

class _ConsultantGridViewState extends State<ConsultantGridView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllConsultantsLogic>(builder: (_allConsultantsLogic) {
      return ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20.h, 0, 0),
            child: Center(
              child: _allConsultantsLogic.allConsultantList[widget.parentIndex!]
                      .mentors!.data!.isEmpty
                  ? const Text(
                      'No Record Found',
                      style: TextStyle(
                          fontFamily: SarabunFontFamily.regular,
                          fontSize: 16,
                          color: customTextBlackColor),
                    )
                  : Wrap(
                      spacing: 12.w,
                      runSpacing: 18.h,
                      alignment: WrapAlignment.start,
                      children: List.generate(
                        _allConsultantsLogic
                            .allConsultantList[widget.parentIndex!]
                            .mentors!
                            .data!
                            .length,
                        (index) => Padding(
                          padding: EdgeInsets.only(top: 0.h),
                          child: Container(
                            width: 164.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xffF5F5F5),
                                      blurRadius: 10.0,
                                      spreadRadius: 5.0,
                                      offset: Offset(5, -3))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///---profile-image
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.w, 16.h, 16.w, 14.h),
                                  child: Container(
                                    color: customLightThemeColor,
                                    height: 114.h,
                                    width: 132.w,
                                    child: _allConsultantsLogic
                                                .allConsultantList[
                                                    widget.parentIndex!]
                                                .mentors!
                                                .data![index]
                                                .user!
                                                .imagePath ==
                                            null
                                        ? const SizedBox()
                                        : Image.network(
                                            '${_allConsultantsLogic.allConsultantList[widget.parentIndex!].mentors!.data![index].user!.imagePath}',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),

                                ///---name
                                Text(
                                  '${_allConsultantsLogic.allConsultantList[widget.parentIndex!].mentors!.data![index].user!.firstName} '
                                  '${_allConsultantsLogic.allConsultantList[widget.parentIndex!].mentors!.data![index].user!.lastName}',
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: _allConsultantsLogic
                                      .state.consultantNameTextStyle,
                                ),
                                SizedBox(height: 8.h),

                                ///---category
                                Text(
                                  _allConsultantsLogic
                                              .allConsultantList[
                                                  widget.parentIndex!]
                                              .mentors!
                                              .data![index]
                                              .category ==
                                          null
                                      ? ''
                                      : '${_allConsultantsLogic.allConsultantList[widget.parentIndex!].mentors!.data![index].category!.name}',
                                  style: _allConsultantsLogic
                                      .state.consultantCategoryTextStyle,
                                ),
                                SizedBox(height: 6.h),

                                ///---rating
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: double.parse(
                                      _allConsultantsLogic
                                          .allConsultantList[
                                              widget.parentIndex!]
                                          .mentors!
                                          .data![index]
                                          .ratingAvg
                                          .toString()),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 15,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  itemBuilder: (context, _) => SvgPicture.asset(
                                      'assets/Icons/ratingStarIcon.svg'),
                                  onRatingUpdate: (rating) {
                                    log('Rating--->>$rating');
                                  },
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          )
        ],
      );
    });
  }
}
