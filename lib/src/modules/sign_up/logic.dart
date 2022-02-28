import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'state.dart';

class SignUpLogic extends GetxController {
  final SignUpState state = SignUpState();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? emailValidator ;
}
