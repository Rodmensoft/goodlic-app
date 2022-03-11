import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../utils/constants.dart';
import 'logic.dart';

class OnBoard2Page extends StatefulWidget {
  const OnBoard2Page({Key? key}) : super(key: key);

  @override
  State<OnBoard2Page> createState() => _OnBoard2PageState();
}

class _OnBoard2PageState extends State<OnBoard2Page> {
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
                alignment: Alignment.bottomRight,
                children: [
                  Image.asset('assets/images/onBoard2.png'),
                  Positioned(
                    bottom: 0.h,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15.w, .0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Become',
                            style: state.firstTitle,
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            color: customOrangeColor,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.w, 0, 25.w, 0),
                              child: Text(
                                'A Mentee',
                                style: state.firstTitle,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Is Just One Step Away',
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
                        Get.toNamed(PageRoutes.onBoard3Screen);
                      },
                      child: SvgPicture.asset(
                          'assets/Icons/forwardBlackIcon.svg')),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .06),
              Image.asset(
                'assets/images/screenPointer2.png',
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
