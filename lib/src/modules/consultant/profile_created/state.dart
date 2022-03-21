import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class ProfileCreatedState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? numberTextStyle;
  TextStyle? successHeadingTextStyle;
  TextStyle? successSubHeadingTextStyle;
  ProfileCreatedState() {
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
    successHeadingTextStyle = TextStyle(
      fontSize: 28.sp,
      fontFamily: SarabunFontFamily.bold,
      color: customTextBlackColor,
    );
    successSubHeadingTextStyle = TextStyle(
      fontSize: 16.sp,
      fontFamily: SarabunFontFamily.medium,
      color: customOrangeColor,
    );
  }
}
