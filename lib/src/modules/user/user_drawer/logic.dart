import 'package:get/get.dart';

import 'state.dart';

class UserDrawerLogic extends GetxController {
  final UserDrawerState state = UserDrawerState();

  List<DrawerTile> drawerList = [
    DrawerTile(title: 'Home', icon: 'assets/Icons/drawerHomeIcon.svg'),
    DrawerTile(
        title: 'Categories', icon: 'assets/Icons/drawerCategoryIcon.svg'),
    DrawerTile(
        title: 'Appointments Log',
        icon: 'assets/Icons/drawerAppointmentIcon.svg'),
    DrawerTile(title: 'My Wallet', icon: 'assets/Icons/feeIcon.svg'),
    DrawerTile(
        title: 'Contact US', icon: 'assets/Icons/drawerContactUsIcon.svg'),
    DrawerTile(title: 'Blogs', icon: 'assets/Icons/drawerBlogIcon.svg'),
    DrawerTile(
        title: 'Privacy Policy', icon: 'assets/Icons/drawerPrivacyIcon.svg'),
  ];
}

class DrawerTile {
  DrawerTile({required this.title, required this.icon});

  final String? title;
  final String? icon;
}
