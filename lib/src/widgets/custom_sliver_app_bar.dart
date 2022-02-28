import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class MyCustomSliverAppBar extends StatefulWidget {
  const MyCustomSliverAppBar(
      {Key? key,
      this.heading,
      this.subHeading,
      this.trailing,
      this.trailingIcon,
      this.fee,
      this.isShrink,
      this.searchIconShow,
      this.onTapTrailing})
      : super(key: key);

  final String? heading;
  final String? subHeading;
  final String? trailing;
  final String? trailingIcon;
  final String? fee;
  final bool? isShrink;
  final bool? searchIconShow;
  final Function? onTapTrailing;

  @override
  _MyCustomSliverAppBarState createState() => _MyCustomSliverAppBarState();
}

class _MyCustomSliverAppBarState extends State<MyCustomSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.fee == null
          ? MediaQuery.of(context).size.height * .24
          : MediaQuery.of(context).size.height * .35,
      floating: true,
      pinned: true,
      snap: true,
      elevation: 0,
      backgroundColor: widget.isShrink! ? customThemeColor : Colors.transparent,
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
      actions: [
        ///---notifications

        widget.searchIconShow != null
            ? Padding(
                padding: EdgeInsetsDirectional.only(end: 5.w),
                child: SvgPicture.asset(
                  'assets/Icons/searchIcon.svg',
                  color: customLightThemeColor,
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: 20.w,
        ),
        const CustomNotificationIcon()
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
              color: widget.fee == null
                  ? Colors.transparent
                  : customLightThemeColor,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.r))),
          child: Column(
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/bookAppointmentAppBar.svg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .27,
                    fit: BoxFit.fill,
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.w, 25.h, 16.w, 16.h),
                      child: Stack(
                        children: [
                          Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              fontFamily:
                                                  SarabunFontFamily.medium,
                                              fontSize: 12.sp,
                                              color: Colors.white),
                                        ),
                                ],
                              ),
                            ],
                          ),
                          widget.trailingIcon == null
                              ? const SizedBox()
                              : PositionedDirectional(
                                  end: 0,
                                  top: 45.h,
                                  child: InkWell(
                                    onTap: () => widget.onTapTrailing!(),
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: Colors.white,
                                      child: Center(
                                          child: SvgPicture.asset(
                                        widget.trailingIcon!,
                                        height: 20.h,
                                        width: 20.w,
                                        color: customOrangeColor,
                                        fit: BoxFit.cover,
                                      )),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              widget.fee == null
                  ? const SizedBox()
                  : SizedBox(
                      height: 15.h,
                    ),
              widget.fee == null
                  ? const SizedBox()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'You Will Pay',
                          style: TextStyle(
                              fontFamily: SarabunFontFamily.medium,
                              fontSize: 12.sp,
                              color: Colors.white),
                        ),
                        // SizedBox(
                        //   height: 8.h,
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/Icons/videoCallIcon.svg',
                              color: Colors.white,
                              height: 12.h,
                              width: 18.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              '\$25',
                              style: TextStyle(
                                  fontFamily: SarabunFontFamily.bold,
                                  fontSize: 28.sp,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
              widget.fee == null
                  ? const SizedBox()
                  : SizedBox(
                      height: 15.h,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
