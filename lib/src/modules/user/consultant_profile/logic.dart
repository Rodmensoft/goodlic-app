import 'package:get/get.dart';

import 'state.dart';

class ConsultantProfileLogic extends GetxController {
  final ConsultantProfileState state = ConsultantProfileState();

  List<AppointmentTypesCustomClass> appointmentTypes = [
    AppointmentTypesCustomClass(
      title: 'Video Appointment',
      image: 'assets/Icons/videoCallIcon.svg'
    ),
    AppointmentTypesCustomClass(
      title: 'Online Chat',
      image: 'assets/Icons/chatIcon.svg'
    ),
    AppointmentTypesCustomClass(
      title: 'Physical Appointment',
      image: 'assets/Icons/physicalIcon.svg'
    ),
  ];
}
class AppointmentTypesCustomClass {
  AppointmentTypesCustomClass({this.title, this.image,this.fee,this.isSelected});

  String? title;
  String? image;
  String? fee;
  bool? isSelected;
}