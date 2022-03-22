import 'dart:developer';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user_profile/get_user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

getUserProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<GeneralController>().getUserProfileModel =
        GetUserProfileModel.fromJson(response);

    Get.find<GeneralController>().updateFormLoaderController(false);
    if (Get.find<GeneralController>().getUserProfileModel.status == true) {
      log('getUserProfileRepo ------>> ${Get.find<GeneralController>().getUserProfileModel.success}');
    } else {}
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}


// getUserProfileForEditRepo(
//     BuildContext context, bool responseCheck, Map<String, dynamic> response) {
//   if (responseCheck) {
//     Get.find<GeneralController>().getUserProfileModel =
//         GetUserProfileModel.fromJson(response);
//     if (Get.find<GeneralController>().getUserProfileModel.status == true) {
//       getMethod(context, mentorProfileGenericDataUrl, {'token': '123'}, false,
//           getGenericDataRepo);
//       getMethod(
//           context,
//           getCitiesByIdUrl,
//           {
//             'token': '123',
//             'country_id': Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.country
//           },
//           false,
//           getCitiesRepo);
//       getMethod(context, mentorParentCategoryDataUrl, {'token': '123'}, false,
//           getParentCategoryRepo);
//
//       Get.find<MentorEditProfileLogic>().firstNameController.text = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.firstName!;
//       Get.find<MentorEditProfileLogic>().lastNameController.text = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.lastName!;
//       Get.find<MentorEditProfileLogic>().fatherNameController.text = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.fatherName!;
//       Get.find<MentorEditProfileLogic>().emailController.text = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.email!;
//       Get.find<MentorEditProfileLogic>().cnicController.text = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.cnic!;
//       Get.find<MentorEditProfileLogic>().addressController.text = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.address!;
//       Get.find<MentorEditProfileLogic>().selectedGender = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.gender!;
//       Get.find<MentorEditProfileLogic>().selectedReligion = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.religion!;
//       Get.find<MentorEditProfileLogic>().dobController.text = DateFormat('dd-MM-yyyy')
//           .format(DateTime.parse(Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.dob!));
//       Get.find<MentorEditProfileLogic>().selectedDob = DateTime.parse(Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.dob!);
//       Get.find<MentorEditProfileLogic>().selectedCity = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.city!;
//       Get.find<MentorEditProfileLogic>().forDisplayEducationList = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.educations!;
//       Get.find<MentorEditProfileLogic>().forDisplayExperienceList = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.experiences!;
//       Get.find<MentorEditProfileLogic>().forDisplaySkillList = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.mentor!.category!;
//       // Get.find<MentorEditProfileLogic>().selectedSubCategory = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.mentor!.category!.name!;
//       Get.find<MentorEditProfileLogic>().selectedBank = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.cardDetail!.bank!;
//       Get.find<MentorEditProfileLogic>().accountTitleController.text = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.cardDetail!.accountTitle!;
//       Get.find<MentorEditProfileLogic>().accountNumberController.text = Get.find<GeneralController>().getUserProfileModel.data!.userDetail!.cardDetail!.accountNumber!;
//
//       Get.find<GeneralController>().updateFormLoaderController(false);
//       log('getUserProfileRepo ------>> ${Get.find<GeneralController>().getUserProfileModel.success}');
//     } else {
//       Get.find<GeneralController>().updateFormLoaderController(false);
//     }
//   } else if (!responseCheck) {
//     Get.find<GeneralController>().updateFormLoaderController(false);
//
//     log('Exception........................');
//   }
// }
