import 'package:consultant_product/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class UserDrawerLogic extends GetxController {
  final UserDrawerState state = UserDrawerState();

  List<DrawerTile> drawerLoginList = [
    DrawerTile(title: 'Home', icon: 'assets/Icons/drawerHomeIcon.svg'),
    DrawerTile(
        title: 'Categories', icon: 'assets/Icons/drawerCategoryIcon.svg'),
    DrawerTile(
        title: 'Appointments Log',
        icon: 'assets/Icons/drawerAppointmentIcon.svg'),
    DrawerTile(title: 'Edit Profile', icon: 'assets/Icons/feeIcon.svg'),
    DrawerTile(title: 'My Wallet', icon: 'assets/Icons/feeIcon.svg'),
    DrawerTile(
        title: 'Contact US', icon: 'assets/Icons/drawerContactUsIcon.svg'),
    DrawerTile(title: 'Blogs', icon: 'assets/Icons/drawerBlogIcon.svg'),
    DrawerTile(
        title: 'Privacy Policy', icon: 'assets/Icons/drawerPrivacyIcon.svg'),
  ];
  List<DrawerTile> drawerList = [
    DrawerTile(title: 'Home', icon: 'assets/Icons/drawerHomeIcon.svg'),
    DrawerTile(
        title: 'Categories', icon: 'assets/Icons/drawerCategoryIcon.svg'),
    DrawerTile(
        title: 'Contact US', icon: 'assets/Icons/drawerContactUsIcon.svg'),
    DrawerTile(title: 'Blogs', icon: 'assets/Icons/drawerBlogIcon.svg'),
    DrawerTile(
        title: 'Privacy Policy', icon: 'assets/Icons/drawerPrivacyIcon.svg'),
  ];

  userLoginDrawerNavigation(
    int? index,
    BuildContext context,
  ) {
    switch (index) {
      case 0:
        {
          Get.back();
          return Get.offAllNamed(PageRoutes.userHome);
        }
      case 1:
        {
          Get.back();
          return Get.toNamed(PageRoutes.allConsultants);
        }
      case 2:
        {
          Get.back();
          return Get.toNamed(PageRoutes.myAppointment);
        }
      case 3:
        {
          Get.back();
          return Get.toNamed(PageRoutes.editUserProfile);
        }
      case 4:
        {
          Get.back();
          return Get.toNamed(PageRoutes.walletScreen);
        }
      case 5:
        {
          Get.back();
          return null;
        }
      case 6:
        {
          Get.back();
          return Get.toNamed(PageRoutes.blogs);
        }
      case 7:
        {
          Get.back();
          return null;
        }
      default:
        {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          );
        }
    }
  }

  userDrawerNavigation(
    int? index,
    BuildContext context,
  ) {
    switch (index) {
      case 0:
        {
          Get.back();
          return Get.offAllNamed(PageRoutes.userHome);
        }
      case 1:
        {
          Get.back();
          return Get.toNamed(PageRoutes.allConsultants);
        }
      case 2:
        {
          Get.back();
          return null;
        }
      case 3:
        {
          Get.back();
          return Get.toNamed(PageRoutes.blogs);
        }
      case 4:
        {
          Get.back();
          return null;
        }
      default:
        {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          );
        }
    }
  }
}

class DrawerTile {
  DrawerTile({required this.title, required this.icon});

  final String? title;
  final String? icon;
}
