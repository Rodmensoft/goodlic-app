import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/general_controller.dart';

postBlogRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<GeneralController>().updateFormLoaderController(false);
  if (responseCheck) {
    print(response);
    // {"Status":true,"success":1,"msg":"Successfully added Blog"}
  }
}
