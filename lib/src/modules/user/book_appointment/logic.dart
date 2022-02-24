import 'package:consultant_product/src/modules/user/consultant_profile/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'state.dart';

class BookAppointmentLogic extends GetxController {
  final BookAppointmentState state = BookAppointmentState();


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

  List<AppointmentTypesCustomClass> appointmentTypes = [
    AppointmentTypesCustomClass(
        title: 'Video Appointment',
        image: 'assets/Icons/videoCallIcon.svg',
        fee: '\$25',
        isSelected: false),
    AppointmentTypesCustomClass(
        title: 'Online Chat',
        image: 'assets/Icons/chatIcon.svg',
        fee: '\$15',
        isSelected: false),
    AppointmentTypesCustomClass(
        title: 'Physical Appointment',
        image: 'assets/Icons/physicalIcon.svg',
        fee: '\$53',
        isSelected: false),
  ];

  List<ShiftType> shiftList = [
    ShiftType(
        title: 'Morning',
        image: 'assets/Icons/morningShiftIcon.svg',
        isSelected: false),
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

  ///---calender-settings

  String selectedDateForAppointment = '';
  String selectedTimeForAppointment = '';
// Schedule_slots selectedScheduleSlots = Schedule_slots();


  ///---slots

}

class ShiftType {
  ShiftType({this.title, this.image, this.isSelected});

   String? title;
   String? image;
   bool? isSelected;
}
