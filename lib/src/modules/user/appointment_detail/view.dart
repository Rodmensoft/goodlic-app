import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/appointment_detail/widget/bottom_sheet.dart';
import 'package:consultant_product/src/modules/user/my_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/my_appointment/widgets/appontment_detail_box.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resize/resize.dart';
import 'logic.dart';
import 'package:intl/intl.dart';

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

    // getMethod(
    //     context,
    //     getAppointmentsDetailURL,
    //     {
    //       'token': '123',
    //       'appointment_id': 19,
    //       'user_id': Get.find<GeneralController>().storageBox.read('userID')
    //     },
    //     true,
    //     getAppointmentDetailRepo);

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
                      trailingIcon: Get.find<MyAppointmentLogic>()
                          .imagesForAppointmentTypes[(_appointmentDetailLogic
                          .selectedAppointmentData.appointmentTypeId!) -
                          1],
                      onTapTrailing: () {
                        // Get.toNamed(PageRoutes.chatScreen);
                      },
                    ),
                  ];
                },
                body: Column(
                  children: [
                    AppointmentDetailBox(
                      image: _appointmentDetailLogic
                          .selectedAppointmentData.mentor!.imagePath,
                      name: _appointmentDetailLogic
                                  .selectedAppointmentData.mentor!.firstName ==
                              null
                          ? '...'
                          : '${_appointmentDetailLogic.selectedAppointmentData.mentor!.firstName} '
                              '${_appointmentDetailLogic.selectedAppointmentData.mentor!.lastName}',
                      category:
                          '${_appointmentDetailLogic.selectedAppointmentData.category}',
                      fee:
                          '\$${_appointmentDetailLogic.selectedAppointmentData.payment!} Fees',
                      type:
                          '${_appointmentDetailLogic.selectedAppointmentData.appointmentTypeString}'
                              .capitalizeFirst,
                      typeIcon: Get.find<MyAppointmentLogic>()
                          .imagesForAppointmentTypes[(_appointmentDetailLogic
                              .selectedAppointmentData.appointmentTypeId!) -
                          1],
                      date:DateFormat('dd/MM/yy').format(
                          DateTime.parse(
                              _appointmentDetailLogic.selectedAppointmentData.date!)),
                      time:
                          _appointmentDetailLogic.selectedAppointmentData.time!,
                      rating: _appointmentDetailLogic
                          .selectedAppointmentData.rating!
                          .toDouble(),
                      status: _appointmentDetailLogic.appointmentStatus,
                      color: _appointmentDetailLogic.colorForAppointmentTypes[
                          _appointmentDetailLogic.appointmentStatus!],
                    )
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
