import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../controller/general_controller.dart';
import '../../widgets/custom_sliver_app_bar.dart';
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

    Get.find<AboutUsLogic>().scrollController = ScrollController()
      ..addListener(Get.find<AboutUsLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<AboutUsLogic>()
        .scrollController!
        .removeListener(Get.find<AboutUsLogic>().scrollListener);
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
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _aboutUsLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: 'About Us',
                      subHeading: "Get know about our vision and mission",
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                          child: Text(
                            'Our Vision',
                            style: state.headingTextStyle,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'fgdf fihf ff fffef fefuf sffufe hgfhgf f dfh  high hgih ghghi ghig dghfg dgfg ugug gu gug dkgjg gigj 4766 76 jhj yjdtyt ut iti i i',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  textAlign: TextAlign.justify,
                                  style: state.descTextStyle,
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Container(
                                height: 149.h,
                                width: 136.w,
                                child: ClipRRect(
                                  child: Image.asset(
                                    'assets/images/vision.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 36.h),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(58.w, 0, 0, 0),
                              child: Text(
                                'Our Mission',
                                style: state.headingTextStyle,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.w, 0, 16.w, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 149.h,
                                    width: 136.w,
                                    child: ClipRRect(
                                      child: Image.asset(
                                        'assets/images/mission.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.w),
                                  Expanded(
                                    child: Text(
                                      'fgdf fihf ff fffef fefuf sffufe hgfhgf f dfh  high hgih ghghi ghig dghfg dgfg ugug gu gug dkgjg gigj 4766 76 jhj yjdtyt ut iti i i',
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.justify,
                                      style: state.descTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 50.h),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                          child: Text(
                            'Why Choose Us',
                            style: state.headingTextStyle,
                          ),
                        ),
                        SizedBox(height: 23.h),

                        Container(
                          height: 230.h,
                          child: Row(
                            children: [
                              Container(
                                width: 74.w,
                                color: customThemeColor,
                                child: Column(
                                  children: [
                                    SizedBox(height: 18.h),
                                    SvgPicture.asset(
                                        'assets/Icons/check-circle.svg'),
                                    //  SizedBox(height: 188.h),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .09,
                                    ),
                                    SvgPicture.asset(
                                        'assets/Icons/user-badged.svg'),
                                  ],
                                ),
                              ),
                              Container(
                                width: 300.w,
                                color: customLightThemeColor,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.w, 16.h, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Easy Sign Up',
                                        style: state.subHeadingTextStyle,
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        'dhfdf dsfhf dshfdfhdf fdfudf ufif fdf shg sgf ghg gfuyttr tuu tyt',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: state.descTextStyle
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      SizedBox(height: 35.h),
                                      Text(
                                        'Professional Mentors',
                                        style: state.subHeadingTextStyle,
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        'dhfdf dsfhf dshfdfhdf fdfudf ufif fdf shg sgf ghg gfuyttr tuu tyt',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: state.descTextStyle
                                            ?.copyWith(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
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
