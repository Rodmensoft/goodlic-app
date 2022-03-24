import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/logic.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/widget/appontment_detail_box.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment_detail/widget/bottom_sheet.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resize/resize.dart';

import 'package:intl/intl.dart';
import 'logic.dart';

class ConsultantAppointmentDetailPage extends StatefulWidget {

  const ConsultantAppointmentDetailPage({Key? key}) : super(key: key);

  @override
  State<ConsultantAppointmentDetailPage> createState() => _ConsultantAppointmentDetailPageState();
}

class _ConsultantAppointmentDetailPageState extends State<ConsultantAppointmentDetailPage> {
  final logic = Get.put(ConsultantAppointmentDetailLogic());

  final state = Get.find<ConsultantAppointmentDetailLogic>().state;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Get.find<ConsultantAppointmentDetailLogic>().scrollController = ScrollController()
      ..addListener(Get.find<ConsultantAppointmentDetailLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<ConsultantAppointmentDetailLogic>()
        .scrollController!
        .removeListener(Get.find<ConsultantAppointmentDetailLogic>().scrollListener);
    Get.find<ConsultantAppointmentDetailLogic>().scrollController!.dispose();
    super.dispose();
  }

  


  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ConsultantAppointmentDetailLogic>(
          builder: (_consultantAppointmentDetailLogic) {
            return GestureDetector(
              onTap: () {
                _generalController.focusOut(context);
              },
              child: Scaffold(
                backgroundColor: const Color(0xffFBFBFB),
                body: NestedScrollView(
                    controller: _consultantAppointmentDetailLogic.scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        ///---header
                        MyCustomSliverAppBar(
                          heading: 'Appt. Detail',
                          subHeading: 'Your Appointment Detail With William Smith',
                          isShrink: _consultantAppointmentDetailLogic.isShrink,
                          trailingIcon: Get.find<ConsultantAppointmentLogic>()
                              .imagesForAppointmentTypes[(_consultantAppointmentDetailLogic
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
                          image: _consultantAppointmentDetailLogic
                              .selectedAppointmentData.mentee!.imagePath,
                          name: _consultantAppointmentDetailLogic
                              .selectedAppointmentData.mentee!.firstName ==
                              null
                              ? '...'
                              : '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.firstName} '
                              '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.lastName}',
                          category:
                          '${_consultantAppointmentDetailLogic.selectedAppointmentData.mentee!.email}',
                          fee:
                          '\$${_consultantAppointmentDetailLogic.selectedAppointmentData.payment!} Fees',
                          type:
                          '${_consultantAppointmentDetailLogic.selectedAppointmentData.appointmentTypeString}'
                              .capitalizeFirst,
                          typeIcon: Get.find<ConsultantAppointmentLogic>()
                              .imagesForAppointmentTypes[(_consultantAppointmentDetailLogic
                              .selectedAppointmentData.appointmentTypeId!) -
                              1],
                          date:DateFormat('dd/MM/yy').format(
                              DateTime.parse(
                                  _consultantAppointmentDetailLogic.selectedAppointmentData.date!)),
                          time:
                          _consultantAppointmentDetailLogic.selectedAppointmentData.time!,
                          rating: _consultantAppointmentDetailLogic
                              .selectedAppointmentData.rating == null
                              ?0
                              :_consultantAppointmentDetailLogic
                              .selectedAppointmentData.rating!
                              .toDouble(),
                          status: _consultantAppointmentDetailLogic.appointmentStatus,
                          color: _consultantAppointmentDetailLogic.colorForAppointmentTypes[
                          _consultantAppointmentDetailLogic.appointmentStatus!],
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
        builder: (context) => const ModalInsideModalForConsultant());
  }
}
