import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class SignUpLogic extends GetxController {
  final SignUpState state = SignUpState();

  late TabController tabController;

  List<Tab> signupRoleTabList = [
    const Tab(text: 'User'),
    const Tab(text: 'Consultant')
  ];

  String? selectedRole = 'Mentee';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? emailValidator ;
}
