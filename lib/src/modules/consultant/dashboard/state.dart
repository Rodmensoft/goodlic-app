import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';

class DashboardState {
  TextStyle? mentorDetailTileTitleTextStyle;
  TextStyle? mentorDetailTileTitle2TextStyle;
  TextStyle? mentorDetailTileTitle3TextStyle;
  TextStyle? appointmentCountTitleTextStyle;
  TextStyle? appointmentCountValueTextStyle;
  TextStyle? headingTextStyle;
  TextStyle? ratingTextStyle;
  TextStyle? appointmentListLabelTextStyle;
  TextStyle? appointmentListValueTextStyle;
  DashboardState() {
    ///Initialize variables
    mentorDetailTileTitleTextStyle = const TextStyle(
        fontSize: 13,
        fontFamily: SarabunFontFamily.bold,
        color: customLightThemeColor);
    mentorDetailTileTitle2TextStyle = const TextStyle(
        fontSize: 13,
        fontFamily: SarabunFontFamily.light,
        color: customTextBlackColor);
    mentorDetailTileTitle3TextStyle = const TextStyle(
        fontSize: 10,
        fontFamily: SarabunFontFamily.light,
        color: customTextBlackColor);
    appointmentCountTitleTextStyle = const TextStyle(
        fontSize: 10,
        fontFamily: SarabunFontFamily.medium,
        color: Colors.white);
    appointmentCountValueTextStyle = const TextStyle(
        fontSize: 16, fontFamily: SarabunFontFamily.bold, color: Colors.white);
    headingTextStyle = const TextStyle(
        fontSize: 20,
        fontFamily: SarabunFontFamily.extraBold,
        color: customTextBlackColor);
    ratingTextStyle = const TextStyle(
        fontSize: 10,
        fontFamily: SarabunFontFamily.regular,
        color: Colors.black);
    appointmentListLabelTextStyle = const TextStyle(
        fontSize: 10,
        fontFamily: SarabunFontFamily.bold,
        color: customThemeColor);
    appointmentListValueTextStyle = const TextStyle(
        fontSize: 10,
        fontFamily: SarabunFontFamily.medium,
        color: customTextBlackColor);
  }
}
