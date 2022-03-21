import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:resize/resize.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

import '../../../controller/general_controller.dart';
import '../../../widgets/custom_sliver_app_bar.dart';
import '../../../widgets/linear_progress_bar.dart';
import 'logic.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final logic = Get.put(DashboardLogic());

  final state = Get.find<DashboardLogic>().state;
  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'good_morning'.tr;
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'good_afternoon'.tr;
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'good_evening'.tr;
    } else {
      return 'good_night'.tr;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<DashboardLogic>().scrollController = ScrollController()
      ..addListener(Get.find<DashboardLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<DashboardLogic>()
        .scrollController!
        .removeListener(Get.find<DashboardLogic>().scrollListener);
    Get.find<DashboardLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String greetingMes = greetingMessage();
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<DashboardLogic>(
          builder: (_dashboardLogic) => ModalProgressHUD(
                progressIndicator:
                    const CircularProgressIndicator(color: customThemeColor),
                inAsyncCall: _generalController.formLoaderController!,
                child: GestureDetector(
                  onTap: () {
                    _generalController.focusOut(context);
                  },
                  child: Scaffold(
                    backgroundColor: const Color(0xffFBFBFB),
                    body: NestedScrollView(
                        controller: _dashboardLogic.scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            ///---header
                            MyCustomSliverAppBar(
                              heading: 'Dashboard',
                              subHeading: 'Manage All Of Your Appointments',
                              isShrink: _dashboardLogic.isShrink,
                            ),
                          ];
                        },
                        body: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: ListView(
                              children: [
                                ///---mentor-detail
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 0.h),
                                  child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                    color: customTextFieldColor,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 20.h),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Colors.transparent,
                                          child: Stack(
                                            children: [
                                              Hero(
                                                tag: '123',
                                                //  '$mediaUrl${_generalController.getUserProfileModel.data!.userDetail!.imagePath}',
                                                child: Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      // Get.to(ImageViewScreen(
                                                      //   networkImage:
                                                      //   '$mediaUrl${_generalController.getUserProfileModel.data!.userDetail!.imagePath}',
                                                      // ));
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Image.asset(
                                                        'assets/images/consultant1.png',
                                                        width: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const PositionedDirectional(
                                                start: 3,
                                                top: 3,
                                                child: CircleAvatar(
                                                  radius: 5,
                                                  backgroundColor: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Good Morning ',
                                                    style: state
                                                        .mentorDetailTileTitle2TextStyle),
                                                Text('Doctor Sultan',
                                                    style: state
                                                        .mentorDetailTileTitleTextStyle),
                                              ],
                                            ),
                                            Text(
                                                'My name is Dr. Sultan and i am a good doctor for yoo so, appoint me as your mentor',
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: state
                                                    .mentorDetailTileTitle3TextStyle),
                                            // const SizedBox(height: 8,),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.start,
                                            //   children: [
                                            //     Text(
                                            //         'Go Live',
                                            //         style:GoogleFonts.poppins(
                                            //             fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                                            //     const SizedBox(width: 15,),
                                            //     _generalController.getUserProfileModel.data == null
                                            //         ?const SizedBox()
                                            //         :Switch(
                                            //       activeColor: customThemeColor,
                                            //       value: _generalController.getUserProfileModel
                                            //           .data!.userDetail!.mentor!.isLive == 0
                                            //           ? false
                                            //           : true,
                                            //       onChanged: (bool? newValue){
                                            //         // setState(() {
                                            //         //   switchValue = newValue;
                                            //         // });
                                            //         if(newValue!){
                                            //           customDialogForGoLive(context);
                                            //         }else{
                                            //           Get.find<GeneralController>().updateFormLoaderController(true);
                                            //           postMethod(
                                            //               context,
                                            //               inActiveLiveForMentorUrl,
                                            //               {
                                            //                 'token': '123',
                                            //                 'mentor_id': Get.find<GeneralController>().storageBox.read('userId'),
                                            //               },
                                            //               true,
                                            //               inActiveLiveRepo);
                                            //         }
                                            //
                                            //       },
                                            //     ),
                                            //   ],
                                            //
                                            // )
                                          ],
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            // Get.toNamed(PageRoutes.mentorProfileView);
                                          },
                                          child: const Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 15, 5, 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),

                                ///---appointment-details
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 0),
                                  child: Row(
                                    children: [
                                      ///---total-appointment
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  end: 7),
                                          child: Container(
                                            height: 93,
                                            decoration: BoxDecoration(
                                              color: customThemeColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          14, 14, 0, 0),
                                                  child: Text(
                                                    'total_appointments'.tr,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    textAlign: TextAlign.center,
                                                    style: state
                                                        .appointmentCountTitleTextStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                14, 2, 0, 0),
                                                        child: Text(
                                                          '500',
                                                          style: state
                                                              .appointmentCountValueTextStyle,
                                                        ),
                                                      ),
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child:
                                                              Transform.rotate(
                                                            angle: _generalController
                                                                    .isDirectionRTL(
                                                                        context)
                                                                ? 170
                                                                : 0,
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/Icons/appointmentBar-1.svg',
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      ///---cancel-appointment
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 7),
                                          child: Container(
                                            height: 93,
                                            decoration: BoxDecoration(
                                              color: customLightOrangeColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          14, 14, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'appointments_cancel'
                                                            .tr,
                                                        style: state
                                                            .appointmentCountTitleTextStyle!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          14, 2, 0, 0),
                                                  child: Text(
                                                    '500',
                                                    style: state
                                                        .appointmentCountValueTextStyle
                                                        ?.copyWith(
                                                            color: const Color(
                                                                0xffE60047)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: SvgPicture.asset(
                                                        'assets/Icons/appointmentBar-2.svg',
                                                        fit: BoxFit.fill,
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),

                                ///---rating
                                Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 15, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 10),
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 10,
                                              spreadRadius: 3,
                                            )
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 18, 15, 18),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text('Rating',
                                                    style:
                                                        state.headingTextStyle),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                const Text(
                                                  '(190 Total)',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily:
                                                          SarabunFontFamily
                                                              .regular,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 17,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: CircularProgress(
                                                    //---must set the padding inside the package of 5.0
                                                    percentage: 81.0,
                                                    color: customOrangeColor,
                                                    backColor:
                                                        const Color(0xffDBDBDB),
                                                    showPercentage: true,
                                                    textStyle: const TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .bold,
                                                        color:
                                                            customTextBlackColor),
                                                    stroke: 0,
                                                    round: true,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(start: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                              height: 15,
                                                              child: Center(
                                                                child: Text('5',
                                                                    style: state
                                                                        .ratingTextStyle),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            SvgPicture.asset(
                                                                'assets/Icons/ratingStar.svg'),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            const SizedBox(
                                                                width: 120,
                                                                child:
                                                                    ProgressBar(
                                                                  max: 100,
                                                                  current: 80,
                                                                  color:
                                                                      customOrangeColor,
                                                                )),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text('(150)',
                                                                style: state
                                                                    .ratingTextStyle),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                              height: 15,
                                                              child: Center(
                                                                child: Text('4',
                                                                    style: state
                                                                        .ratingTextStyle),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            SvgPicture.asset(
                                                                'assets/Icons/ratingStar.svg'),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            const SizedBox(
                                                                width: 120,
                                                                child:
                                                                    ProgressBar(
                                                                  max: 100,
                                                                  current: 60,
                                                                  color:
                                                                      customOrangeColor,
                                                                )),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text('(98)',
                                                                style: state
                                                                    .ratingTextStyle),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                              height: 15,
                                                              child: Center(
                                                                child: Text('3',
                                                                    style: state
                                                                        .ratingTextStyle),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            SvgPicture.asset(
                                                                'assets/Icons/ratingStar.svg'),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            const SizedBox(
                                                                width: 120,
                                                                child:
                                                                    ProgressBar(
                                                                  max: 100,
                                                                  current: 45,
                                                                  color:
                                                                      customOrangeColor,
                                                                )),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text('(20)',
                                                                style: state
                                                                    .ratingTextStyle),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                              height: 15,
                                                              child: Center(
                                                                child: Text('2',
                                                                    style: state
                                                                        .ratingTextStyle),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            SvgPicture.asset(
                                                                'assets/Icons/ratingStar.svg'),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            const SizedBox(
                                                                width: 120,
                                                                child:
                                                                    ProgressBar(
                                                                  max: 100,
                                                                  current: 30,
                                                                  color:
                                                                      customOrangeColor,
                                                                )),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text('(8)',
                                                                style: state
                                                                    .ratingTextStyle),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                              height: 15,
                                                              child: Center(
                                                                child: Text('1',
                                                                    style: state
                                                                        .ratingTextStyle),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            SvgPicture.asset(
                                                                'assets/Icons/ratingStar.svg'),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            const SizedBox(
                                                                width: 120,
                                                                child:
                                                                    ProgressBar(
                                                                  max: 100,
                                                                  current: 10,
                                                                  color:
                                                                      customOrangeColor,
                                                                )),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text('(1)',
                                                                style: state
                                                                    .ratingTextStyle),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )

                                    //  :
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius: BorderRadius.circular(6),
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //           offset: const Offset(0, 10),
                                    //           color: Colors.grey.withOpacity(0.2),
                                    //           blurRadius: 10,
                                    //           spreadRadius: 3,
                                    //         )
                                    //       ]),
                                    //   child: Padding(
                                    //     padding: const EdgeInsetsDirectional.fromSTEB(
                                    //         15, 18, 15, 18),
                                    //     child: Column(
                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                    //       children: [
                                    //         Row(
                                    //           crossAxisAlignment: CrossAxisAlignment.center,
                                    //           mainAxisAlignment: MainAxisAlignment.start,
                                    //           children: [
                                    //             Text('rating'.tr,
                                    //                 style: state.headingTextStyle),
                                    //             const SizedBox(
                                    //               width: 7,
                                    //             ),
                                    //             const Text(
                                    //               'Total rating',
                                    //               style: TextStyle(
                                    //                   fontSize: 10,
                                    //                   fontFamily: SarabunFontFamily.medium,
                                    //                   color: Colors.black),
                                    //             )
                                    //           ],
                                    //         ),
                                    //         const SizedBox(
                                    //           height: 17,
                                    //         ),
                                    //         Row(
                                    //           mainAxisAlignment: MainAxisAlignment.start,
                                    //           children: [
                                    //             SizedBox(
                                    //               width: 100,
                                    //               height: 100,
                                    //               child: CircularProgress(
                                    //                 //---must set the padding inside the package of 5.0
                                    //                 percentage: ((_mentorHomeLogicController
                                    //                     .getRatingsModel
                                    //                     .data!
                                    //                     .avgRatings! *
                                    //                     100) /
                                    //                     5),
                                    //                 color: customRatingYellowColor,
                                    //                 backColor: customSmoothGreyColor,
                                    //                 showPercentage: true,
                                    //                 textStyle: GoogleFonts.poppins(
                                    //                     fontSize: 18,
                                    //                     fontWeight: FontWeight.bold,
                                    //                     color: Colors.black),
                                    //                 stroke: 0,
                                    //                 round: true,
                                    //               ),
                                    //             ),
                                    //             Expanded(
                                    //               flex: 2,
                                    //               child: Padding(
                                    //                 padding: const EdgeInsetsDirectional.only(
                                    //                     start: 15),
                                    //                 child: Column(
                                    //                   crossAxisAlignment:
                                    //                   CrossAxisAlignment.center,
                                    //                   children: [
                                    //                     Row(
                                    //                       mainAxisAlignment:
                                    //                       MainAxisAlignment.start,
                                    //                       children: [
                                    //                         SizedBox(
                                    //                           width: 10,
                                    //                           height: 15,
                                    //                           child: Center(
                                    //                             child: Text('5',
                                    //                                 style: state
                                    //                                     .ratingTextStyle),
                                    //                           ),
                                    //                         ),
                                    //                         const SizedBox(
                                    //                           width: 2,
                                    //                         ),
                                    //                         SvgPicture.asset(
                                    //                             'assets/ratingStar.svg'),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         SizedBox(
                                    //                             width: 120,
                                    //                             child: ProgressBar(
                                    //                               max: 100,
                                    //                               current: _mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .totalRatings == 0
                                    //                                   ?0
                                    //                                   :((_mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .fiveRatings! *
                                    //                                   100) /
                                    //                                   _mentorHomeLogicController
                                    //                                       .getRatingsModel
                                    //                                       .data!
                                    //                                       .totalRatings!),
                                    //                               color:
                                    //                               customRatingYellowColor,
                                    //                             )),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         Text(
                                    //                          //   '(${_mentorHomeLogicController.getRatingsModel.data!.fiveRatings})',
                                    //                           'Rating'
                                    //                             style: state.ratingTextStyle),
                                    //                       ],
                                    //                     ),
                                    //                     const SizedBox(
                                    //                       height: 12,
                                    //                     ),
                                    //                     Row(
                                    //                       mainAxisAlignment:
                                    //                       MainAxisAlignment.start,
                                    //                       children: [
                                    //                         SizedBox(
                                    //                           width: 10,
                                    //                           height: 15,
                                    //                           child: Center(
                                    //                             child: Text('4',
                                    //                                 style: state
                                    //                                     .ratingTextStyle),
                                    //                           ),
                                    //                         ),
                                    //                         const SizedBox(
                                    //                           width: 2,
                                    //                         ),
                                    //                         SvgPicture.asset(
                                    //                             'assets/ratingStar.svg'),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         SizedBox(
                                    //                             width: 120,
                                    //                             child: ProgressBar(
                                    //                               max: 100,
                                    //                               current: _mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .totalRatings == 0
                                    //                                   ?0
                                    //                                   :((_mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .fourRatings! *
                                    //                                   100) /
                                    //                                   _mentorHomeLogicController
                                    //                                       .getRatingsModel
                                    //                                       .data!
                                    //                                       .totalRatings!),
                                    //                               color:
                                    //                               customRatingYellowColor,
                                    //                             )),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         Text(
                                    //                             '(${_mentorHomeLogicController.getRatingsModel.data!.fourRatings})',
                                    //                             style: state.ratingTextStyle),
                                    //                       ],
                                    //                     ),
                                    //                     const SizedBox(
                                    //                       height: 12,
                                    //                     ),
                                    //                     Row(
                                    //                       mainAxisAlignment:
                                    //                       MainAxisAlignment.start,
                                    //                       children: [
                                    //                         SizedBox(
                                    //                           width: 10,
                                    //                           height: 15,
                                    //                           child: Center(
                                    //                             child: Text('3',
                                    //                                 style: state
                                    //                                     .ratingTextStyle),
                                    //                           ),
                                    //                         ),
                                    //                         const SizedBox(
                                    //                           width: 2,
                                    //                         ),
                                    //                         SvgPicture.asset(
                                    //                             'assets/ratingStar.svg'),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         SizedBox(
                                    //                             width: 120,
                                    //                             child: ProgressBar(
                                    //                               max: 100,
                                    //                               current: _mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .totalRatings == 0
                                    //                                   ?0
                                    //                                   :((_mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .threeRatings! *
                                    //                                   100) /
                                    //                                   _mentorHomeLogicController
                                    //                                       .getRatingsModel
                                    //                                       .data!
                                    //                                       .totalRatings!),
                                    //                               color:
                                    //                               customRatingYellowColor,
                                    //                             )),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         Text(
                                    //                             '(${_mentorHomeLogicController.getRatingsModel.data!.threeRatings})',
                                    //                             style: state.ratingTextStyle),
                                    //                       ],
                                    //                     ),
                                    //                     const SizedBox(
                                    //                       height: 12,
                                    //                     ),
                                    //                     Row(
                                    //                       mainAxisAlignment:
                                    //                       MainAxisAlignment.start,
                                    //                       children: [
                                    //                         SizedBox(
                                    //                           width: 10,
                                    //                           height: 15,
                                    //                           child: Center(
                                    //                             child: Text('2',
                                    //                                 style: state
                                    //                                     .ratingTextStyle),
                                    //                           ),
                                    //                         ),
                                    //                         const SizedBox(
                                    //                           width: 2,
                                    //                         ),
                                    //                         SvgPicture.asset(
                                    //                             'assets/ratingStar.svg'),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         SizedBox(
                                    //                             width: 120,
                                    //                             child: ProgressBar(
                                    //                               max: 100,
                                    //                               current: _mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .totalRatings == 0
                                    //                                   ?0
                                    //                                   :((_mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .twoRatings! *
                                    //                                   100) /
                                    //                                   _mentorHomeLogicController
                                    //                                       .getRatingsModel
                                    //                                       .data!
                                    //                                       .totalRatings!),
                                    //                               color:
                                    //                               customRatingYellowColor,
                                    //                             )),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         Text(
                                    //                             '(${_mentorHomeLogicController.getRatingsModel.data!.twoRatings})',
                                    //                             style: state.ratingTextStyle),
                                    //                       ],
                                    //                     ),
                                    //                     const SizedBox(
                                    //                       height: 12,
                                    //                     ),
                                    //                     Row(
                                    //                       mainAxisAlignment:
                                    //                       MainAxisAlignment.start,
                                    //                       children: [
                                    //                         SizedBox(
                                    //                           width: 10,
                                    //                           height: 15,
                                    //                           child: Center(
                                    //                             child: Text('1',
                                    //                                 style: state
                                    //                                     .ratingTextStyle),
                                    //                           ),
                                    //                         ),
                                    //                         const SizedBox(
                                    //                           width: 2,
                                    //                         ),
                                    //                         SvgPicture.asset(
                                    //                             'assets/ratingStar.svg'),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         SizedBox(
                                    //                             width: 120,
                                    //                             child: ProgressBar(
                                    //                               max: 100,
                                    //                               current: _mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .totalRatings == 0
                                    //                                   ?0
                                    //                                   :((_mentorHomeLogicController
                                    //                                   .getRatingsModel
                                    //                                   .data!
                                    //                                   .oneRatings! *
                                    //                                   100) /
                                    //                                   _mentorHomeLogicController
                                    //                                       .getRatingsModel
                                    //                                       .data!
                                    //                                       .totalRatings!),
                                    //                               color:
                                    //                               customRatingYellowColor,
                                    //                             )),
                                    //                         const SizedBox(
                                    //                           width: 4,
                                    //                         ),
                                    //                         Text(
                                    //                             '(${_mentorHomeLogicController.getRatingsModel.data!.oneRatings})',
                                    //                             style: state.ratingTextStyle),
                                    //                       ],
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    ),
                                const SizedBox(
                                  height: 30,
                                ),

                                ///---today-appointments
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ///---heading
                                      Text(
                                        'today_appointments'.tr,
                                        style: state.headingTextStyle,
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      ///---today
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ///---search-bar
                                          // Container(
                                          //   height: 60,
                                          //   width: MediaQuery.of(context).size.width,
                                          //   color: customStepperColor,
                                          //   child: Padding(
                                          //     padding: const EdgeInsetsDirectional.all(14.0),
                                          //     child: Row(
                                          //       mainAxisAlignment: MainAxisAlignment.start,
                                          //       children: [
                                          //         SizedBox(
                                          //           width: MediaQuery.of(context).size.width * .5,
                                          //           child: TextFormField(
                                          //             style: GoogleFonts.poppins(
                                          //                 fontSize: 14,
                                          //                 fontWeight: FontWeight.normal,
                                          //                 color: Colors.black),
                                          //             controller: _mentorHomeLogicController
                                          //                 .searchController,
                                          //             onFieldSubmitted: (value) {
                                          //               log('$value');
                                          //               Get.find<MentorHomeLogic>()
                                          //                   .updateGetTodayAppointmentLoader(true);
                                          //               // getMethod(context, mentorSearchAppointmentUrl,
                                          //               //     {
                                          //               //       'token': '123',
                                          //               //       'mentor_id': Get.find<GeneralController>().storageBox.read('userId'),
                                          //               //       'search': _mentorHomeLogicController.searchController.text
                                          //               //     }, true, mentorSearchAppointmentRepo);
                                          //             },
                                          //             onChanged: (value) {
                                          //               if (value.isEmpty) {
                                          //                 Get.find<MentorHomeLogic>()
                                          //                     .updateGetTodayAppointmentLoader(
                                          //                         true);
                                          //                 // getMethod(
                                          //                 //     context,
                                          //                 //     mentorAllAppointmentUrl,
                                          //                 //     {
                                          //                 //       'token': '123',
                                          //                 //       'mentor_id': Get.find<GeneralController>().storageBox.read('userId'),
                                          //                 //     },
                                          //                 //     true,
                                          //                 //     getMentorAllAppointmentRepo);
                                          //               }
                                          //             },
                                          //             decoration: InputDecoration(
                                          //                 contentPadding:
                                          //                     const EdgeInsetsDirectional.symmetric(
                                          //                         vertical: 10, horizontal: 20),
                                          //                 fillColor: Colors.white,
                                          //                 filled: true,
                                          //                 hintText: 'Search here',
                                          //                 hintStyle: state.hintTextStyle,
                                          //                 suffixIcon: Padding(
                                          //                   padding: const EdgeInsetsDirectional.all(8),
                                          //                   child: SvgPicture.asset(
                                          //                       'assets/textFieldSearchIcon.svg'),
                                          //                 ),
                                          //                 enabledBorder: OutlineInputBorder(
                                          //                     borderSide: const BorderSide(
                                          //                         color: Colors.white),
                                          //                     borderRadius:
                                          //                         BorderRadius.circular(5)),
                                          //                 focusedBorder: OutlineInputBorder(
                                          //                     borderSide: const BorderSide(
                                          //                         color: Colors.white),
                                          //                     borderRadius:
                                          //                         BorderRadius.circular(5)),
                                          //                 border: OutlineInputBorder(
                                          //                     borderSide: const BorderSide(
                                          //                         color: Colors.white),
                                          //                     borderRadius:
                                          //                         BorderRadius.circular(5))),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),

                                          ///---appointment-list
                                          // _dashboardLogic
                                          //         .getTodayAppointmentLoader!
                                          //     ?
                                          // SkeletonLoader(
                                          //         period: const Duration(
                                          //             seconds: 2),
                                          //         highlightColor: Colors.grey,
                                          //         direction:
                                          //             SkeletonDirection.ltr,
                                          //         builder: Wrap(
                                          //           children: List.generate(10,
                                          //               (index) {
                                          //             return Padding(
                                          //               padding:
                                          //                   const EdgeInsetsDirectional
                                          //                           .fromSTEB(
                                          //                       0, 10, 0, 0),
                                          //               child: Container(
                                          //                 height: 70,
                                          //                 width: MediaQuery.of(
                                          //                         context)
                                          //                     .size
                                          //                     .width,
                                          //                 color:
                                          //                     customOrangeColor,
                                          //               ),
                                          //             );
                                          //           }),
                                          //         )
                                          // )
                                          //  :
                                          // _dashboardLogic
                                          //         .getTodayAppointmentList
                                          //         .isEmpty
                                          //     ? Padding(
                                          //         padding:
                                          //             const EdgeInsetsDirectional
                                          //                 .only(top: 20),
                                          //         child: Center(
                                          //           child: Text(
                                          //             '${'no_appointment'.tr}\n${'for_today'.tr}!',
                                          //             textAlign:
                                          //                 TextAlign.center,
                                          //             style: const TextStyle(
                                          //                 fontSize: 25,
                                          //                 fontWeight:
                                          //                     FontWeight.bold,
                                          //                 color: Colors.black),
                                          //           ),
                                          //         ),
                                          //       )
                                          //     :
                                          Wrap(
                                            children:
                                                List.generate(10, (index) {
                                              return Column(
                                                children: [
                                                  Material(
                                                    color: Colors.white,
                                                    child: RoundedExpansionTile(
                                                      contentPadding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              10, 0, 0, 0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          1)),
                                                      title: Row(
                                                        children: [
                                                          ///---type
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'type'.tr,
                                                                  style: state
                                                                      .appointmentListLabelTextStyle,
                                                                ),
                                                                const SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Text(
                                                                  // '${_mentorHomeLogicController.getTodayAppointmentList[index].appointmentTypeString}'
                                                                  'Chat'
                                                                      .toUpperCase(),
                                                                  style: state
                                                                      .appointmentListValueTextStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          ///---amount
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  'amount'.tr,
                                                                  style: state
                                                                      .appointmentListLabelTextStyle,
                                                                ),
                                                                const SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Text(
                                                                  '100rs',
                                                                  style: state
                                                                      .appointmentListValueTextStyle
                                                                      ?.copyWith(
                                                                          color:
                                                                              customLightThemeColor),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          ///---status
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  'status'.tr,
                                                                  style: state
                                                                      .appointmentListLabelTextStyle,
                                                                ),
                                                                const SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .check,
                                                                      color:
                                                                          customGreenColor,
                                                                      size: 10,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      'accepted'
                                                                          .tr,
                                                                      style: state
                                                                          .appointmentListValueTextStyle,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing:
                                                          SvgPicture.asset(
                                                        'assets/Icons/forwardBlueIcon.svg',
                                                      ),
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  10, 0, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              ///---date
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Text(
                                                                      'date'.tr,
                                                                      style: state
                                                                          .appointmentListLabelTextStyle,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Text(
                                                                      //  '${_mentorHomeLogicController.getTodayAppointmentList[index].date}',
                                                                      '19/2/2022',
                                                                      style: state
                                                                          .appointmentListValueTextStyle,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              ///---time
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Text(
                                                                      'time'.tr,
                                                                      style: state
                                                                          .appointmentListLabelTextStyle,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Text(
                                                                      // '${_mentorHomeLogicController.getTodayAppointmentList[index].time}',
                                                                      '9:00 am',
                                                                      style: state
                                                                          .appointmentListValueTextStyle,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              ///---payment-status
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Text(
                                                                      'p_status'
                                                                          .tr,
                                                                      style: state
                                                                          .appointmentListLabelTextStyle,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    // _mentorHomeLogicController
                                                                    //     .getTodayAppointmentList[
                                                                    // index]
                                                                    //     .isPaid ==
                                                                    //     0
                                                                    //     ?
                                                                    // Row(
                                                                    //   children: [
                                                                    //     const Icon(
                                                                    //       Icons
                                                                    //           .cancel_outlined,
                                                                    //       color: Colors
                                                                    //           .red,
                                                                    //       size:
                                                                    //       10,
                                                                    //     ),
                                                                    //     const SizedBox(
                                                                    //       width:
                                                                    //       5,
                                                                    //     ),
                                                                    //     Text(
                                                                    //       'Un_paid'
                                                                    //           .tr,
                                                                    //       style: state
                                                                    //           .appointmentListValueTextStyle,
                                                                    //     ),
                                                                    //   ],
                                                                    // )
                                                                    //  :
                                                                    Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .check,
                                                                          color:
                                                                              customThemeColor,
                                                                          size:
                                                                              10,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          'paid'
                                                                              .tr,
                                                                          style:
                                                                              state.appointmentListValueTextStyle,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .08,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  10,
                                                                  10,
                                                                  0,
                                                                  10),
                                                          child: Row(
                                                            children: [
                                                              ///---action
                                                              Expanded(
                                                                flex: 2,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Text(
                                                                      'action'
                                                                          .tr,
                                                                      style: state
                                                                          .appointmentListLabelTextStyle,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            //   Get.put(
                                                                            //       MentorAppointmentLogLogic());
                                                                            //
                                                                            //   Get.to(
                                                                            //       MentorAppointmentDetailPage(
                                                                            //         singleAppointmentModel:
                                                                            //         _mentorHomeLogicController
                                                                            //             .getTodayAppointmentList[index],
                                                                            //       ));
                                                                          },
                                                                          child:
                                                                              const Padding(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                5,
                                                                                0,
                                                                                8,
                                                                                0),
                                                                            child:
                                                                                Icon(
                                                                              Icons.visibility,
                                                                              color: customThemeColor,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 14,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color:
                                                        const Color(0xffE8E8E8),
                                                  )
                                                ],
                                              );
                                            }),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ));
    });
  }
}
