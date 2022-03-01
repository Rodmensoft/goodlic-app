import 'package:consultant_product/src/modules/user/consultant_profile/model_consultant_profile.dart';
import 'package:get/get.dart';

import 'state.dart';

class ConsultantProfileLogic extends GetxController {
  final ConsultantProfileState state = ConsultantProfileState();

  ConsultantProfileModel consultantProfileModel = ConsultantProfileModel();
  bool? consultantProfileLoader = true;

  updateConsultantProfileLoader(bool? newValue) {
    consultantProfileLoader = newValue;
    update();
  }

  List<ScheduleTypes> appointmentTypes = [];
  List imagesForAppointmentTypes = [
    ///---audio
    'assets/Icons/videoCallIcon.svg',

    ///---video
    'assets/Icons/videoCallIcon.svg',

    ///---chat
    'assets/Icons/chatIcon.svg',

    ///---on-site
    'assets/Icons/physicalIcon.svg',

    ///---home-visit
    'assets/Icons/physicalIcon.svg',
  ];
}


