
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';

class AppointmentDetailBox extends StatelessWidget {
  const AppointmentDetailBox({Key? key,required this.title,required this.image}) : super(key: key);

  final String? title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: customTextFieldColor,
          borderRadius: BorderRadius.circular(8.r)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 0.h,horizontal: 21.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('$image',color: customLightThemeColor,),
            Text(
              '$title',
              style: const TextStyle(
                  fontFamily: SarabunFontFamily.regular,
                  fontSize: 14,
                  color: customTextBlackColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
