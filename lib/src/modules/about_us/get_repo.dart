import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/general_controller.dart';
import '../../widgets/custom_dialog.dart';

import 'logic.dart';
import 'model.dart';

aboutUsRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<AboutUsLogic>().aboutUsModel =
        AboutUsModel.fromJson(response);

    Get.find<GeneralController>().updateFormLoaderController(false);


  }
}