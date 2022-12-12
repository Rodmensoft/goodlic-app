import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../create_blog_logic.dart';
import '../../models/blog_categories_model.dart';

blogCategoriesRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    print(response);
    Get.find<CreateBlogLogic>().blogCategoriesModel = BlogCategoriesModel.fromJson(response);
    //
    Get.find<CreateBlogLogic>().updateBlogCategoryLoader(true);

    ///---category
    Get.find<CreateBlogLogic>().emptyCategoryDropDownList();
    for (var element in (Get.find<CreateBlogLogic>().blogCategoriesModel.data?.categories ?? [])) {
      Get.find<CreateBlogLogic>().updateCategoryDropDownList(element.name);
    }
  }
}
