import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../../route_generator.dart';
import '../../../controller/general_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_bottom_bar.dart';
import 'logic.dart';

class ScheduleInfoPage extends StatefulWidget {
  const ScheduleInfoPage({Key? key}) : super(key: key);

  @override
  State<ScheduleInfoPage> createState() => _ScheduleInfoPageState();
}

class _ScheduleInfoPageState extends State<ScheduleInfoPage> {
  final logic = Get.put(ScheduleInfoLogic());

  final state = Get.find<ScheduleInfoLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ScheduleInfoLogic>().scrollController = ScrollController()
      ..addListener(Get.find<ScheduleInfoLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<ScheduleInfoLogic>()
        .scrollController!
        .removeListener(Get.find<ScheduleInfoLogic>().scrollListener);
    Get.find<ScheduleInfoLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ScheduleInfoLogic>(builder: (_scheduleInfoLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: customThemeColor,
            body: NestedScrollView(
              controller: _scheduleInfoLogic.scrollController,
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
                      backgroundColor: _scheduleInfoLogic.isShrink
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
                                                    color: customOrangeColor),
                                                child: Center(
                                                  child: Text('04',
                                                      style: state
                                                          .numberTextStyle!),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                            ],
                                          ),

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
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.h),

                        /// Dropdowns type and Charges
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.w, 0.h, 16.w, 0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///---Type
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        hint: Text('Type',
                                            style: TextStyle(
                                                fontFamily:
                                                    SarabunFontFamily.regular,
                                                fontSize: 16.sp,
                                                color: customTextGreyColor)),
                                        onTap: () {
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 0.0),
                                          fillColor: Colors.white,
                                          filled: true,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: customThemeColor)),
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent)),
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xffDEE8EE))),
                                        ),
                                        focusColor: Colors.white,
                                        isExpanded: true,
                                        style: state.textFieldTextStyle,
                                        iconEnabledColor: customThemeColor,
                                        icon: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 20.w, 0),
                                          child: SvgPicture.asset(
                                              'assets/Icons/dropdownIcon.svg'),
                                        ),
                                        value: _scheduleInfoLogic.selectedType,
                                        items: _scheduleInfoLogic
                                            .typeDropDownList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: state.textFieldTextStyle,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          log(value.toString());
                                          setState(() {
                                            _scheduleInfoLogic.selectedType =
                                                value;
                                          });
                                        },
                                        validator: (String? value) {
                                          if (value == null) {
                                            return 'field_required'.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              ///---Charges
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              25.w, 15.h, 25.w, 15.h),
                                      hintText: 'Charges',
                                      hintStyle: state.hintTextStyle,
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: customLightThemeColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Field is required';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),

                        /// Text
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.w, 0.h, 16.w, 0.h),
                          child: Text(
                            'Select Day',
                            style: state.slotsTitleTextStyle,
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// Days

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.w, 0.h, 16.w, 0.h),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 28,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    _scheduleInfoLogic.dayListForHoliday.length,
                                    (index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _generalController
                                                .updateFormLoaderController(
                                                    true);
                                            setState(() {
                                              _scheduleInfoLogic
                                                      .dayListForHoliday[index]
                                                      .isSelected =
                                                  !_scheduleInfoLogic
                                                      .dayListForHoliday[index]
                                                      .isSelected!;
                                            });

                                            Map<String, dynamic>
                                                tempHolidayMap = {};

                                            _scheduleInfoLogic.dayListForHoliday
                                                .forEach((element) {
                                              setState(() {
                                                tempHolidayMap[
                                                        '${element.slug}'] =
                                                    element.isSelected! ? 1 : 0;
                                              });
                                            });
                                            log('TEMPLIST--->>${tempHolidayMap}');
                                            // postMethod(
                                            //     context,
                                            //     markDayHolidayUrl,
                                            //     {
                                            //       'token': '123',
                                            //       'mentor_id': Get
                                            //           .find<
                                            //           GeneralController>()
                                            //           .storageBox
                                            //           .read(
                                            //           'userId'),
                                            //       'appointment_type_id':
                                            //       _mentorScheduleLogic
                                            //           .selectedScheduleTypeId,
                                            //       'availability':
                                            //       tempHolidayMap
                                            //     },
                                            //     true,
                                            //     markHolidayPostRepo);
                                          },
                                          child: Container(
                                            decoration: _scheduleInfoLogic
                                                    .dayListForHoliday[index]
                                                    .isSelected!
                                                ? BoxDecoration(
                                                    color: customThemeColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                        color:
                                                            customThemeColor))
                                                : BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                        color: Colors.black)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      12, 1, 12, 1),
                                              child: Text(
                                                '${_scheduleInfoLogic.dayListForHoliday[index].title}',
                                                style: _scheduleInfoLogic
                                                        .dayListForHoliday[
                                                            index]
                                                        .isSelected!
                                                    ? state
                                                        .scheduleDayTextStyle!
                                                        .copyWith(
                                                            color: Colors.white)
                                                    : state
                                                        .scheduleDayTextStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              )),
                        ),
                        SizedBox(height: 25.h),

                        /// Shift Time

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.w, 0.h, 16.w, 0.h),
                          child: Row(
                            children: List.generate(
                                _scheduleInfoLogic.shiftList.length, (index) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 11.w, 0.h),
                                  child: InkWell(
                                    onTap: () {
                                      for (var element
                                          in _scheduleInfoLogic.shiftList) {
                                        element.isSelected = false;
                                      }
                                      _scheduleInfoLogic
                                          .shiftList[index].isSelected = true;
                                      _scheduleInfoLogic
                                          .updateAppointmentShiftType(index);
                                      _scheduleInfoLogic.update();
                                    },
                                    child: Container(
                                      height: 78.h,
                                      decoration: BoxDecoration(
                                          color: _scheduleInfoLogic
                                                      .appointmentShiftType ==
                                                  index
                                              ? customLightThemeColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: _scheduleInfoLogic
                                                          .appointmentShiftType ==
                                                      index
                                                  ? customLightThemeColor
                                                      .withOpacity(0.5)
                                                  : Colors.grey
                                                      .withOpacity(0.2),
                                              spreadRadius: -2,
                                              blurRadius: 15,
                                              // offset: Offset(1,5)
                                            )
                                          ]),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w, vertical: 13.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _scheduleInfoLogic
                                                        .appointmentShiftType ==
                                                    index
                                                ? SvgPicture.asset(
                                                    '${_scheduleInfoLogic.shiftList[index].image}',
                                                    color: Colors.white,
                                                    height: 20.h,
                                                    width: 20.w,
                                                  )
                                                : SvgPicture.asset(
                                                    '${_scheduleInfoLogic.shiftList[index].image}',
                                                    height: 20.h,
                                                    width: 20.w,
                                                  ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              '${_scheduleInfoLogic.shiftList[index].title}',
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: _scheduleInfoLogic
                                                          .appointmentShiftType ==
                                                      index
                                                  ? state.typeTextStyle!
                                                      .copyWith(
                                                          color: Colors.white)
                                                  : state.typeTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 22.h),

                        Container(
                          height: 300.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.r),
                                topLeft: Radius.circular(30.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.w, 0.0, 20.w, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25.h),

                                /// Text

                                Text(
                                  'Generates Slots Automatically',
                                  style: state.slotsTitleTextStyle,
                                ),
                                SizedBox(height: 20.h),

                                /// Slots
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    left: 15.w,
                    right: 15.w,
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(PageRoutes.profileCreatedScreen);
                        },
                        child: const MyCustomBottomBar(
                            title: 'Save & Continue', disable: false)),
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
