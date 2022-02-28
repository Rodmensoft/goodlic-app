import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class WalletState {
  TextStyle? headingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? subheadingTextStyle;
  TextStyle? recordTextStyle;
  TextStyle? walletTextStyle;

  WalletState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
      fontSize: 28.sp,
      fontFamily: SarabunFontFamily.bold,
      color: customLightThemeColor,
    );
    descTextStyle = TextStyle(
      fontSize: 12.sp,
      fontFamily: SarabunFontFamily.medium,
      color: Colors.white,
    );
    subheadingTextStyle = TextStyle(
      fontSize: 18.sp,
      fontFamily: SarabunFontFamily.extraBold,
      color: customTextBlackColor,
    );
    recordTextStyle = TextStyle(
      fontSize: 16.sp,
      fontFamily: SarabunFontFamily.extraBold,
      color: customTextBlackColor,
    );
    walletTextStyle = TextStyle(
      fontSize: 14.sp,
      fontFamily: SarabunFontFamily.regular,
      color: customTextBlackColor,
    );
  }
}
