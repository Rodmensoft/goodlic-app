import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/appointment_detail/widget/bottom_sheet.dart';
import 'package:consultant_product/src/modules/user/my_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/my_appointment/widgets/appontment_detail_box.dart';
import 'package:consultant_product/src/modules/user/ratings/rating_exist_repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class AppointmentDetailPage extends StatefulWidget {
  const AppointmentDetailPage({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailPage> createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  final logic = Get.put(AppointmentDetailLogic());

  final state = Get.find<AppointmentDetailLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMethod(
        context,
        getExistRatingUrl,
        {
          'token': '123',
          'mentor_id': Get.find<AppointmentDetailLogic>()
              .selectedAppointmentData
              .mentorId,
          'appointment_id':
              Get.find<AppointmentDetailLogic>().selectedAppointmentData.id
        },
        true,
        ratingExistRepo);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateUserIdForSendNotification(
          Get.find<AppointmentDetailLogic>().selectedAppointmentData.mentorId);
    });

    Get.find<AppointmentDetailLogic>().scrollController = ScrollController()
      ..addListener(Get.find<AppointmentDetailLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<AppointmentDetailLogic>()
        .scrollController!
        .removeListener(Get.find<AppointmentDetailLogic>().scrollListener);
    Get.find<AppointmentDetailLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<AppointmentDetailLogic>(
          builder: (_appointmentDetailLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _appointmentDetailLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header

                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .24,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 0,
                      backgroundColor: _appointmentDetailLogic.isShrink
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
                      actions: const [
                        ///---notifications

                        CustomNotificationIcon()
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40.r))),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .27,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.w, 25.h, 16.w, 16.h),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              Text(
                                                'Appt. Detail',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.bold,
                                                    fontSize: 28.sp,
                                                    color:
                                                        customLightThemeColor),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Your Appointment Detail With ${_appointmentDetailLogic.selectedAppointmentData.mentor!.firstName}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SarabunFontFamily
                                                                .medium,
                                                        fontSize: 12.sp,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          ///---CHAT
                                          _appointmentDetailLogic
                                                      .selectedAppointmentData
                                                      .appointmentStatus! !=
                                                  1
                                              ? const SizedBox()
                                              : _appointmentDetailLogic
                                                          .selectedAppointmentData
                                                          .appointmentTypeString!
                                                          .toUpperCase() ==
                                                      'CHAT'
                                                  ? PositionedDirectional(
                                                      end: 0,
                                                      top: 45.h,
                                                      child: InkWell(
                                                        onTap: () =>
                                                            _appointmentDetailLogic
                                                                .chatOnTap(
                                                                    context),
                                                        child: CircleAvatar(
                                                          radius: 20.r,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                            'assets/Icons/chatIcon.svg',
                                                            height: 15.h,
                                                            width: 15.w,
                                                            color:
                                                                customOrangeColor,
                                                            fit: BoxFit.cover,
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),

                                          // ///---LIVE
                                          // (_appointmentDetailLogic
                                          //     .selectedAppointmentData.appointmentStatus! ==
                                          //     1) &&
                                          //     (_appointmentDetailLogic
                                          //         .selectedAppointmentData
                                          //         .appointmentTypeString!
                                          //         .toUpperCase() ==
                                          //         'LIVE')
                                          //     ? Row(
                                          //   children: [
                                          //     InkWell(
                                          //       onTap: () {
                                          //         Get.find<PusherChatLogic>()
                                          //             .updateGetMessagesLoader(true);
                                          //         Get.find<PusherChatLogic>()
                                          //             .updateSenderMessageGetId(
                                          //             Get.find<GeneralController>()
                                          //                 .storageBox
                                          //                 .read('userId'));
                                          //         Get.find<PusherChatLogic>()
                                          //             .updateReceiverMessageGetId(widget
                                          //             .singleAppointmentModel!.menteeId);
                                          //         Get.to(const ChatView());
                                          //       },
                                          //       child: Padding(
                                          //         padding: const EdgeInsetsDirectional.all(8.0),
                                          //         child: Text(
                                          //           'chat_box'.tr,
                                          //           style: state.chatBoxTextStyle,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     InkWell(
                                          //       onTap: () {
                                          //         Get.find<GeneralController>()
                                          //             .updateSelectedChannel(
                                          //             Get.find<GeneralController>()
                                          //                 .getRandomString(10));
                                          //         Get.find<GeneralController>()
                                          //             .updateChannelForCall(
                                          //             Get.find<GeneralController>()
                                          //                 .selectedChannel);
                                          //         log('----------->>> ${Get.find<GeneralController>().selectedChannel}');
                                          //         getMethod(
                                          //             context,
                                          //             agoraTokenUrl,
                                          //             {
                                          //               'token': '123',
                                          //               'channel': Get.find<GeneralController>()
                                          //                   .selectedChannel
                                          //             },
                                          //             true,
                                          //             getAgoraTokenRepo);
                                          //         Get.find<GeneralController>()
                                          //             .updateGoForCall(true);
                                          //         Get.toNamed(PageRoutes.videoCallWaiting);
                                          //       },
                                          //       child: const Padding(
                                          //         padding:
                                          //         EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                          //         child: Icon(
                                          //           Icons.video_call,
                                          //           color: customThemeColor,
                                          //           size: 25,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     InkWell(
                                          //       onTap: () {
                                          //         Get.find<GeneralController>()
                                          //             .updateSelectedChannel(
                                          //             Get.find<GeneralController>()
                                          //                 .getRandomString(10));
                                          //         Get.find<GeneralController>()
                                          //             .updateChannelForCall(
                                          //             Get.find<GeneralController>()
                                          //                 .selectedChannel);
                                          //         log('----------->>> ${Get.find<GeneralController>().selectedChannel}');
                                          //         getMethod(
                                          //             context,
                                          //             agoraTokenUrl,
                                          //             {
                                          //               'token': '123',
                                          //               'channel': Get.find<GeneralController>()
                                          //                   .selectedChannel
                                          //             },
                                          //             true,
                                          //             getAgoraTokenForAudioRepo);
                                          //         Get.find<GeneralController>()
                                          //             .updateGoForCall(true);
                                          //         Get.toNamed(PageRoutes.videoCallWaiting);
                                          //       },
                                          //       child: const Padding(
                                          //         padding: EdgeInsetsDirectional.fromSTEB(
                                          //             5, 5, 5, 5),
                                          //         child: Icon(
                                          //           Icons.call,
                                          //           color: customThemeColor,
                                          //           size: 25,
                                          //         ),
                                          //       ),
                                          //     )
                                          //   ],
                                          // )
                                          //     :const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Column(
                  children: [
                    AppointmentDetailBox(
                      image: _appointmentDetailLogic
                          .selectedAppointmentData.mentor!.imagePath,
                      name: _appointmentDetailLogic
                                  .selectedAppointmentData.mentor!.firstName ==
                              null
                          ? '...'
                          : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.firstName} '
                              '${_appointmentDetailLogic.selectedAppointmentData.mentor!.lastName}',
                      category:
                          '${_appointmentDetailLogic.selectedAppointmentData.category}',
                      fee:
                          '\$${_appointmentDetailLogic.selectedAppointmentData.payment!} Fees',
                      type:
                          '${_appointmentDetailLogic.selectedAppointmentData.appointmentTypeString}'
                              .capitalizeFirst,
                      typeIcon: Get.find<MyAppointmentLogic>()
                          .imagesForAppointmentTypes[(_appointmentDetailLogic
                              .selectedAppointmentData.appointmentTypeId!) -
                          1],
                      date: _appointmentDetailLogic
                                  .selectedAppointmentData.date ==
                              null
                          ? null
                          : DateFormat('dd/MM/yy').format(DateTime.parse(
                              _appointmentDetailLogic
                                  .selectedAppointmentData.date!)),
                      time: _appointmentDetailLogic
                                  .selectedAppointmentData.time ==
                              null
                          ? null
                          : _appointmentDetailLogic
                              .selectedAppointmentData.time!,
                      rating: _appointmentDetailLogic
                          .selectedAppointmentData.rating!
                          .toDouble(),
                      status: _appointmentDetailLogic.appointmentStatus,
                      color: _appointmentDetailLogic.colorForAppointmentTypes[
                          _appointmentDetailLogic.appointmentStatus!],
                    )
                  ],
                )),
            bottomNavigationBar: GestureDetector(
              onTap: () {
                openBottomSheet();
              },
              onVerticalDragStart: (event) {
                openBottomSheet();
              },
              child: Container(
                height: 74.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 15,
                        // offset: Offset(1,5)
                      )
                    ],
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.r))),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: SvgPicture.asset('assets/Icons/bottomUpArrowIcon.svg'),
                )),
              ),
            ),
          ),
        );
      });
    });
  }

  openBottomSheet() {
    return showCupertinoModalBottomSheet(
        topRadius: Radius.circular(30.r),
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const ModalInsideModal());
  }
}
