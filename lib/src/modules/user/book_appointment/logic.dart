import 'package:consultant_product/src/modules/user/book_appointment/model/book_appointment.dart';
import 'package:consultant_product/src/modules/user/book_appointment/model/get_date_schedule.dart';
import 'package:consultant_product/src/modules/user/book_appointment/model/get_schedule_available_days.dart';
import 'package:consultant_product/src/modules/user/consultant_profile/logic.dart';
import 'package:consultant_product/src/modules/user/consultant_profile/model_consultant_profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'state.dart';

class BookAppointmentLogic extends GetxController {
  final BookAppointmentState state = BookAppointmentState();
  final consultantProfileLogic = Get.find<ConsultantProfileLogic>();


  var cardNumberMask = MaskTextInputFormatter(mask: '#### #### #### ####');
  var cardExpiryMask = MaskTextInputFormatter(mask: '##/##');

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  ScrollController? scrollController2;
  ScrollController? scrollController3;
  bool lastStatus2 = true;
  bool lastStatus = true;
  bool lastStatus3 = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
  bool get isShrink2 {
    return scrollController2!.hasClients &&
        scrollController2!.offset > (height - kToolbarHeight);
  }

  void scrollListener2() {
    if (isShrink2 != lastStatus2) {
      lastStatus2 = isShrink2;
      update();
    }
  }
  bool get isShrink3 {
    return scrollController3!.hasClients &&
        scrollController3!.offset > (height - kToolbarHeight);
  }

  void scrollListener3() {
    if (isShrink3 != lastStatus3) {
      lastStatus3 = isShrink3;
      update();
    }
  }

  ///----app-bar-settings-----end

  int? selectedAppointmentTypeID;
  int? selectedAppointmentTypeIndex;

  GetScheduleAvailableDays getScheduleAvailableDays = GetScheduleAvailableDays();
  List<DateTime>? availableScheduleDaysList = <DateTime>[];

  bool? calenderLoader = false;

  updateCalenderLoader(bool? newValue) {
    calenderLoader = newValue;
    update();
  }

  GetScheduleSlotsForUserModel getScheduleSlotsForUserModel = GetScheduleSlotsForUserModel();
  String selectedDateForAppointment = '';
  String selectedTimeForAppointment = '';
  Schedule_slots selectedScheduleSlots = Schedule_slots();

  bool? getScheduleSlotsForMenteeLoader = false;
  updateGetScheduleSlotsForMenteeLoader(bool? newValue) {
    getScheduleSlotsForMenteeLoader = newValue;
    update();
  }

  int? appointmentShiftType = 0;

  updateAppointmentShiftType(int? newValue) {
    appointmentShiftType = newValue;
    update();
  }
  List<Schedule_slots> morningSlots = [];
  updateMorningSlots(Schedule_slots newValue) {
    morningSlots.add(newValue);
    update();
  }
  emptyMorningSlots() {
    morningSlots = [];
    update();
  }

  List<Schedule_slots> afterNoonSlots = [];
  updateAfterNoonSlots(Schedule_slots newValue) {
    afterNoonSlots.add(newValue);
    update();
  }
  emptyAfterNoonSlots() {
    afterNoonSlots = [];
    update();
  }

  List<Schedule_slots> eveningSlots = [];
  updateEveningSlots(Schedule_slots newValue) {
    eveningSlots.add(newValue);
    update();
  }
  emptyEveningSlots() {
    eveningSlots = [];
    update();
  }
  List<ShiftType> shiftList = [
    ShiftType(
        title: 'Morning',
        image: 'assets/Icons/morningShiftIcon.svg',
        isSelected: true),
    ShiftType(
        title: 'Afternoon',
        image: 'assets/Icons/afterNoonShiftIcon.svg',
        isSelected: false),
    ShiftType(
        title: 'Evening',
        image: 'assets/Icons/nightShiftIcon.svg',
        isSelected: false),
  ];

  List<ShiftType> paymentMethodList = [
    ShiftType(
        image: 'assets/Icons/jazzcashIcon.png',
        isSelected: false),
    ShiftType(
        image: 'assets/Icons/easyPaisaIcon.png',
        isSelected: false),
    ShiftType(
        image: 'assets/Icons/visaCardIcon.png',
        isSelected: false),
    ShiftType(
        image: 'assets/Icons/UBLIcon.png',
        isSelected: false),
    ShiftType(
        image: 'assets/Icons/konnectIcon.png',
        isSelected: false),
    ShiftType(
        image: 'assets/Icons/jazzcashIcon.png',
        isSelected: false),
  ];



  String? selectedFileName;
  FilePickerResult? filePickerResult;

  updateSelectedFileName(String? newValue) {
    selectedFileName = newValue;
    update();
  }

  BookAppointmentModel bookAppointmentModel = BookAppointmentModel();
  TextEditingController questionController = TextEditingController();


  ScheduleTypes? selectMentorAppointmentType;
  updateSelectMentorAppointmentType(ScheduleTypes? newValue){
    selectMentorAppointmentType = newValue;
    update();
  }
}

class ShiftType {
  ShiftType({this.title, this.image, this.isSelected});

   String? title;
   String? image;
   bool? isSelected;
}
