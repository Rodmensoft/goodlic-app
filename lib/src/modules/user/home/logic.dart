import 'package:consultant_product/src/modules/user/home/model_get_categories.dart';
import 'package:consultant_product/src/modules/user/home/model_user_profile.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class UserHomeLogic extends GetxController {
  final UserHomeState state = UserHomeState();

  GetUserProfileModel getUserProfileModel = GetUserProfileModel();



  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 200.h;

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

  ///-------

  GetCategoriesModel getCategoriesModel = GetCategoriesModel();
  bool? categoriesLoader = true;
  updateCategoriesLoader(bool? newValue){
    categoriesLoader = newValue;
    update();
  }


  List<HomeStyling> categoriesList = [];

  ///-------
  List<HomeStyling> topRatedConsultantList = [
    HomeStyling(
      title: 'Amanda Smith',
      subTitle: 'Financial Advisor',
      image: 'assets/images/dummyTopRatedConsultant.png',
      color: customLightThemeColor
    ),
    HomeStyling(
      title: 'John Doe',
        subTitle: 'Property Consultant',
        image: 'assets/images/dummyTopRatedConsultant.png',
      color: customOrangeColor
    ),
    HomeStyling(
        title: 'Amanda Smith',
        subTitle: 'Financial Advisor',
        image: 'assets/images/dummyTopRatedConsultant.png',
        color: customLightThemeColor
    ),
    HomeStyling(
        title: 'John Doe',
        subTitle: 'Property Consultant',
        image: 'assets/images/dummyTopRatedConsultant.png',
        color: customOrangeColor
    ),
    HomeStyling(
        title: 'Amanda Smith',
        subTitle: 'Financial Advisor',
        image: 'assets/images/dummyTopRatedConsultant.png',
        color: customLightThemeColor
    ),
    HomeStyling(
        title: 'John Doe',
        subTitle: 'Property Consultant',
        image: 'assets/images/dummyTopRatedConsultant.png',
        color: customOrangeColor
    ),
    HomeStyling(
        title: 'Amanda Smith',
        subTitle: 'Financial Advisor',
        image: 'assets/images/dummyTopRatedConsultant.png',
        color: customLightThemeColor
    ),
    HomeStyling(
        title: 'John Doe',
        subTitle: 'Property Consultant',
        image: 'assets/images/dummyTopRatedConsultant.png',
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
