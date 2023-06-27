import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../../controller/general_controller.dart';

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
        child: _userHomeLogic.categoriesLoader!
            ? SkeletonLoader(
                period: const Duration(seconds: 2),
                highlightColor: Colors.grey,
                direction: SkeletonDirection.ltr,
                builder: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.w, 0.h, 11.w, 0.h),
                        child: Container(
                          height: 15.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                        )),
                    SizedBox(
                      height: 25.h,
                    ),
                    Center(
                      child: Wrap(
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 11.w, 12.h),
                            child: Container(
                              height: 123.h,
                              width: 106.w,
                              decoration: BoxDecoration(color: customTextFieldColor, borderRadius: BorderRadius.circular(8)),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ))
            : _userHomeLogic.getCategoriesModel.data == null
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.w, 0.h, 11.w, 0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LanguageConstant.categories.tr,
                              style: state.subHeadingTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                _userHomeLogic.selectedCategoryId = null;
                                _userHomeLogic.update();
                                Get.toNamed(PageRoutes.allConsultants);
                              },
                              child: Text(
                                LanguageConstant.viewAll.tr,
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
                          children: List.generate(_userHomeLogic.categoriesList.length > 6 ? 6 : _userHomeLogic.categoriesList.length, (index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 11.w, 12.h),
                              child: InkWell(
                                onTap: () {
                                  _userHomeLogic.selectedCategoryId = _userHomeLogic.categoriesList[index].id;
                                  _userHomeLogic.update();
                                  Get.toNamed(PageRoutes.allConsultants);
                                },
                                child: Container(
                                  // height: 123.h,
                                  width: 106.w,
                                  decoration: BoxDecoration(color: customTextFieldColor, borderRadius: BorderRadius.circular(8)),
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
                                        color: _userHomeLogic.categoriesColor[index],
                                        child: Image.network(
                                        Get.find<GeneralController>().checKImage(_userHomeLogic.categoriesList[index].icon!)
                                         // '$mediaUrl${_userHomeLogic.categoriesList[index].icon}'
                                          ,
                                          loadingBuilder:
                                              (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    3,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    2,
                                                child:
                                                CircularProgressIndicator(
                                                  value: loadingProgress
                                                      .expectedTotalBytes !=
                                                      null
                                                      ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                      : null,
                                                  color: customThemeColor,
                                                ),
                                              ),
                                            );
                                          },
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return SizedBox(
                                              height: MediaQuery.of(context).size.height / 43,
                                              width: MediaQuery.of(context).size.width / 22,
                                              child:  Center(
                                                child: Image.network("https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/mathier190500002.jpg?ver=6"),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 22.h,
                                      ),
                                      Text(
                                        '${_userHomeLogic.categoriesList[index].title}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: SarabunFontFamily.semiBold, fontSize: 14.sp, color: _userHomeLogic.categoriesColor[index]),
                                      ),
                                      Text(
                                        '(${_userHomeLogic.categoriesList[index].subTitle} ${LanguageConstant.consultants.tr})',
                                        style: TextStyle(fontFamily: SarabunFontFamily.light, fontSize: 10.sp, color: customTextGreyColor),
                                      ),
                                    ],
                                  ),
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
