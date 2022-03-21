import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class GeneralInfoLogic extends GetxController {
  final GeneralInfoState state = GeneralInfoState();

  DateTime? selectedDob;

  String? selectedDegree;
  List<String> degreeDropDownList = [];

  updateDegreeDropDownList(String newValue) {
    degreeDropDownList.add(newValue);
    update();
  }

  emptyDegreeDropDownList() {
    degreeDropDownList = [];
    update();
  }

  ///

  String? selectedOccupation;
  List<String> occupationDropDownList = [];

  updateOccupationDropDownList(String newValue) {
    occupationDropDownList.add(newValue);
    update();
  }

  emptyOccupationDropDownList() {
    occupationDropDownList = [];
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
