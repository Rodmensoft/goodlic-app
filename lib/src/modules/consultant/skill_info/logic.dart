import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/scroll_controller.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class SkillInfoLogic extends GetxController {
  final SkillInfoState state = SkillInfoState();

  String? selectedDepartment;
  List<String> departmentDropDownList = [];

  updateDepartmentDropDownList(String newValue) {
    departmentDropDownList.add(newValue);
    update();
  }

  emptyDepartmentDropDownList() {
    departmentDropDownList = [];
    update();
  }

  ///

  String? selectedCategory;
  List<String> categoryDropDownList = [];

  updateCategoryDropDownList(String newValue) {
    categoryDropDownList.add(newValue);
    update();
  }

  emptyCategoryDropDownList() {
    categoryDropDownList = [];
    update();
  }

  ScrollController? scrollController;
  bool lastStatus = true;
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
}
