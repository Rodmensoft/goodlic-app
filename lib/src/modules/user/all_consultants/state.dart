import 'dart:ui';

import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:resize/resize.dart';

class AllConsultantsState {
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;

  AllConsultantsState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
      fontFamily: SarabunFontFamily.bold,
      fontSize: 28.sp,
      color: customLightThemeColor,
    );
    subHeadingTextStyle = TextStyle();
  }
}
