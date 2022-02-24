import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../../../route_generator.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final state = Get.find<UserHomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15.w, 30.h, 4.w, 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.w, 0.h, 11.w, 0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: state.subHeadingTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(PageRoutes.enterOtp);
                    },
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
                children: List.generate(_userHomeLogic.categoriesList.length,
                    (index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 11.w, 12.h),
                    child: Container(
                      height: 123.h,
                      width: 106.w,
                      decoration: BoxDecoration(
                          color: customTextFieldColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 14.h,
                          ),
                          Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                color:
                                    _userHomeLogic.categoriesList[index].color,
                                shape: BoxShape.circle),
                            child: Center(
                                child: SvgPicture.asset(
                              '${_userHomeLogic.categoriesList[index].image}',
                              height: 20.h,
                              width: 23.w,
                            )),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            '${_userHomeLogic.categoriesList[index].title}',
                            style: TextStyle(
                                fontFamily: SarabunFontFamily.semiBold,
                                fontSize: 14,
                                color:
                                    _userHomeLogic.categoriesList[index].color),
                          ),
                          Text(
                            '${_userHomeLogic.categoriesList[index].subTitle}',
                            style: const TextStyle(
                                fontFamily: SarabunFontFamily.light,
                                fontSize: 10,
                                color: customTextGreyColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      );
    });
  }
}
