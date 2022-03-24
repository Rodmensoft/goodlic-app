import 'package:consultant_product/src/modules/login/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  LoginModel loginModel = LoginModel();

  late TabController tabController;

  List<Tab> loginRoleTabList = [
    const Tab(text: 'User'),
    const Tab(text: 'Consultant')
  ];

  String? selectedRole = 'Mentee';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailValidator ;
  String? passwordValidator ;
}
