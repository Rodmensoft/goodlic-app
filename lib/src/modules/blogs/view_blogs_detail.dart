import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/notififcation_icon.dart';
import 'logic.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({Key? key}) : super(key: key);

  @override
  State<BlogDetailPage> createState() => _BlogDetailPage();
}

class _BlogDetailPage extends State<BlogDetailPage> {
  final logic = Get.put(BlogsLogic());

  final state = Get.find<BlogsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BlogsLogic>(builder: (_blogDetailLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .35,
                      // floating: true,
                      pinned: true,
                      // snap: true,
                      elevation: 0,
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
                      backgroundColor: customLightThemeColor,
                      actions: const [
                        ///---notifications

                        CustomNotificationIcon(color: Colors.white)
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(30),
                        child: Container(
                          height: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.r)),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 3,
                                    offset: Offset(0, 1))
                              ]),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: Image.asset(
                            'assets/images/real-estate-01.png',
                            fit: BoxFit.cover,
                          )
                          // SafeArea(
                          //   child: Stack(
                          //     children: [
                          //       Positioned(
                          //         top: 0,
                          //         child: Container(
                          //           color: customLightThemeColor,
                          //           width: MediaQuery.of(context).size.width,
                          //           child: Center(
                          //               child: Image.asset(
                          //             'assets/images/stackImage.png',
                          //             width: MediaQuery.of(context).size.width *
                          //                 .5,
                          //             fit: BoxFit.cover,
                          //           )),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                          ),
                    ),
                  ];
                },
                body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h),
                          Container(
                            height: 25.h,
                            width: 108.w,
                            decoration: BoxDecoration(
                                color: customLightGreenColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.r))),
                            child: Center(
                              child: Text(
                                'REAL ESTATE',
                                style: state.blogCategoryTextStyle
                                    ?.copyWith(color: customGreenColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
          ),
        );
      });
    });
  }
}
