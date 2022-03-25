import 'dart:developer';

import 'package:flutter/material.dart';

sendSMSRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
      log('sendSMSRepo ------>> ${response['Status'].toString()}');
    } else {}
  } else if (!responseCheck) {
    log('Exception........................');
  }
}
