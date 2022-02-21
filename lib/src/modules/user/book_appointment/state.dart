import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class BookAppointmentState {

  TextStyle? appBarTitleTextStyle;
  TextStyle? appBarSubTitleTextStyle;

  BookAppointmentState() {
    ///Initialize variables
    appBarTitleTextStyle =  TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 28.sp,
        color: customLightThemeColor
    );
    appBarSubTitleTextStyle =  TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 12.sp,
        color: Colors.white
    );
  }
}
