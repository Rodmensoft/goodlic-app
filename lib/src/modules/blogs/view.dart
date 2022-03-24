import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../route_generator.dart';
import '../../controller/general_controller.dart';
import '../../widgets/custom_sliver_app_bar.dart';
import 'logic.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  final logic = Get.put(BlogsLogic());

  final state = Get.find<BlogsLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<BlogsLogic>().scrollController = ScrollController()
      ..addListener(Get.find<BlogsLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<BlogsLogic>()
        .scrollController!
        .removeListener(Get.find<BlogsLogic>().scrollListener);
    Get.find<BlogsLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BlogsLogic>(builder: (_blogsLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _blogsLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: 'Blog',
                      subHeading: "Explore Today's Trending Articles",
                      isShrink: _blogsLogic.isShrink,
                    ),
                  ];
                },
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: state.headingTextStyle,
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: 207.h,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 12.w, 0),
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            //  height: 207.h,
                                            width: 183.w,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.r)),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/real-estate-01.png'),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Positioned(
                                            bottom: 20,
                                            child: Text(
                                              'Real Estate',
                                              style: state.categoryTextStyle,
                                            ),
                                          )
                                        ]),
                                  ),
                                )),
                          ),
                          SizedBox(height: 30.h),

                          /// Text
                          Text(
                            'For You',
                            style: state.headingTextStyle,
                          ),
                          SizedBox(height: 30.h),

                          /// category Text
                          SizedBox(
                            child: Column(
                                //   scrollDirection: Axis.vertical,
                                children: List.generate(
                              5,
                              (index) => Column(
                                  //  color: Colors.grey,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            PageRoutes.blogDetailScreen);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 25.h,
                                                  width: 108.w,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          customLightOrangeColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6.r))),
                                                  child: Center(
                                                    child: Text(
                                                      'EDUCATION',
                                                      style: state
                                                          .blogCategoryTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),

                                                /// Time
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/Icons/blogTimeIcon.svg'),
                                                    Text(
                                                      ' 25-2-22',
                                                      style: state
                                                          .blogCategoryTextStyle
                                                          ?.copyWith(
                                                              color:
                                                                  customTextBlackColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.h),

                                                /// Blog name
                                                Text(
                                                  'Clarity Learning and\nDevelopment Process',
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style:
                                                      state.blogNameTextStyle,
                                                ),
                                                SizedBox(height: 20.h),

                                                /// Author name
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 40.h,
                                                      width: 40.w,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              shape: BoxShape
                                                                  .circle),
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      'John Doe',
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: state
                                                          .blogNameTextStyle,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 16.w, 0),
                                            child: Container(
                                              height: 153.h,
                                              width: 128.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.r)),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/blogImage1.png'),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 16.w, 0),
                                      child: const Divider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                  ]),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        );
      });
    });
  }
}
