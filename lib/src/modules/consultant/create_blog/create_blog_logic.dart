import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:resize/resize.dart';

import '../../../api_services/get_service.dart';
import '../../../api_services/urls.dart';
import 'create_blog_state.dart';
import 'models/blog_categories_model.dart';
import 'repos/get_repo/get_blog_repo.dart';

class CreateBlogLogic extends GetxController {
  final CreateBlogState state = CreateBlogState();

  HtmlEditorController descriptionController = HtmlEditorController();
  TextEditingController titleController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool lastStatus = true;

  double height = 100.h;

  BlogCategoriesModel blogCategoriesModel = BlogCategoriesModel();

  String? selectedCategory;
  int? selectedCategoryId;
  String? description = "";

  updateSelectedCategory(String? value) {
    selectedCategory = value;
    selectedCategoryId = null;
    for (Categories element in (blogCategoriesModel.data?.categories ?? [])) {
      if (value!.contains(element.name!)) {
        selectedCategoryId = element.id;
      }
    }
    log(value.toString());
    log(selectedCategoryId.toString());

    update();
  }

  List<String> categoryDropDownList = [];

  updateCategoryDropDownList(String newValue) {
    categoryDropDownList.add(newValue);
    update();
  }

  emptyCategoryDropDownList() {
    categoryDropDownList = [];
    update();
  }

  bool blogCategoryLoader = false;

  updateBlogCategoryLoader(bool value) {
    blogCategoryLoader = value;
    update();
  }

  bool get isShrink {
    return scrollController.hasClients && scrollController.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();

    scrollController = ScrollController()..addListener(scrollListener);
    // Get.find<BookAppointmentLogic>().selectedPaymentType = null;
    // Get.find<BookAppointmentLogic>().questionController.clear();

    getMethod(Get.context!, blogCategoriesUrl, {'token': 123, 'platform': 'app'}, true, blogCategoriesRepo);
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  String? selectedFileName;
  FilePickerResult? filePickerResult;

  updateSelectedFileName(String? newValue) {
    selectedFileName = newValue;
    update();
  }

  final GlobalKey<FormState> formKey = GlobalKey();
}
