import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../route_generator.dart';
import '../../utils/constants.dart';
import 'logic.dart';

class OnBoard1Page extends StatefulWidget {
  const OnBoard1Page({Key? key}) : super(key: key);

  @override
  State<OnBoard1Page> createState() => _OnBoard1PageState();
}

class _OnBoard1PageState extends State<OnBoard1Page> {
  final logic = Get.put(OnBoardLogic());

  final state = Get.find<OnBoardLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardLogic>(builder: (_onBoardLogic) {
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                customThemeColor,
                customLightThemeColor,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10.h, 0, 0),
            child: Column(children: [
              Stack(
                children: [
                  Image.asset('assets/images/onBoard1.png'),
                  Positioned(
                    bottom: 0.h,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, .0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Become',
                            style: state.firstTitle,
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            color: customOrangeColor,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15.w, 0, 8, 0),
                              child: Text(
                                'A Consultant',
                                style: state.firstTitle,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'In Few Easy Steps',
                            style: state.subTitle,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Skip',
                      style: TextStyle(
                          fontFamily: SarabunFontFamily.medium,
                          fontSize: 14.sp,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white)),
                  InkWell(
                      onTap: () {
                        Get.toNamed(PageRoutes.onBoard2Screen);
                      },
                      child: SvgPicture.asset(
                          'assets/Icons/forwardBlackIcon.svg')),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .06),
              Image.asset(
                'assets/images/screenPointer1.png',
                width: 78.h,
                height: 9.w,
              ),
            ]),
          ),
        ),
      );
    });
  }
}
