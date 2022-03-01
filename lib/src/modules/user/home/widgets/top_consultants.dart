import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class TopConsultants extends StatefulWidget {
  const TopConsultants({Key? key}) : super(key: key);

  @override
  _TopConsultantsState createState() => _TopConsultantsState();
}

class _TopConsultantsState extends State<TopConsultants> {
  final state = Get.find<UserHomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
      return _userHomeLogic.featuredConsultantLoader!
          ? SkeletonLoader(
              period: const Duration(seconds: 2),
              highlightColor: Colors.grey,
              direction: SkeletonDirection.ltr,
              builder: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 10.h, 15.w, 0.h),
                      child: Container(
                        height: 15.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r)),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 155.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        4,
                        (index) => Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15.w, 0, 0, 0),
                              child: Container(
                                height: 126.h,
                                width: 232.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9.r),
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))
          : _userHomeLogic.featuredConsultantModel.data == null
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 10.h, 15.w, 0.h),
                      child: Text(
                        'Featured Consultants',
                        style: state.subHeadingTextStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 155.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          _userHomeLogic.topConsultants.length,
                          (index) => Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 0, 0),
                                child: InkWell(
                                  onTap: () {
                                    _userHomeLogic.selectedConsultantID =
                                        _userHomeLogic.topConsultants[index].id;
                                    _userHomeLogic.update();
                                    Get.toNamed(
                                        PageRoutes.consultantProfileForUser);
                                  },
                                  child: Stack(
                                    // ignore: deprecated_member_use
                                    overflow: Overflow.visible,
                                    children: [
                                      Container(
                                        height: 126.h,
                                        width: 232.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9.r),
                                            color: index % 2 == 0
                                                ? customLightThemeColor
                                                : customOrangeColor),
                                        child: Stack(
                                          children: [
                                            PositionedDirectional(
                                                end: 0,
                                                top: 0,
                                                child: Image.asset(
                                                  'assets/images/consultantBoxCircle.png',
                                                  width: 140.w,
                                                )),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(15.w, 15.h, 0, 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ///---title
                                                  Text(
                                                    '${_userHomeLogic.topConsultants[index].title}',
                                                    style:
                                                        state.topTitleTextStyle,
                                                  ),
                                                  SizedBox(
                                                    height: 6.h,
                                                  ),

                                                  ///---sub-title
                                                  Text(
                                                    '${_userHomeLogic.topConsultants[index].subTitle}',
                                                    style: state
                                                        .topSubTitleTextStyle,
                                                  ),
                                                  SizedBox(
                                                    height: 21.h,
                                                  ),

                                                  ///---arrow-icon
                                                  SvgPicture.asset(
                                                    'assets/Icons/whiteForwardIcon.svg',
                                                    width: 29.w,
                                                    height: 29.h,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      PositionedDirectional(
                                          end: 12.w,
                                          top: -21.h,
                                          child: Image.asset(
                                            'assets/images/stackImage.png',
                                            width: 100.w,
                                            height: 147.h,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
    });
  }
}
