import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class UserDrawerPage extends StatefulWidget {
  const UserDrawerPage({Key? key}) : super(key: key);

  @override
  State<UserDrawerPage> createState() => _UserDrawerPageState();
}

class _UserDrawerPageState extends State<UserDrawerPage> {
  final logic = Get.put(UserDrawerLogic());

  final state = Get.find<UserDrawerLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDrawerLogic>(builder: (_userDrawerLogic) {
      return Scaffold(
        backgroundColor: customThemeColor,
        body: Stack(
          children: [
            ///---background
            PositionedDirectional(
                top: 0,
                end: 0,
                child: Image.asset(
                  'assets/images/drawerBackground.png',
                  width: MediaQuery.of(context).size.width * .8,
                )),

            ///---body
            SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),

                    ///---profile-area
                    ListTile(
                      onTap: () {
                        Get.toNamed(PageRoutes.login);
                      },
                      leading: Container(
                        height: 49.h,
                        width: 49.w,
                        decoration: const BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                      ),

                      ///---name
                      title: Text(
                        'William Smith',
                        style: state.nameTextStyle,
                      ),

                      ///---email
                      subtitle: Text(
                        'WilliamSmith12@gmail.com',
                        style: state.emailTextStyle,
                      ),
                      trailing: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/Icons/drawerBackArrowIcon.svg'),
                            ],
                          )),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),

                    ///---list
                    Expanded(
                        child: ListView(
                      children: List.generate(
                          _userDrawerLogic.drawerList.length, (index) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70.w),
                            child: FadedSlideAnimation(
                              slideDuration: const Duration(milliseconds: 1000),
                              fadeDuration: const Duration(milliseconds: 2000),
                              beginOffset: const Offset(0.3, 0.2),
                              endOffset: const Offset(0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    onTap: (){
                                      _userDrawerLogic.userDrawerNavigation(index, context);
                                    },
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          '${_userDrawerLogic.drawerList[index].icon}',
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                      ],
                                    ),
                                    title: Text(
                                      '${_userDrawerLogic.drawerList[index].title}',
                                      style: state.titleTextStyle,
                                    ),
                                  ),
                                  Divider(
                                    color: const Color(0xff404191),
                                    thickness: 1.5,
                                    height: 10.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 15.h),
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/Icons/drawerLogoutIcon.svg',
                              height: 20.h,
                              width: 20.w,
                            ),
                          ],
                        ),
                        title: Text(
                          'Logout',
                          style: state.titleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
