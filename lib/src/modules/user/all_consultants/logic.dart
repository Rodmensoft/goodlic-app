import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'state.dart';

class AllConsultantsLogic extends GetxController {
  final AllConsultantsState state = AllConsultantsState();

  late TabController tabController;

  /// consulatants rating style///

  List<RatingStyling> consultantsRating = [
    RatingStyling(
      title: 'Amanda Smith',
      subTitle: 'Financial Advisor',
      image: 'assets/images/consultant1.png',
    ),
    RatingStyling(
      title: 'John Doe',
      subTitle: 'Financial Advisor',
      image: 'assets/images/consultant2.png',
    ),
    RatingStyling(
      title: 'William Smith',
      subTitle: 'Financial Advisor',
      image: 'assets/images/consultant1.png',
    ),
    RatingStyling(
      title: 'John Doe',
      subTitle: 'Financial Advisor',
      image: 'assets/images/consultant2.png',
    ),
    RatingStyling(
      title: 'John Smith',
      subTitle: 'Financial Advisor',
      image: 'assets/images/consultant1.png',
    ),
    RatingStyling(
      title: 'John Doe',
      subTitle: 'Financial Advisor',
      image: 'assets/images/consultant2.png',
    ),
  ];

  List<Tab> tabBarList = const [
    Tab(text: "Medical"),
    Tab(text: "Cultural"),
    Tab(text: "Financial"),
    Tab(text: "Educational"),
    Tab(text: "Agricultural"),
  ];

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
}

class RatingStyling {
  RatingStyling({this.title, this.subTitle, this.image});

  String? title;
  String? subTitle;
  String? image;
}
