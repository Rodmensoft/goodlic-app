import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/modules/login/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  LoginModel loginModel = LoginModel();

  late TabController tabController;

  List<Tab> loginRoleTabList = [
    Tab(text: LanguageConstant.user.tr),
    Tab(text: LanguageConstant.mentor.tr)
  ];

  String? selectedRole = 'Mentee';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailValidator;
  String? passwordValidator;
}
