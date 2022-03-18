import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class EducationalInfoLogic extends GetxController {
  final EducationalInfoState state = EducationalInfoState();

  DateTime? selectedFromDate;
  DateTime? selectedToDate;

  String? selectedGender;
  List<String> genderDropDownList = [];

  updateGenderDropDownList(String newValue) {
    genderDropDownList.add(newValue);
    update();
  }

  emptyGenderDropDownList() {
    genderDropDownList = [];
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