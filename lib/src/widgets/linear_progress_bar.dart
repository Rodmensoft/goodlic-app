import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class ProgressBar extends StatelessWidget {
  final double? max;
  final double? current;
  final Color? color;

  const ProgressBar(
      {Key? key,
      @required this.max,
      @required this.current,
      @required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current! / max!) * x;
        return Stack(
          children: [
            Container(
              width: x.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(
                    0xffDBDBDB),
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(35.r),
              ),
            ),
          ],
        );
      },
    );
  }
}
