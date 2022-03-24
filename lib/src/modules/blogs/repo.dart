import 'dart:developer';

import 'package:consultant_product/src/modules/blogs/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

blogRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BlogsLogic>().getAllBlogModel = GetAllBlogModel.fromJson(response);

    Get.find<BlogsLogic>().updateBlogLoader(true);

    if (Get.find<BlogsLogic>().getAllBlogModel.status == true) {
      log('blogRepo ------>> ${Get.find<BlogsLogic>().getAllBlogModel.success}');
    } else {}
  } else if (!responseCheck) {
    Get.find<BlogsLogic>().updateBlogLoader(true);

    log('Exception........................');
  }
}
