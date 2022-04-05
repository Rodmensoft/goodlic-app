import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment_detail/repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

import '../logic.dart';

class ModalInsideModalForConsultant extends StatelessWidget {
  const ModalInsideModalForConsultant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ConsultantAppointmentDetailLogic>().state;
    return GetBuilder<ConsultantAppointmentDetailLogic>(
        builder: (_consultantAppointmentDetailLogic) {
      return Material(
        child: Container(
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: customTextFieldColor,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30.r))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
              child: Column(
                children: [
                  Center(
                      child: SvgPicture.asset(
                          'assets/Icons/bottomDownArrowIcon.svg')),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        ///---appointment-info
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Appointment Info',
                                  style: state.sectionHeadingTextStyle,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                ///---date-time-reg.
                                Row(
                                  children: [
                                    ///---date
                                    _consultantAppointmentDetailLogic
                                                .selectedAppointmentData.date ==
                                            null
                                        ? const SizedBox()
                                        : Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Date',
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  DateFormat('dd/MM/yy').format(
                                                      DateTime.parse(
                                                          _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .date!)),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),

                                    ///---time
                                    _consultantAppointmentDetailLogic
                                                .selectedAppointmentData.time ==
                                            null
                                        ? const SizedBox()
                                        : Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Time',
                                                  style: state
                                                      .sectionLabelTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  _consultantAppointmentDetailLogic
                                                      .selectedAppointmentData
                                                      .time!,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: state
                                                      .sectionDataTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),

                                    ///---reg. no
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Reg No.',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                .selectedAppointmentData.id
                                                .toString(),
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),

                                ///---type-doc.
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ///---type
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Appointment Type',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                .selectedAppointmentData
                                                .appointmentTypeString!
                                                .capitalizeFirst!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---document
                                    _consultantAppointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .file ==
                                                null ||
                                            _consultantAppointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .file ==
                                                ''
                                        ? const SizedBox()
                                        : Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                launch(
                                                    _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .file!.contains('assets')?
                                                    '$mediaUrl/${_consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .file}'
                                                        :'${_consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .file}');
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Document',
                                                    style: state
                                                        .sectionLabelTextStyle,
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                    _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .fileType!,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: state
                                                        .sectionDataTextStyle!.copyWith(color: customLightThemeColor,decoration: TextDecoration.underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),

                                ///---question.
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ///---question
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Question ',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                .selectedAppointmentData
                                                .questions!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
]
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        ///---user-info
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User Info',
                                  style: state.sectionHeadingTextStyle,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                ///---name-gender-status.
                                Row(
                                  children: [
                                    ///---first-name
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'First Name',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentee!
                                                        .firstName ==
                                                    null
                                                ? '...'
                                                : _consultantAppointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .mentee!
                                                    .firstName!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---last-name
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Last Name',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentee!
                                                        .lastName ==
                                                    null
                                                ? '...'
                                                : _consultantAppointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .mentee!
                                                    .lastName!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---gender
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Gender',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentee!
                                                        .gender ==
                                                    null
                                                ? '...'
                                                : '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.gender!}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),

                                ///---city-cnic
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ///---city
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'City',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentee!
                                                        .city ==
                                                    null
                                                ? '...'
                                                : '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.city!}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---country
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Country',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _consultantAppointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentee!
                                                        .userCountry ==
                                                    null
                                                ? '...'
                                                : _consultantAppointmentDetailLogic.selectedAppointmentData.mentee!
                                                .userCountry!.name!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        _consultantAppointmentDetailLogic
                                    .selectedAppointmentData
                                    .appointmentStatus ==
                                0
                            ? Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 30, 0, 10),
                                child: Row(
                                  children: [
                                    ///---action
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    ///---make-notification
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateNotificationBody(
                                                            'Your Appointment is Accepted',
                                                            '',
                                                            null,
                                                            'mentee/appointment/log',
                                                            null);
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateUserIdForSendNotification(
                                                            _consultantAppointmentDetailLogic
                                                                .selectedAppointmentData
                                                                .menteeId);
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateFormLoaderController(
                                                            true);
                                                    Get.find<
                                                        ConsultantAppointmentLogic>().updateGetUserAppointmentLoader(true);
                                                    Get.back();
                                                    Get.back();
                                                    postMethod(
                                                        context,
                                                        mentorChangeAppointmentStatusUrl,
                                                        {
                                                          'token': '123',
                                                          'id': _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .id,
                                                          'status': 1
                                                        },
                                                        true,
                                                        mentorAcceptAppointmentRepo);
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    decoration: BoxDecoration(
                                                        color: customThemeColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 5, 10, 5),
                                                      child: Center(
                                                        child: Text(
                                                          'accept'.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .bold,
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    ///---make-notification
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateNotificationBody(
                                                            'Your Appointment is Cancelled',
                                                            '',
                                                            null,
                                                            'mentee/appointment/log',
                                                            null);
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateUserIdForSendNotification(
                                                            _consultantAppointmentDetailLogic
                                                                .selectedAppointmentData
                                                                .menteeId);
                                                    Get.find<
                                                            GeneralController>()
                                                        .updateFormLoaderController(
                                                            true);
                                                    Get.find<
                                                        ConsultantAppointmentLogic>().updateGetUserAppointmentLoader(true);
                                                    Get.back();
                                                    Get.back();
                                                    postMethod(
                                                        context,
                                                        mentorChangeAppointmentStatusUrl,
                                                        {
                                                          'token': '123',
                                                          'id': _consultantAppointmentDetailLogic
                                                              .selectedAppointmentData
                                                              .id,
                                                          'status': 3
                                                        },
                                                        true,
                                                        mentorRejectAppointmentRepo);
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 5, 10, 5),
                                                      child: Center(
                                                        child: Text(
                                                          'reject'.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .bold,
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),

                        _consultantAppointmentDetailLogic
                                    .selectedAppointmentData
                                    .appointmentStatus ==
                                1
                            ? Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 30, 0, 10),
                                child: InkWell(
                                  onTap: () {
                                    ///---make-notification
                                    Get.find<GeneralController>()
                                        .updateNotificationBody(
                                            'Your Appointment is Completed',
                                            '',
                                            null,
                                            'mentee/appointment/log',
                                            null);
                                    Get.find<GeneralController>()
                                        .updateUserIdForSendNotification(
                                            _consultantAppointmentDetailLogic
                                                .selectedAppointmentData
                                                .menteeId);
                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    Get.find<
                                        ConsultantAppointmentLogic>().updateGetUserAppointmentLoader(true);
                                    Get.back();
                                    Get.back();
                                    postMethod(
                                        context,
                                        mentorChangeAppointmentStatusUrl,
                                        {
                                          'token': '123',
                                          'id':
                                              _consultantAppointmentDetailLogic
                                                  .selectedAppointmentData.id,
                                          'status': 2
                                        },
                                        true,
                                        mentorCompleteAppointmentRepo);
                                  },
                                  child: Container(
                                    height: 55.h,
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    decoration: BoxDecoration(
                                      color: customThemeColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'mark_as_complete'.tr,
                                              style: TextStyle(
                                                  fontFamily:
                                                      SarabunFontFamily.bold,
                                                  fontSize: 16.sp,
                                                  color: Colors.white),
                                            ),
                                            SvgPicture.asset(
                                              'assets/Icons/whiteForwardIcon.svg',
                                              height: 29.h,
                                              width: 29.w,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
