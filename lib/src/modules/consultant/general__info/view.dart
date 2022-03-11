import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class General_InfoPage extends StatelessWidget {
  final logic = Get.put(General_InfoLogic());
  final state = Get.find<General_InfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
