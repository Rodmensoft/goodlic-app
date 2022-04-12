import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/modules/user/user_drawer/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class ConsultantDrawerLogic extends GetxController {
  final ConsultantDrawerState state = ConsultantDrawerState();


  List<DrawerTile> drawerList = [
    DrawerTile(title: 'Home', icon: 'assets/Icons/drawerHomeIcon.svg'),
    DrawerTile(
        title: 'Appointments Log',
        icon: 'assets/Icons/drawerAppointmentIcon.svg'),
    DrawerTile(title: 'Edit Profile', icon: 'assets/Icons/feeIcon.svg'),
    DrawerTile(title: 'My Schedule', icon: 'assets/Icons/feeIcon.svg'),
    DrawerTile(title: 'My Wallet', icon: 'assets/Icons/feeIcon.svg'),
    DrawerTile(
        title: 'Contact US', icon: 'assets/Icons/drawerContactUsIcon.svg'),
    DrawerTile(title: 'Blogs', icon: 'assets/Icons/drawerBlogIcon.svg'),
    DrawerTile(
        title: 'About Us', icon: 'assets/Icons/drawerPrivacyIcon.svg'),
  ];


  consultantDrawerNavigation(
      int? index,
      BuildContext context,
      ) {
    switch (index) {
      case 0:
        {
          Get.back();
          return Get.offAllNamed(PageRoutes.consultantDashboard);
        }
      case 1:
        {
          Get.back();
          return Get.toNamed(PageRoutes.consultantAllAppointment);
        }
      case 2:
        {
          Get.back();
          return Get.toNamed(PageRoutes.editConsultantProfile);
        }
      case 3:
        {
          Get.back();
          return Get.toNamed(PageRoutes.scheduleCreate);
        }
      case 4:
        {
          Get.back();
          return Get.toNamed(PageRoutes.walletScreen);
        }
      case 5:
        {
          Get.back();
          return Get.toNamed(PageRoutes.contactUs);
        }
      case 6:
        {
          Get.back();
          return Get.toNamed(PageRoutes.blogs);
        }
      case 7:
        {
          Get.back();
          return Get.toNamed(PageRoutes.aboutUs);
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
