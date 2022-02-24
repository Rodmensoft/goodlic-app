import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class MyCustomSliverAppBar extends StatefulWidget {
  const MyCustomSliverAppBar(
      {Key? key, this.heading, this.subHeading, this.trailing, this.isShrink})
      : super(key: key);

  final String? heading;
  final String? subHeading;
  final String? trailing;
  final bool? isShrink;

  @override
  _MyCustomSliverAppBarState createState() => _MyCustomSliverAppBarState();
}

class _MyCustomSliverAppBarState extends State<MyCustomSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * .2,
      floating: true,
      pinned: true,
      snap: true,
      elevation: 0,
      backgroundColor: widget.isShrink! ? customThemeColor : Colors.white,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
          ],
        ),
      ),
      actions: const [
        ///---notifications

        CustomNotificationIcon()
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/bookAppointmentAppBar.svg',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .4,
              fit: BoxFit.fill,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.w, 25.h, 16.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      '${widget.heading}',
                      style: TextStyle(
                          fontFamily: SarabunFontFamily.bold,
                          fontSize: 28.sp,
                          color: customLightThemeColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.subHeading}',
                          style: TextStyle(
                              fontFamily: SarabunFontFamily.medium,
                              fontSize: 12.sp,
                              color: Colors.white),
                        ),
                        widget.trailing == null
                            ? const SizedBox()
                            : Text(
                                '${widget.trailing}',
                                style: TextStyle(
                                    fontFamily: SarabunFontFamily.medium,
                                    fontSize: 12.sp,
                                    color: Colors.white),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
