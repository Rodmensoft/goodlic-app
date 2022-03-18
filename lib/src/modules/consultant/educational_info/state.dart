import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class EducationalInfoState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? numberTextStyle;
  TextStyle? hintTextStyle;
  TextStyle? buttonTextStyle;
  TextStyle? educationHeadingTextStyle;
  TextStyle? educationSubHeadingTextStyle;
  TextStyle? textFieldTextStyle;
  EducationalInfoState() {
    ///Initialize variables
    headingTextStyle = TextStyle(
        fontSize: 28.sp,
        fontFamily: SarabunFontFamily.bold,
        color: customLightThemeColor);
    subHeadingTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.medium,
        color: Colors.white);
    descTextStyle = TextStyle(
      fontSize: 10.sp,
      fontFamily: SarabunFontFamily.regular,
      color: Colors.white,
    );
    numberTextStyle = TextStyle(
      fontSize: 14.sp,
      fontFamily: SarabunFontFamily.regular,
      color: Colors.white,
    );
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
    buttonTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 16.sp,
        color: Colors.white);
    educationHeadingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 10.sp,
        color: customTextGreyColor);
    educationSubHeadingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 12.sp,
        color: customTextBlackColor);
    textFieldTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 15.sp,
        color: Colors.black);
  }
}
