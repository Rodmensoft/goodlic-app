import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({Key? key}) : super(key: key);

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  final logic = Get.put(BookAppointmentLogic());

  final state = Get.find<BookAppointmentLogic>().state;
  @override
  void initState() {
    super.initState();

    Get
        .find<BookAppointmentLogic>()
        .scrollController = ScrollController()
      ..addListener(Get
          .find<BookAppointmentLogic>()
          .scrollListener);
  }

  @override
  void dispose() {
    Get
        .find<BookAppointmentLogic>()
        .scrollController!
        .removeListener(Get
        .find<BookAppointmentLogic>()
        .scrollListener);
    Get
        .find<BookAppointmentLogic>()
        .scrollController!
        .dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                controller: _bookAppointmentLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .2,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 0,
                      backgroundColor: _bookAppointmentLogic.isShrink
                          ? customThemeColor
                          : Colors.white,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 15),
                          child: SvgPicture.asset(
                              'assets/Icons/notificationIcon.svg',),
                        )
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.w, 25.h, 16.w, 16.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                     Text(
                                      'Book Appointment',
                                      style: state.appBarTitleTextStyle,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'By just few easy steps',
                                          style: state.appBarSubTitleTextStyle,
                                        ),
                                        Text(
                                          'Step 1 Of 3',
                                          style: state.appBarSubTitleTextStyle,
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
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    ListView(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0),
                        children:  [
                          Text(
                            'Select Option',
                            style: state.headingTextStyle,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Wrap(
                            children: List.generate(
                                _bookAppointmentLogic
                                    .appointmentTypes.length, (index) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 18.w, 11.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(8.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                          Colors.grey.withOpacity(0.2),
                                          spreadRadius: -2,
                                          blurRadius: 15,
                                          // offset: Offset(1,5)
                                        )
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.w,vertical: 13.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                '${_bookAppointmentLogic.appointmentTypes[index].image}',),
                                            SizedBox(
                                              width: 10.w,
                                            ),Text(
                                              '${_bookAppointmentLogic.appointmentTypes[index].title}',
                                              style: state.typeTextStyle,
                                            ),

                                          ],
                                        ),SizedBox(
                                          height: 5.h,
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 28.w),
                                          child: Text(
                                            '${_bookAppointmentLogic.appointmentTypes[index].fee}',
                                            style: state.typePriceTextStyle,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        ]),

                    ///---bottom-bar
                    Positioned(
                      bottom: 25.h,
                      left: 15.w,
                      right: 15.w,
                      child: InkWell(
                        onTap: (){
                          // Get.toNamed(PageRoutes.bookAppointment);
                        },
                        child: const MyCustomBottomBar(
                          title: 'Continue',
                          disable: true,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      });
    });
  }
}
