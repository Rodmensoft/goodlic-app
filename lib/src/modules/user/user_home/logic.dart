import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class UserHomeLogic extends GetxController {
  final UserHomeState state = UserHomeState();

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 800.h;

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

  ///----app-bar-settings-----end

  List<HomeStyling> topConsultants = [
    HomeStyling(
      title: 'John Doe',
      subTitle: 'Financial Advisor',
      image: 'assets/images/stackImage.png',
      color: customLightThemeColor
    ),
    HomeStyling(
      title: 'John Doe',
      subTitle: 'Financial Advisor',
      image: 'assets/images/stackImage.png',
      color: customOrangeColor
    ),
    HomeStyling(
      title: 'John Doe',
      subTitle: 'Financial Advisor',
      image: 'assets/images/stackImage.png',
      color: customLightThemeColor
    ),
    HomeStyling(
      title: 'John Doe',
      subTitle: 'Financial Advisor',
      image: 'assets/images/stackImage.png',
      color: customOrangeColor
    ),
  ];
}

class HomeStyling {
  HomeStyling({this.title, this.subTitle, this.image, this.color});

  String? title;
  String? subTitle;
  String? image;
  Color? color;
}
