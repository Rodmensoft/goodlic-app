import 'package:consultant_product/src/modules/user/appointment_detail/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ModalInsideModal extends StatelessWidget {
  const ModalInsideModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<AppointmentDetailLogic>().state;
    return GetBuilder<AppointmentDetailLogic>(
        builder: (_appointmentDetailLogic) {
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Date',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yy').format(
                                                DateTime.parse(
                                                    _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .date!)),
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---time
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Time',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                .selectedAppointmentData.time!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
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
                                            _appointmentDetailLogic
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
                                            _appointmentDetailLogic
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
                                    _appointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .file ==
                                                null ||
                                            _appointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .file ==
                                                ''
                                        ? const SizedBox()
                                        : Expanded(
                                            flex: 2,
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
                                                  _appointmentDetailLogic
                                                      .selectedAppointmentData
                                                      .fileType!,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        ///---consultant-info
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
                                  'Consultant Info',
                                  style: state.sectionHeadingTextStyle,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                ///---name-gender-status.
                                Row(
                                  children: [
                                    ///---name
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Name',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor!
                                                        .firstName ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.firstName!} '
                                                    '${_appointmentDetailLogic.selectedAppointmentData.mentor!.lastName!}',
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
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor!
                                                        .gender ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.gender!}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---religion
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Religion',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor!
                                                        .religion ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.religion!}',
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

                                ///---phone-city-cnic
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ///---phone
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Phone',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor!
                                                        .phone ==
                                                    null
                                                ? '...'
                                                : _appointmentDetailLogic
                                                    .selectedAppointmentData
                                                    .mentor!
                                                    .phone!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

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
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor!
                                                        .city ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.city!}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---cnic
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'CNIC',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor!
                                                        .cnic ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.cnic!}',
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

                                ///---reg.date-address
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ///---reg.date
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Reg. Date',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yy').format(
                                                DateTime.parse(
                                                    '${_appointmentDetailLogic.selectedAppointmentData.mentor!.createdAt}')),
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.sectionDataTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---address
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Address',
                                            style: state.sectionLabelTextStyle,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            _appointmentDetailLogic
                                                        .selectedAppointmentData
                                                        .mentor!
                                                        .address ==
                                                    null
                                                ? '...'
                                                : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.address!}',
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        ///---reschedule-button
                        Center(
                          child: Container(
                            height: 55.h,
                            width: MediaQuery.of(context).size.width * .7,
                            decoration: BoxDecoration(
                              color: customThemeColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Reschedule',
                                      style: TextStyle(
                                          fontFamily: SarabunFontFamily.bold,
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
                        SizedBox(
                          height: 15.h,
                        ),

                        ///---refund-button
                        Center(
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  40.w, 0, 40.w, 0),
                              child: Container(
                                height: 55.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: customRedColor),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Get Refund',
                                          style: TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.bold,
                                              fontSize: 16.sp,
                                              color: customRedColor),
                                        ),
                                        SvgPicture.asset(
                                          'assets/Icons/forwardArrowRedIcon.svg',
                                          height: 29.h,
                                          width: 29.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
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
