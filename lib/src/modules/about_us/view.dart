import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../api_services/get_service.dart';
import '../../api_services/urls.dart';
import '../../controller/general_controller.dart';
import '../../widgets/custom_sliver_app_bar.dart';
import 'crop_image_text.dart';
import 'get_repo.dart';
import 'logic.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final logic = Get.put(AboutUsLogic());

  final state = Get.find<AboutUsLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMethod(
        context,
        getAboutUsUrl,
        {'token': '123', },
        true,
        aboutUsRepo);


    Get.find<AboutUsLogic>().scrollController = ScrollController()..addListener(Get.find<AboutUsLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<AboutUsLogic>().scrollController!.removeListener(Get.find<AboutUsLogic>().scrollListener);
    Get.find<AboutUsLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<AboutUsLogic>(builder: (_aboutUsLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
                controller: _aboutUsLogic.scrollController,
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: LanguageConstant.aboutUs.tr,
                      subHeading: LanguageConstant.getKnowAboutOurVisionAndMission.tr,
                      isShrink: _aboutUsLogic.isShrink,
                    ),
                  ];
                },
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [




                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                          child: Text(
                            _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Title ?? '',
                            //LanguageConstant.ourVision.tr,
                            style: state.headingTextStyle,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 14.0 ),
                          child: DropCapText(
                            _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Description ?? '',dropCapStyle:  state.descTextStyle ,dropCapChars: 10,parseInlineMarkdown: true,
                            dropCap: DropCap(
                              width: 174.w,
                              height: 140,
                              child: Padding(
                                padding:  EdgeInsets.only(right: 9,bottom: 9),
                                child: Image.network(
                                    Get.find<GeneralController>().checKImage(_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Image ??"" ),
                                 //   '$mediaUrl${_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Image }',
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
                            ),),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.only(end: 14.w),
                        //           child: Text(
                        //             _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Description ?? '',
                        //             // softWrap: true,
                        //             // overflow: TextOverflow.ellipsis,
                        //             // maxLines: 5,
                        //             // textAlign: TextAlign.justify,
                        //             style: state.descTextStyle,
                        //           ),
                        //         ),
                        //       ),
                        //       // SizedBox(width: 28.w),
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.only(start: 14.w),
                        //           child: SizedBox(
                        //             // height: 149.h,
                        //             width: 136.w,
                        //             child: Image.network(
                        //               //'$mediaUrl${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user!.imagePath}'
                        //               '$mediaUrl${_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Image }',
                        //            // ' mediaUrl+${ _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Title ?? ''} ',
                        //               fit: BoxFit.fill,
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 36.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB( 15, 0, 0, 0),
                              child: Text(
                                _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section3Title ?? '',
                                style: state.headingTextStyle,
                              ),
                            ),
                            SizedBox(height: 16.h),

                            // Padding(
                            //   padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Expanded(
                            //         child: Padding(
                            //           padding: EdgeInsetsDirectional.only(end: 28.w),
                            //           child: SizedBox(
                            //             // height: 149.h,
                            //             width: 136.w,
                            //             child:  Image.network(
                            //               //'$mediaUrl${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user!.imagePath}'
                            //               '$mediaUrl${_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section3Image }',
                            //               // ' mediaUrl+${ _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Title ?? ''} ',
                            //               fit: BoxFit.fill,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       // SizedBox(width: 15.w),
                            //       Expanded(
                            //         child: Text(
                            //           _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2Description ?? '',
                            //           // softWrap: true,
                            //           // overflow: TextOverflow.ellipsis,
                            //           // maxLines: 5,
                            //           // textAlign: TextAlign.justify,
                            //           style: state.descTextStyle,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 14.0 ),
                              child: DropCapText(

                                _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section3Description ?? '',dropCapStyle:  state.descTextStyle ,dropCapChars: 10,parseInlineMarkdown: true,

                                dropCapPosition: DropCapPosition.end,  dropCap: DropCap(
                                width: 174.w,
                                height: 140,

                                child: Padding(
                                  padding:  EdgeInsets.only(left: 9,bottom: 9),
                                  child: Image.network(
                                    Get.find<GeneralController>().checKImage(_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section3Image??""),
                                  //    '$mediaUrl${_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section3Image }'
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
                              ),),
                            ),
                          ],
                        ),
                        // SizedBox(height: 50.h),
                        SizedBox(height: MediaQuery.of(context).size.height * .06),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                          child: Text(
                            _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2Title ?? '',
                            style: state.headingTextStyle,
                          ),
                        ),

                        SizedBox(height: 23.h),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                          child:   DropCapText(
                            _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2Description ?? '',dropCapStyle:  state.descTextStyle ,dropCapChars: 10,parseInlineMarkdown: true,
                          ),
                          // child: Text(
                          //   _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2Description ?? '',
                          //   style: state.descTextStyle,
                          // ),
                        ),
                        SizedBox(height: 23.h),
                        // Expanded(
                        //   //         child: Text(
                        //   //           _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2Description ?? '',
                        //   //           // softWrap: true,
                        //   //           // overflow: TextOverflow.ellipsis,
                        //   //           // maxLines: 5,
                        //   //           // textAlign: TextAlign.justify,
                        //   //           style: state.descTextStyle,
                        //   //         ),
                        //   //       ),
                        Column(
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 16.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 74,
                                          padding: EdgeInsets.all(15),
                                          child: Image.network(
                                              Get.find<GeneralController>().checKImage(_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2FirstImage??""),
                                            //'$mediaUrl${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user!.imagePath}'
                                            //'$mediaUrl${_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2FirstImage }',
                                            // ' mediaUrl+${ _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Title ?? ''} ',
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


                                            color: customThemeColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)), color: customThemeColor),
                                      child: Padding(
                                        padding:  EdgeInsetsDirectional.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ///---heading
                                            Text(
                                              _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2FirstHeading ?? '',
                                              style: state.subHeadingTextStyle,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),

                                            ///---detail
                                            Text(
                                              _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2FirstSubHeading ?? '',
                                              style: state.descTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 2,
                              width: MediaQuery.of(context).size.width,

                            ),
                            Container(
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 16.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 74,
                                          padding: EdgeInsets.all(15),
                                          child: Image.network(
                                              Get.find<GeneralController>().checKImage(_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2SecondImage??""),
                                            //'$mediaUrl${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user!.imagePath}'
                                           // '$mediaUrl${_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2SecondImage }',
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

                                            // ' mediaUrl+${ _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Title ?? ''} ',

                                            color: customThemeColor,
                                          ),),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5, ),
                                      decoration: BoxDecoration( color: customThemeColor),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ///---heading
                                            Text(
                                              _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2SecondHeading ?? '',
                                              style: state.subHeadingTextStyle,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),

                                            ///---detail
                                            Text(
                                              _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2SecondSubHeading ?? '',
                                              style: state.descTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 2,
                              width: MediaQuery.of(context).size.width,
                           //   color: customAppBackgroundColor,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 16.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 74,
                                          padding: EdgeInsets.all(15),
                                          // child: Image.network(
                                          //   //'$mediaUrl${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user!.imagePath}'
                                          //   '$mediaUrl${_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2ThirdImage }',
                                          //   // ' mediaUrl+${ _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Title ?? ''} ',
                                          //   fit: BoxFit.fill,
                                          //   color: customThemeColor,
                                          // ),
                                      child:Image.network(
                                        Get.find<GeneralController>().checKImage(_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2ThirdImage??""),
                                        //'$mediaUrl${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user!.imagePath}'
                                       // '$mediaUrl${_aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2ThirdImage }',
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

                                        // ' mediaUrl+${ _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section1Title ?? ''} ',

                                        color: customThemeColor,
                                      ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5, bottom: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)), color: customThemeColor),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ///---heading
                                            Text(
                                              _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2ThirdHeading ?? '',
                                              style: state.subHeadingTextStyle,
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),

                                            ///---detail
                                            Text(
                                              _aboutUsLogic.aboutUsModel.data?.aboutUsContent?.section2ThirdSubHeading ?? '',
                                              style: state.descTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      });
    });
  }
}
