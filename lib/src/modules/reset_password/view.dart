import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class Reset_PasswordPage extends StatelessWidget {
  final logic = Get.put(Reset_PasswordLogic());
  final state = Get.find<Reset_PasswordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
