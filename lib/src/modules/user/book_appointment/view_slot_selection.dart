import 'dart:developer';

import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'logic.dart';

class SlotSelection extends StatefulWidget {
  const SlotSelection({Key? key}) : super(key: key);

  @override
  State<SlotSelection> createState() => _SlotSelectionState();
}

class _SlotSelectionState extends State<SlotSelection> {
  final logic = Get.put(BookAppointmentLogic());

  final state = Get.find<BookAppointmentLogic>().state;

  @override
  void initState() {
    super.initState();

    Get.find<BookAppointmentLogic>().scrollController = ScrollController()
      ..addListener(Get.find<BookAppointmentLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<BookAppointmentLogic>()
        .scrollController!
        .removeListener(Get.find<BookAppointmentLogic>().scrollListener);
    Get.find<BookAppointmentLogic>().scrollController!.dispose();
    super.dispose();
  }

  bool? disableButton = true;
  int? selectedSlotID;
  int? selectedSlotIndex;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                controller: _bookAppointmentLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: 'Book Appointment',
                      subHeading: 'By just few easy steps',
                      trailing: 'Step 1 Of 3',
                      isShrink: _bookAppointmentLogic.isShrink,
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    ListView(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0),
                        children: [
                          ///---type-heading
                          Text(
                            'Select Option',
                            style: state.headingTextStyle,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),

                          ///---types
                          Wrap(
                            children: List.generate(
                                _bookAppointmentLogic.consultantProfileLogic
                                    .appointmentTypes.length, (index) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 18.w, 11.h),
                                child: InkWell(
                                  onTap: () {
                                    _bookAppointmentLogic
                                            .selectedAppointmentTypeID =
                                        _bookAppointmentLogic
                                            .consultantProfileLogic
                                            .appointmentTypes[index]
                                            .appointmentTypeId;
                                    _bookAppointmentLogic.update();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: _bookAppointmentLogic
                                                    .selectedAppointmentTypeID ==
                                                _bookAppointmentLogic
                                                    .consultantProfileLogic
                                                    .appointmentTypes[index]
                                                    .appointmentTypeId
                                            ? customLightThemeColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _bookAppointmentLogic
                                                        .selectedAppointmentTypeID ==
                                                    _bookAppointmentLogic
                                                        .consultantProfileLogic
                                                        .appointmentTypes[index]
                                                        .appointmentTypeId
                                                ? customLightThemeColor
                                                    .withOpacity(0.6)
                                                : Colors.grey.withOpacity(0.2),
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
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                '${_bookAppointmentLogic.consultantProfileLogic.imagesForAppointmentTypes[_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[index].appointmentTypeId! - 1]}',
                                                color: _bookAppointmentLogic
                                                            .selectedAppointmentTypeID ==
                                                        _bookAppointmentLogic
                                                            .consultantProfileLogic
                                                            .appointmentTypes[
                                                                index]
                                                            .appointmentTypeId
                                                    ? Colors.white
                                                    : customThemeColor,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                _bookAppointmentLogic
                                                    .consultantProfileLogic
                                                    .appointmentTypes[index]
                                                    .appointmentType!
                                                    .name!
                                                    .toString().capitalizeFirst!,
                                                style: _bookAppointmentLogic
                                                            .selectedAppointmentTypeID ==
                                                        _bookAppointmentLogic
                                                            .consultantProfileLogic
                                                            .appointmentTypes[
                                                                index]
                                                            .appointmentTypeId
                                                    ? state.typeTextStyle!
                                                        .copyWith(
                                                            color: Colors.white)
                                                    : state.typeTextStyle,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 28.w),
                                            child: Text(
                                              '\$${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[index].fee}',
                                              style: _bookAppointmentLogic
                                                          .selectedAppointmentTypeID ==
                                                      _bookAppointmentLogic
                                                          .consultantProfileLogic
                                                          .appointmentTypes[
                                                              index]
                                                          .appointmentTypeId
                                                  ? state.typePriceTextStyle!
                                                      .copyWith(
                                                          color: Colors.white)
                                                  : state.typePriceTextStyle,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          ///---calender
                          Container(
                            height: 300.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: -2,
                                    blurRadius: 15,
                                    // offset: Offset(1,5)
                                  )
                                ]),
                            child: _getCustomizedDatePicker([]),
                          ),

                          SizedBox(
                            height: 30.h,
                          ),

                          ///---shift-heading
                          Text(
                            'Select Shift',
                            style: state.headingTextStyle,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          ///---shift
                          Row(
                            children: List.generate(
                                _bookAppointmentLogic.shiftList.length,
                                (index) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 11.w, 0.h),
                                  child: InkWell(
                                    onTap: () {
                                      _bookAppointmentLogic.shiftList
                                          .forEach((element) {
                                        element.isSelected = false;
                                      });
                                      _bookAppointmentLogic
                                          .shiftList[index].isSelected = true;
                                      _bookAppointmentLogic.update();
                                    },
                                    child: Container(
                                      height: 78.h,
                                      decoration: BoxDecoration(
                                          color: _bookAppointmentLogic
                                                  .shiftList[index].isSelected!
                                              ? customLightThemeColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: _bookAppointmentLogic
                                                      .shiftList[index]
                                                      .isSelected!
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
                                            _bookAppointmentLogic
                                                    .shiftList[index]
                                                    .isSelected!
                                                ? SvgPicture.asset(
                                                    '${_bookAppointmentLogic.shiftList[index].image}',
                                                    color: Colors.white,
                                                    height: 20.h,
                                                    width: 20.w,
                                                  )
                                                : SvgPicture.asset(
                                                    '${_bookAppointmentLogic.shiftList[index].image}',
                                                    height: 20.h,
                                                    width: 20.w,
                                                  ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              '${_bookAppointmentLogic.shiftList[index].title}',
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: _bookAppointmentLogic
                                                      .shiftList[index]
                                                      .isSelected!
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

                          SizedBox(
                            height: 25.h,
                          ),
                          Wrap(
                            children: List.generate(15, (secondIndex) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 12.w, 6),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedSlotIndex = secondIndex;
                                    });
                                    setState(() {
                                      disableButton = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: selectedSlotIndex == secondIndex
                                            ? customLightThemeColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          11.w, 4.h, 11.w, 4.h),
                                      child: Text(
                                        '7:00 pm',
                                        textDirection: TextDirection.ltr,
                                        style: selectedSlotIndex == secondIndex
                                            ? state.shiftTitleTextStyle!
                                                .copyWith(color: Colors.white)
                                            : state.shiftTitleTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                          ),
                        ]),

                    ///---bottom-bar
                    Positioned(
                      bottom: 0.h,
                      left: 15.w,
                      right: 15.w,
                      child: InkWell(
                        onTap: () {
                          if (!disableButton!) {
                            Get.toNamed(PageRoutes.appointmentQuestion);
                          }
                        },
                        child: MyCustomBottomBar(
                          title: 'Continue',
                          disable: disableButton!,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      });
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        Get.find<BookAppointmentLogic>().selectedDateForAppointment =
            args.value.toString();
        setState(() {
          selectedSlotID = null;
        });
        // Get.find<BookAppointmentLogic>()
        //     .updateGetScheduleSlotsForMenteeLoader(true);
        // Get.find<BookAppointmentLogic>().emptyMorningSlots();
        // Get.find<BookAppointmentLogic>().emptyAfterNoonSlots();
        // Get.find<BookAppointmentLogic>().emptyEveningSlots();
        // getMethod(
        //     context,
        //     getScheduleSlotsForMenteeUrl,
        //     {
        //       'token': '123',
        //       'mentor_id': Get.find<GeneralController>().selectedMentor.userId,
        //       'date': Get.find<BookAppointmentLogic>()
        //           .selectedDateForAppointment
        //           .substring(0, 11),
        //       'appointment_type_id':
        //       Get.find<SingleCategoryMentorListPageLogic>()
        //           .selectMentorAppointmentType!
        //           .appointmentTypeId
        //       // 'token': '123',
        //       // 'mentor_id': Get.find<GeneralController>().selectedMentor.userId,
        //       // 'date': '2021-12-07',
        //       // 'appointment_type_id': 1
        //     },
        //     true,
        //     getScheduleSlotsRepo);
        Get.find<BookAppointmentLogic>().update();
        // log('MentorID--->>${Get.find<GeneralController>().selectedMentor.userId}');
        log('SelectedDate--->>${Get.find<BookAppointmentLogic>().selectedDateForAppointment.substring(0, 11)}');
      }
    });
  }

  SfDateRangePicker _getCustomizedDatePicker(List<DateTime> specialDates) {
    return SfDateRangePicker(
      selectionShape: DateRangePickerSelectionShape.rectangle,
      selectionColor: customLightThemeColor,
      selectionTextStyle: TextStyle(
          fontFamily: SarabunFontFamily.regular,
          fontSize: 14.sp,
          color: Colors.white),
      onSelectionChanged: _onSelectionChanged,
      enablePastDates: false,
      showNavigationArrow: true,
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(const Duration(days: 90)),
      backgroundColor: Colors.white,
      headerStyle: DateRangePickerHeaderStyle(
        textStyle: TextStyle(
            fontFamily: SarabunFontFamily.extraBold,
            fontSize: 18.sp,
            color: customTextBlackColor),
      ),
      monthCellStyle: DateRangePickerMonthCellStyle(
        specialDatesDecoration: const MonthCellDecoration(
            borderColor: null,
            backgroundColor: Colors.blueGrey,
            showIndicator: true,
            indicatorColor: customThemeColor),
        // textStyle: TextStyle(color: const Color(0xffe2d7fe), fontSize: 14),
        specialDatesTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: SarabunFontFamily.regular),
        // todayTextStyle: TextStyle(color: highlightColor, fontSize: 14)
      ),
      // yearCellStyle: DateRangePickerYearCellStyle(
      //   todayTextStyle: TextStyle(color: highlightColor, fontSize: 14),
      //   textStyle: TextStyle(color: cellTextColor, fontSize: 14),
      //   disabledDatesTextStyle: TextStyle(color: const Color(0xffe2d7fe)),
      //   leadingDatesTextStyle:
      //       TextStyle(color: cellTextColor.withOpacity(0.5), fontSize: 14),
      // ),
      todayHighlightColor: customLightThemeColor,
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: TextStyle(
                fontFamily: SarabunFontFamily.medium,
                fontSize: 16,
                color: customTextBlackColor)),
        // dayFormat: 'EEE',
        showTrailingAndLeadingDates: false,
        specialDates: specialDates,
      ),
    );
  }
}

class MonthCellDecoration extends Decoration {
  const MonthCellDecoration(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MonthCellDecorationPainter(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        showIndicator: showIndicator,
        indicatorColor: indicatorColor);
  }
}

class _MonthCellDecorationPainter extends BoxPainter {
  _MonthCellDecorationPainter(
      {this.borderColor,
      this.backgroundColor,
      required this.showIndicator,
      this.indicatorColor});

  final Color? borderColor;
  final Color? backgroundColor;
  final bool showIndicator;
  final Color? indicatorColor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    _drawDecoration(canvas, bounds);
  }

  void _drawDecoration(Canvas canvas, Rect bounds) {
    final Paint paint = Paint()..color = backgroundColor!;
    canvas.drawRRect(
        RRect.fromRectAndRadius(bounds, const Radius.circular(10)), paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    if (borderColor != null) {
      paint.color = borderColor!;
      canvas.drawRRect(
          RRect.fromRectAndRadius(bounds, const Radius.circular(10)), paint);
    }
    if (showIndicator) {
      paint.color = indicatorColor!;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(bounds.right - 6, bounds.top + 6), 2.5, paint);
    }
  }
}
