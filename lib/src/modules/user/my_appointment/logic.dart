import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class MyAppointmentLogic extends GetxController {
  final MyAppointmentState state = MyAppointmentState();

  late TabController tabController;

  ///----app-bar-settings-----start
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

  List<Tab> tabBarList = const [
    Tab( text: "Pending",),
    Tab( text: "Completed"),
    Tab( text: "Cancelled"),
  ];
}
