import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../../route_generator.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_bottom_bar.dart';
import 'logic.dart';

class ProfileCreatedPage extends StatefulWidget {
  const ProfileCreatedPage({Key? key}) : super(key: key);

  @override
  State<ProfileCreatedPage> createState() => _ProfileCreatedPageState();
}

class _ProfileCreatedPageState extends State<ProfileCreatedPage> {
  final logic = Get.put(ProfileCreatedLogic());

  final state = Get.find<ProfileCreatedLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ProfileCreatedLogic>().scrollController = ScrollController()
      ..addListener(Get.find<ProfileCreatedLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<ProfileCreatedLogic>()
        .scrollController!
        .removeListener(Get.find<ProfileCreatedLogic>().scrollListener);
    Get.find<ProfileCreatedLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ProfileCreatedLogic>(builder: (_profileCreatedLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: customThemeColor,
            body: NestedScrollView(
              controller: _profileCreatedLogic.scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  ///---header
                  SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .29,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 0,
                      backgroundColor: _profileCreatedLogic.isShrink
                          ? customThemeColor
                          : Colors.transparent,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
                          ],
                        ),
                      ),
                      // actions: const [
                      //   ///---notifications
                      //   CustomNotificationIcon()
                      // ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40.r))),
                          child: Column(children: [
                            Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Image.asset(
                                    'assets/images/registrationBackground.png',
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                  ),
                                ),
                                SafeArea(
                                    child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.w, 25.h, 16.w, 16.h),
                                  child: Stack(children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          Text('Registration',
                                              style: state.headingTextStyle),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            'Register As A Mentor In Few Easy Steps',
                                            style: state.subHeadingTextStyle,
                                          ),
                                          SizedBox(height: 30.h),

                                          /// Registration Status

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 40.h,
                                                width: 40.h,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: customGreenColor),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 22.sp,
                                                )),
                                              ),
                                              SizedBox(height: 5.h),
                                              Container(
                                                height: 5.h,
                                                width: 50.w,
                                                color: customGreenColor,
                                              ),
                                              Container(
                                                height: 40.h,
                                                width: 40.h,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: customGreenColor),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 22.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              Container(
                                                height: 5.h,
                                                width: 50.w,
                                                color: customGreenColor,
                                              ),
                                              Container(
                                                height: 40.h,
                                                width: 40.h,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: customGreenColor),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 22.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              Container(
                                                height: 5.h,
                                                width: 50.w,
                                                color: customGreenColor,
                                              ),
                                              Container(
                                                height: 40.h,
                                                width: 40.h,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: customGreenColor),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 22.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                            ],
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment
                                          //           .spaceBetween,
                                          //   children: [
                                          //     const Text('\$350.00',
                                          //         style: TextStyle(
                                          //           color: Colors.white,
                                          //           fontSize: 22,
                                          //         )),
                                          //     CircleAvatar(
                                          //       radius: 20.r,
                                          //       backgroundColor: Colors.white,
                                          //       child: Center(
                                          //           child: SvgPicture.asset(
                                          //         'assets/Icons/add.svg',
                                          //         height: 20.h,
                                          //         width: 20.w,
                                          //         color: customOrangeColor,
                                          //         fit: BoxFit.cover,
                                          //       )),
                                          //     ),
                                          //   ],
                                          // ),
                                          /// status text
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.w, 8.h, 15.w, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'General Info',
                                                  style: state.descTextStyle,
                                                ),
                                                Text(
                                                  'Educational Info',
                                                  style: state.descTextStyle,
                                                ),
                                                Text(
                                                  'Skill Info',
                                                  style: state.descTextStyle,
                                                ),
                                                Text(
                                                  'Schedule',
                                                  style: state.descTextStyle,
                                                )
                                              ],
                                            ),
                                          )
                                        ]),
                                  ]),
                                )),
                              ],
                            ),
                          ]),
                        ),
                      ))
                ];
              },
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: customTextFieldColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .14),
                      SvgPicture.asset(
                        'assets/images/successfullImage.svg',
                        height: 120.h,
                        width: 177.w,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),
                      Center(
                        child: Text(
                          'Profile Created',
                          style: state.successHeadingTextStyle,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Successfully',
                        style: state.successSubHeadingTextStyle,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0.h,
                    left: 15.w,
                    right: 15.w,
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(PageRoutes.dashboardScreen);
                        },
                        child: const MyCustomBottomBar(
                            title: 'Go To Dashboard', disable: false)),
                  ),
                ]),
              ),
            ),
          ),
        );
      });
    });
  }
}
