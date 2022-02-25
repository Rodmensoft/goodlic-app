import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/appointment_detail/widget/bottom_sheet.dart';
import 'package:consultant_product/src/modules/user/my_appointment/widgets/appontment_detail_box.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class AppointmentDetailPage extends StatefulWidget {
  const AppointmentDetailPage({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailPage> createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  final logic = Get.put(AppointmentDetailLogic());

  final state = Get.find<AppointmentDetailLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<AppointmentDetailLogic>().scrollController = ScrollController()
      ..addListener(Get.find<AppointmentDetailLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<AppointmentDetailLogic>()
        .scrollController!
        .removeListener(Get.find<AppointmentDetailLogic>().scrollListener);
    Get.find<AppointmentDetailLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<AppointmentDetailLogic>(
          builder: (_appointmentDetailLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _appointmentDetailLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: 'Appt. Detail',
                      subHeading: 'Your Appointment Detail With William Smith',
                      isShrink: _appointmentDetailLogic.isShrink,
                      trailingIcon: 'assets/Icons/chatIcon.svg',
                    ),
                  ];
                },
                body: Column(
                  children: const [
                    AppointmentDetailBox(
                      image: 'assets/images/dummyTopRatedConsultant.png',
                      name: 'William Smith',
                      category: 'Financial Advisor',
                      fee: '\$25 Fees',
                      type: 'Video Call',
                      typeIcon: 'assets/Icons/videoCallIcon.svg',
                      status: 0,
                      date: '17/02/22',
                      time: '9:10 AM',
                      color: customLightThemeColor,
                      rating: 4.0,
                    ),
                  ],
                )),
            bottomNavigationBar: GestureDetector(
              onTap: () {
                openBottomSheet();
              },
              onVerticalDragStart: (event) {
                openBottomSheet();
              },
              child: Container(
                height: 74.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 15,
                        // offset: Offset(1,5)
                      )
                    ],
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.r))),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: SvgPicture.asset('assets/Icons/bottomUpArrowIcon.svg'),
                )),
              ),
            ),
          ),
        );
      });
    });
  }

  openBottomSheet() {
    return showCupertinoModalBottomSheet(
        topRadius: Radius.circular(30.r),
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const ModalInsideModal());
  }
}
