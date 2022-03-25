import 'package:consultant_product/src/modules/blogs/repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../route_generator.dart';
import '../../api_services/get_service.dart';
import '../../api_services/urls.dart';
import '../../controller/general_controller.dart';
import '../../utils/constants.dart';
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

  TabController? blogsTabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMethod(context, blogCategoriesUrl, {'token': '123'}, false, blogRepo);

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
                  child:
                      // _blogsLogic.blogLoader! &&
                      //         _blogsLogic
                      //             .getAllBlogModel.data!.featuredBlogs!.isEmpty
                      //     ? const SizedBox()
                      //     :
                      Padding(
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
                          !_blogsLogic.blogLoader!
                              ? SkeletonLoader(
                                  period: const Duration(seconds: 2),
                                  highlightColor: Colors.grey,
                                  direction: SkeletonDirection.ltr,
                                  builder: SizedBox(
                                    height: 207.h,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(3, (index) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 15, 0),
                                          child: Container(
                                            width: 183.w,
                                            height: 207.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ))
                              : SizedBox(
                                  height: 207.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(
                                        3,
                                        // _blogsLogic.getAllBlogModel.data!
                                        //     .featuredBlogs!.length,
                                        (index) => Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 12.w, 0),
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: 207.h,
                                                  width: 183.w,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.r)),
                                                      image: const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/real-estate-01.png'),
                                                          fit: BoxFit.cover)),
                                                  // child: ClipRRect(
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(
                                                  //             14),
                                                  //     child: _blogsLogic
                                                  //                 .getAllBlogModel
                                                  //                 .data!
                                                  //                 .featuredBlogs![
                                                  //                     index]
                                                  //                 .imagePath
                                                  //                 .toString() !=
                                                  //             'null'
                                                  //         ? Image.network(
                                                  //             '$mediaUrl${_blogsLogic.getAllBlogModel.data!.featuredBlogs![index].imagePath}',
                                                  //             fit: BoxFit.cover,
                                                  //           )
                                                  //         : Image.asset(
                                                  //             'assets/images/real-estate-01.png',
                                                  //             fit: BoxFit.cover,
                                                  //           )),
                                                ),
                                                // Positioned(
                                                //   bottom: 20,
                                                //   child: Text(
                                                //     '${_blogsLogic.getAllBlogModel.data!.featuredBlogs![index].title}',
                                                //     style:
                                                //         state.categoryTextStyle,
                                                //   ),
                                                // )
                                                Positioned(
                                                  bottom: 20,
                                                  child: Text(
                                                    'REAL ESTATE',
                                                    style:
                                                        state.categoryTextStyle,
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
                          // !_blogsLogic.blogLoader!
                          //     ? SkeletonLoader(
                          //         period: const Duration(seconds: 2),
                          //         highlightColor: Colors.grey,
                          //         direction: SkeletonDirection.ltr,
                          //         builder: SizedBox(
                          //           height: 220.h,
                          //           width: MediaQuery.of(context).size.width,
                          //           child: ListView(
                          //             children: List.generate(3, (index) {
                          //               return Padding(
                          //                 padding: const EdgeInsetsDirectional
                          //                     .fromSTEB(0, 0, 15, 0),
                          //                 child: Container(
                          //                   height: 220.h,
                          //                   decoration: BoxDecoration(
                          //                     borderRadius:
                          //                         BorderRadius.circular(14),
                          //                     color: Colors.white,
                          //                   ),
                          //                 ),
                          //               );
                          //             }),
                          //           ),
                          //         ))
                          //     : SizedBox(
                          //         child: Column(
                          //             //   scrollDirection: Axis.vertical,
                          //             children: List.generate(
                          //           _blogsLogic.getAllBlogModel.data!
                          //               .categoryBlogs!.length,
                          //           (index) => Column(
                          //               //  color: Colors.grey,
                          //               children: [
                          //                 InkWell(
                          //                   onTap: () {
                          //                     _blogsLogic.updateSelectedBlogForView(
                          //                         _blogsLogic
                          //                             .getAllBlogModel
                          //                             .data!
                          //                             .categoryBlogs![_blogsLogic
                          //                                 .selectedBlogCategoryIndex!]
                          //                             .blogs![index]);
                          //                     Get.toNamed(
                          //                         PageRoutes.blogDetailScreen);
                          //                   },
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceEvenly,
                          //                     children: [
                          //                       Expanded(
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .start,
                          //                           children: [
                          //                             Container(
                          //                               height: 25.h,
                          //                               width: 108.w,
                          //                               decoration: BoxDecoration(
                          //                                   color:
                          //                                       customLightOrangeColor,
                          //                                   borderRadius:
                          //                                       BorderRadius.all(
                          //                                           Radius.circular(
                          //                                               6.r))),
                          //                               child: Center(
                          //                                 child: Text(
                          //                                   '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![index].category!.name}',
                          //                                   style: state
                          //                                       .blogCategoryTextStyle,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                             SizedBox(height: 15.h),
                          //
                          //                             /// Time
                          //                             Row(
                          //                               children: [
                          //                                 SvgPicture.asset(
                          //                                     'assets/Icons/blogTimeIcon.svg'),
                          //                                 Text(
                          //                                   ' ${_blogsLogic.getAllBlogModel.data!.categoryBlogs![index].category!.createdAt!.substring(0, 10)}',
                          //                                   style: state
                          //                                       .blogCategoryTextStyle
                          //                                       ?.copyWith(
                          //                                           color:
                          //                                               customTextBlackColor),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                             SizedBox(height: 10.h),
                          //
                          //                             /// Blog name
                          //                             Text(
                          //                               '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].title}',
                          //                               softWrap: true,
                          //                               overflow: TextOverflow
                          //                                   .ellipsis,
                          //                               maxLines: 2,
                          //                               style: state
                          //                                   .blogNameTextStyle,
                          //                             ),
                          //                             SizedBox(height: 20.h),
                          //
                          //                             /// Author name
                          //                             Row(
                          //                               children: [
                          //                                 Container(
                          //                                   height: 50.h,
                          //                                   width: 50.w,
                          //                                   child: ClipRRect(
                          //                                     borderRadius:
                          //                                         BorderRadius
                          //                                             .circular(
                          //                                                 25),
                          //                                     child: _blogsLogic
                          //                                                 .getAllBlogModel
                          //                                                 .data!
                          //                                                 .categoryBlogs![_blogsLogic
                          //                                                     .selectedBlogCategoryIndex!]
                          //                                                 .blogs![
                          //                                                     index]
                          //                                                 .imagePath
                          //                                                 .toString() !=
                          //                                             'null'
                          //                                         ? Image
                          //                                             .network(
                          //                                             '$mediaUrl${_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].imagePath}',
                          //                                             fit: BoxFit
                          //                                                 .cover,
                          //                                             height:
                          //                                                 60,
                          //                                             width: 60,
                          //                                           )
                          //                                         : Container(
                          //                                             height:
                          //                                                 50.h,
                          //                                             width:
                          //                                                 50.w,
                          //                                             decoration: const BoxDecoration(
                          //                                                 color: Colors
                          //                                                     .grey,
                          //                                                 shape:
                          //                                                     BoxShape.circle),
                          //                                           ),
                          //                                   ),
                          //                                 ),
                          //                                 SizedBox(width: 8.w),
                          //                                 Text(
                          //                                   'John Doe',
                          //                                   softWrap: true,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                   maxLines: 1,
                          //                                   style: state
                          //                                       .blogNameTextStyle,
                          //                                 ),
                          //                               ],
                          //                             )
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       Padding(
                          //                         padding: EdgeInsetsDirectional
                          //                             .fromSTEB(0, 0, 16.w, 0),
                          //                         child: Container(
                          //                           height: 153.h,
                          //                           width: 128.w,
                          //                           decoration: BoxDecoration(
                          //                             color: Colors.grey,
                          //                             borderRadius:
                          //                                 BorderRadius.all(
                          //                                     Radius.circular(
                          //                                         10.r)),
                          //                             // image: const DecorationImage(
                          //                             //     image: AssetImage(
                          //                             //         'assets/images/blogImage1.png'),
                          //                             //     fit: BoxFit.cover)
                          //                           ),
                          //                           child: ClipRRect(
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(14),
                          //                               child: _blogsLogic
                          //                                           .getAllBlogModel
                          //                                           .data!
                          //                                           .categoryBlogs![
                          //                                               index]
                          //                                           .category!
                          //                                           .imagePath
                          //                                           .toString() !=
                          //                                       'null'
                          //                                   ? Image.network(
                          //                                       '$mediaUrl${_blogsLogic.getAllBlogModel.data!.categoryBlogs![index].category!.imagePath}',
                          //                                       fit: BoxFit
                          //                                           .cover,
                          //                                     )
                          //                                   : Image.asset(
                          //                                       'assets/images/blogImage1.png',
                          //                                       fit: BoxFit
                          //                                           .cover,
                          //                                     )),
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 SizedBox(height: 15.h),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsetsDirectional.fromSTEB(
                          //                           0, 0, 16.w, 0),
                          //                   child: const Divider(
                          //                     color: Colors.grey,
                          //                   ),
                          //                 ),
                          //                 SizedBox(height: 20.h),
                          //               ]),
                          //         )),
                          //       ),

                          ///==========///

                          ///---tabs
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 0, 15, 0),
                            child: !_blogsLogic.blogLoader!
                                ? SkeletonLoader(
                                    period: const Duration(seconds: 2),
                                    highlightColor: Colors.grey,
                                    direction: SkeletonDirection.ltr,
                                    builder: SizedBox(
                                      height: 220.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView(
                                        children: List.generate(3, (index) {
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 15, 0),
                                            child: Container(
                                              height: 220.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ))
                                : DefaultTabController(
                                    length: _blogsLogic.getAllBlogModel.data!
                                        .categoryBlogs!.length,
                                    child: TabBar(
                                        onTap: (index) {
                                          setState(() {
                                            _blogsLogic
                                                .updateSelectedBlogCategoryIndex(
                                                    index);
                                          });
                                        },
                                        isScrollable: true,
                                        controller: blogsTabController,
                                        indicatorColor: customThemeColor,
                                        indicator: const UnderlineTabIndicator(
                                            insets: EdgeInsetsDirectional.only(
                                                end: 20),
                                            borderSide: BorderSide(
                                              width: 2.0,
                                              color: customThemeColor,
                                            )),
                                        labelStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: customThemeColor),
                                        labelColor: customThemeColor,
                                        unselectedLabelColor:
                                            const Color(0xff727377),
                                        unselectedLabelStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff727377),
                                        ),
                                        labelPadding:
                                            const EdgeInsetsDirectional.all(1),
                                        tabs: List.generate(
                                            _blogsLogic
                                                .getAllBlogModel
                                                .data!
                                                .categoryBlogs!
                                                .length, (tabIndex) {
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(bottom: 5, end: 20),
                                            child: Text(
                                              '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![tabIndex].category!.name}',
                                            ),
                                          );
                                        })),
                                  ),
                          ),
                          _blogsLogic
                                  .getAllBlogModel.data!.categoryBlogs!.isEmpty
                              ? Center(
                                  child: Text('${'no_record_found'.tr}!',
                                      style:
                                          // GoogleFonts.poppins(
                                          //     fontWeight: FontWeight.w600,
                                          //     fontSize: 14,
                                          //     color: Colors.black),
                                          TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily:
                                                  SarabunFontFamily.light,
                                              color: customTextBlackColor)),
                                )
                              : Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 10, 15, 0),
                                  child: SingleChildScrollView(
                                    child: !_blogsLogic.blogLoader!
                                        ? SkeletonLoader(
                                            period: const Duration(seconds: 2),
                                            highlightColor: Colors.grey,
                                            direction: SkeletonDirection.ltr,
                                            builder: Wrap(
                                                children: List.generate(
                                                    3,
                                                    (index) => Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .only(
                                                                bottom: 10),
                                                        child: Container(
                                                          height: 90,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )))))
                                        : Builder(builder: (_) {
                                            return _blogsLogic
                                                    .getAllBlogModel
                                                    .data!
                                                    .categoryBlogs![_blogsLogic
                                                        .selectedBlogCategoryIndex!]
                                                    .blogs!
                                                    .isEmpty
                                                ? Center(
                                                    child: Text(
                                                        '${'no_record_found'.tr}!',
                                                        style:
                                                            // GoogleFonts.poppins(
                                                            //     fontWeight:
                                                            //         FontWeight
                                                            //             .w600,
                                                            //     fontSize: 14,
                                                            //     color:
                                                            //         Colors.black),
                                                            TextStyle(
                                                                fontSize: 14.sp,
                                                                fontFamily:
                                                                    SarabunFontFamily
                                                                        .light,
                                                                color:
                                                                    customTextBlackColor)),
                                                  )
                                                : SizedBox(
                                                    child: Column(
                                                        //   scrollDirection: Axis.vertical,
                                                        children: List.generate(
                                                      _blogsLogic
                                                          .getAllBlogModel
                                                          .data!
                                                          .categoryBlogs!
                                                          .length,
                                                      (index) => Column(
                                                          //  color: Colors.grey,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                _blogsLogic.updateSelectedBlogForView(_blogsLogic
                                                                    .getAllBlogModel
                                                                    .data!
                                                                    .categoryBlogs![
                                                                        _blogsLogic
                                                                            .selectedBlogCategoryIndex!]
                                                                    .blogs![index]);
                                                                Get.toNamed(
                                                                    PageRoutes
                                                                        .blogDetail);
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              25.h,
                                                                          width:
                                                                              108.w,
                                                                          decoration: BoxDecoration(
                                                                              color: customLightOrangeColor,
                                                                              borderRadius: BorderRadius.all(Radius.circular(6.r))),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![index].category!.name}',
                                                                              style: state.blogCategoryTextStyle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                15.h),

                                                                        /// Time
                                                                        Row(
                                                                          children: [
                                                                            SvgPicture.asset('assets/Icons/blogTimeIcon.svg'),
                                                                            Text(
                                                                              ' ${_blogsLogic.getAllBlogModel.data!.categoryBlogs![index].category!.createdAt!.substring(0, 10)}',
                                                                              style: state.blogCategoryTextStyle?.copyWith(color: customTextBlackColor),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                10.h),

                                                                        /// Blog name
                                                                        Text(
                                                                          '${_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].title}',
                                                                          softWrap:
                                                                              true,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              state.blogNameTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                20.h),

                                                                        /// Author name
                                                                        // Row(
                                                                        //   children: [
                                                                        //     Container(
                                                                        //       height: 50.h,
                                                                        //       width: 50.w,
                                                                        //       child: ClipRRect(
                                                                        //         borderRadius: BorderRadius.circular(25),
                                                                        //         child: _blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].imagePath.toString() != 'null'
                                                                        //             ? Image.network(
                                                                        //                 '$mediaUrl${_blogsLogic.getAllBlogModel.data!.categoryBlogs![_blogsLogic.selectedBlogCategoryIndex!].blogs![index].imagePath}',
                                                                        //                 fit: BoxFit.cover,
                                                                        //                 height: 60,
                                                                        //                 width: 60,
                                                                        //               )
                                                                        //             : Container(
                                                                        //                 height: 50.h,
                                                                        //                 width: 50.w,
                                                                        //                 decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                                                                        //               ),
                                                                        //       ),
                                                                        //     ),
                                                                        //     SizedBox(width: 8.w),
                                                                        //     Text(
                                                                        //       'John Doe',
                                                                        //       softWrap: true,
                                                                        //       overflow: TextOverflow.ellipsis,
                                                                        //       maxLines: 1,
                                                                        //       style: state.blogNameTextStyle,
                                                                        //     ),
                                                                        //   ],
                                                                        // )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            16.w,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          153.h,
                                                                      width:
                                                                          128.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10.r)),
                                                                        // image: const DecorationImage(
                                                                        //     image: AssetImage(
                                                                        //         'assets/images/blogImage1.png'),
                                                                        //     fit: BoxFit.cover)
                                                                      ),
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(14),
                                                                          child: _blogsLogic.getAllBlogModel.data!.categoryBlogs![index].category!.imagePath.toString() != 'null'
                                                                              ? Image.network(
                                                                                  '$mediaUrl${_blogsLogic.getAllBlogModel.data!.categoryBlogs![index].category!.imagePath}',
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              : Image.asset(
                                                                                  'assets/images/blogImage1.png',
                                                                                  fit: BoxFit.cover,
                                                                                )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15.h),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          16.w,
                                                                          0),
                                                              child:
                                                                  const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 20.h),
                                                          ]),
                                                    )),
                                                  );
                                          }),
                                  ),
                                )

                          /// ========///
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
