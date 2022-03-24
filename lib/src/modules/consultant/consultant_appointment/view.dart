import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/get_repo.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/widget/appontment_detail_box.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/widget/page_loader.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment_detail/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:consultant_product/src/widgets/sliver_delegate_tab_fix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:intl/intl.dart';

import 'logic.dart';

class ConsultantAppointmentPage extends StatefulWidget {
  const ConsultantAppointmentPage({Key? key}) : super(key: key);

  @override
  State<ConsultantAppointmentPage> createState() =>
      _ConsultantAppointmentPageState();
}

class _ConsultantAppointmentPageState extends State<ConsultantAppointmentPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(ConsultantAppointmentLogic());

  final state = Get.find<ConsultantAppointmentLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMethod(
        context,
        getConsultantAllAppointmentsURL,
        {
          'token': '123',
          'mentor_id': Get.find<GeneralController>().storageBox.read('userID')
        },
        true,
        getConsultantAllAppointmentsRepo);
    Get.find<ConsultantAppointmentLogic>().tabController =
        TabController(length: logic.tabBarList.length, vsync: this);

    Get.find<ConsultantAppointmentLogic>().scrollController = ScrollController()
      ..addListener(Get.find<ConsultantAppointmentLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<ConsultantAppointmentLogic>()
        .scrollController!
        .removeListener(Get.find<ConsultantAppointmentLogic>().scrollListener);
    Get.find<ConsultantAppointmentLogic>().scrollController!.dispose();
    Get.find<ConsultantAppointmentLogic>().tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ConsultantAppointmentLogic>(
          builder: (_consultantAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: _consultantAppointmentLogic.getUserAppointmentLoader!
                ? const PageLoaderForConsultantAppointments()
                : NestedScrollView(
                    controller: _consultantAppointmentLogic.scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        ///---header
                        MyCustomSliverAppBar(
                          heading: 'My Appointments',
                          subHeading: 'Manage and See Your Appointments Log',
                          isShrink: _consultantAppointmentLogic.isShrink,
                        ),
                        SliverPersistentHeader(
                          delegate: SliverAppBarDelegate(TabBar(
                            indicator: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(6), // Creates border
                                color: customLightThemeColor),
                            indicatorSize: TabBarIndicatorSize.tab,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.w, 5.h, 10.w, 5.h),
                            labelPadding:
                                EdgeInsets.symmetric(horizontal: 25.w),
                            automaticIndicatorColorAdjustment: true,
                            isScrollable: true,
                            controller:
                                _consultantAppointmentLogic.tabController,
                            labelColor: Colors.white,
                            labelStyle: state.tabBarSelectedTextStyle,
                            unselectedLabelStyle:
                                state.tabBarUnSelectedTextStyle,
                            unselectedLabelColor: customLightThemeColor,
                            tabs: _consultantAppointmentLogic.tabBarList,
                          )),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      controller: _consultantAppointmentLogic.tabController,
                      children: [
                        ///---pending
                        _consultantAppointmentLogic
                                .getConsultantAppointmentModel
                                .data!
                                .pendingAppointments!
                                .data!
                                .isEmpty
                            ? Center(
                                child: Text(
                                  'No Record Found',
                                  style: TextStyle(
                                      fontFamily: SarabunFontFamily.regular,
                                      fontSize: 16.sp,
                                      color: customTextBlackColor),
                                ),
                              )
                            : ListView(
                                padding: const EdgeInsetsDirectional.all(0),
                                children: List.generate(
                                    _consultantAppointmentLogic
                                        .getConsultantAppointmentModel
                                        .data!
                                        .pendingAppointments!
                                        .data!
                                        .length, (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.put(
                                              ConsultantAppointmentDetailLogic());
                                          Get.find<ConsultantAppointmentDetailLogic>()
                                                  .selectedAppointmentData =
                                              _consultantAppointmentLogic
                                                  .getConsultantAppointmentModel
                                                  .data!
                                                  .pendingAppointments!
                                                  .data![index];

                                          Get.find<
                                                  ConsultantAppointmentDetailLogic>()
                                              .appointmentStatus = 0;
                                          Get.find<
                                                  ConsultantAppointmentDetailLogic>()
                                              .update();
                                          Get.toNamed(PageRoutes
                                              .consultantAppointmentDetail);
                                        },
                                        child: AppointmentDetailBox(
                                          image: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .pendingAppointments!
                                              .data![index]
                                              .mentee!
                                              .imagePath,
                                          name: _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .pendingAppointments!
                                                      .data![index]
                                                      .mentee!
                                                      .firstName ==
                                                  null
                                              ? '...'
                                              : '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.pendingAppointments!.data![index].mentee!.firstName} '
                                                  '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.pendingAppointments!.data![index].mentee!.lastName}',
                                          category:
                                              '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.pendingAppointments!.data![index].mentee!.email}',
                                          fee:
                                              '\$${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.pendingAppointments!.data![index].payment!} Fees',
                                          type:
                                              '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.pendingAppointments!.data![index].appointmentTypeString}'
                                                  .capitalizeFirst,
                                          typeIcon: _consultantAppointmentLogic
                                                  .imagesForAppointmentTypes[
                                              (_consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .pendingAppointments!
                                                      .data![index]
                                                      .appointmentTypeId!) -
                                                  1],
                                          status: 0,
                                          date: _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .pendingAppointments!
                                                      .data![index]
                                                      .date ==
                                                  null
                                              ? null
                                              : DateFormat('dd/MM/yy').format(
                                                  DateTime.parse(
                                                      _consultantAppointmentLogic
                                                          .getConsultantAppointmentModel
                                                          .data!
                                                          .pendingAppointments!
                                                          .data![index]
                                                          .date!)),
                                          time: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .pendingAppointments!
                                              .data![index]
                                              .time,
                                          color: customOrangeColor,
                                          rating: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .pendingAppointments!
                                              .data![index]
                                              .rating!
                                              .toDouble(),
                                        ),
                                      ),
                                      index ==
                                              _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .pendingAppointments!
                                                      .data!
                                                      .length -
                                                  1
                                          ? Column(
                                              children: [
                                                _consultantAppointmentLogic
                                                            .getConsultantAppointmentModel
                                                            .data!
                                                            .pendingAppointments!
                                                            .currentPage! <
                                                        _consultantAppointmentLogic
                                                            .getConsultantAppointmentModel
                                                            .data!
                                                            .pendingAppointments!
                                                            .lastPage!
                                                    ? _consultantAppointmentLogic
                                                            .getUserAppointmentMoreLoader!
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 25.h),
                                                            child: const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    customThemeColor,
                                                              ),
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 25.h),
                                                            child: Center(
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            30.h),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    _consultantAppointmentLogic
                                                                        .update();
                                                                    _consultantAppointmentLogic
                                                                        .updateGetUserAppointmentMoreLoader(
                                                                            true);

                                                                    // getMethod(
                                                                    //     context,
                                                                    //     getConsultantAllAppointmentsURL,
                                                                    //     {
                                                                    //       'token': '123',
                                                                    //       'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
                                                                    //       'appointment_status': _consultantAppointmentLogic
                                                                    //           .getConsultantAppointmentModel
                                                                    //           .data!
                                                                    //           .pendingAppointments!.data![index].appointmentStatus,
                                                                    //       'page': _consultantAppointmentLogic
                                                                    //           .getConsultantAppointmentModel
                                                                    //           .data!
                                                                    //           .pendingAppointments!
                                                                    //           .currentPage!+1
                                                                    //     },
                                                                    //     true,
                                                                    //     getUserAllAppointmentsMoreRepo);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        36.h,
                                                                    width:
                                                                        116.w,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                customThemeColor),
                                                                        borderRadius:
                                                                            BorderRadius.circular(18.r)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Load More',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                SarabunFontFamily.medium,
                                                                            fontSize: 12.sp,
                                                                            color: customThemeColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .1,
                                                ),
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  );
                                }),
                              ),

                        ///---accepted
                        _consultantAppointmentLogic
                                .getConsultantAppointmentModel
                                .data!
                                .acceptedAppointments!
                                .data!
                                .isEmpty
                            ? Center(
                                child: Text(
                                  'No Record Found',
                                  style: TextStyle(
                                      fontFamily: SarabunFontFamily.regular,
                                      fontSize: 16.sp,
                                      color: customTextBlackColor),
                                ),
                              )
                            : ListView(
                                padding: const EdgeInsetsDirectional.all(0),
                                children: List.generate(
                                    _consultantAppointmentLogic
                                        .getConsultantAppointmentModel
                                        .data!
                                        .acceptedAppointments!
                                        .data!
                                        .length, (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.put(
                                              ConsultantAppointmentDetailLogic());
                                          Get.find<ConsultantAppointmentDetailLogic>()
                                                  .selectedAppointmentData =
                                              _consultantAppointmentLogic
                                                  .getConsultantAppointmentModel
                                                  .data!
                                                  .acceptedAppointments!
                                                  .data![index];
                                          Get.find<
                                                  ConsultantAppointmentDetailLogic>()
                                              .appointmentStatus = 1;
                                          Get.find<
                                                  ConsultantAppointmentDetailLogic>()
                                              .update();
                                          Get.toNamed(PageRoutes
                                              .consultantAppointmentDetail);
                                        },
                                        child: AppointmentDetailBox(
                                          image: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .acceptedAppointments!
                                              .data![index]
                                              .mentee!
                                              .imagePath,
                                          name: _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .acceptedAppointments!
                                                      .data![index]
                                                      .mentee!
                                                      .firstName ==
                                                  null
                                              ? '...'
                                              : '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.acceptedAppointments!.data![index].mentee!.firstName} '
                                                  '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.acceptedAppointments!.data![index].mentee!.lastName}',
                                          category:
                                              '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.acceptedAppointments!.data![index].mentee!.email}',
                                          fee:
                                              '\$${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.acceptedAppointments!.data![index].payment!} Fees',
                                          type:
                                              '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.acceptedAppointments!.data![index].appointmentTypeString}'
                                                  .capitalizeFirst,
                                          typeIcon: _consultantAppointmentLogic
                                                  .imagesForAppointmentTypes[
                                              (_consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .acceptedAppointments!
                                                      .data![index]
                                                      .appointmentTypeId!) -
                                                  1],
                                          status: 1,
                                          date: _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .acceptedAppointments!
                                                      .data![index]
                                                      .date ==
                                                  null
                                              ? null
                                              : DateFormat('dd/MM/yy').format(
                                                  DateTime.parse(
                                                      _consultantAppointmentLogic
                                                          .getConsultantAppointmentModel
                                                          .data!
                                                          .acceptedAppointments!
                                                          .data![index]
                                                          .date!)),
                                          time: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .acceptedAppointments!
                                              .data![index]
                                              .time,
                                          color: customLightThemeColor,
                                          rating: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .acceptedAppointments!
                                              .data![index]
                                              .rating!
                                              .toDouble(),
                                        ),
                                      ),
                                      index ==
                                              _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .acceptedAppointments!
                                                      .data!
                                                      .length -
                                                  1
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .1,
                                            )
                                          : const SizedBox()
                                    ],
                                  );
                                }),
                              ),

                        ///---completed
                        _consultantAppointmentLogic
                                .getConsultantAppointmentModel
                                .data!
                                .completedAppointments!
                                .data!
                                .isEmpty
                            ? Center(
                                child: Text(
                                  'No Record Found',
                                  style: TextStyle(
                                      fontFamily: SarabunFontFamily.regular,
                                      fontSize: 16.sp,
                                      color: customTextBlackColor),
                                ),
                              )
                            : ListView(
                                padding: const EdgeInsetsDirectional.all(0),
                                children: List.generate(
                                    _consultantAppointmentLogic
                                        .getConsultantAppointmentModel
                                        .data!
                                        .completedAppointments!
                                        .data!
                                        .length, (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.put(
                                              ConsultantAppointmentDetailLogic());
                                          Get.find<ConsultantAppointmentDetailLogic>()
                                                  .selectedAppointmentData =
                                              _consultantAppointmentLogic
                                                  .getConsultantAppointmentModel
                                                  .data!
                                                  .completedAppointments!
                                                  .data![index];
                                          Get.find<
                                                  ConsultantAppointmentDetailLogic>()
                                              .appointmentStatus = 2;
                                          Get.find<
                                                  ConsultantAppointmentDetailLogic>()
                                              .update();
                                          Get.toNamed(PageRoutes
                                              .consultantAppointmentDetail);
                                        },
                                        child: AppointmentDetailBox(
                                          image: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .completedAppointments!
                                              .data![index]
                                              .mentee!
                                              .imagePath,
                                          name: _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .completedAppointments!
                                                      .data![index]
                                                      .mentee!
                                                      .firstName ==
                                                  null
                                              ? '...'
                                              : '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.completedAppointments!.data![index].mentee!.firstName} '
                                                  '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.completedAppointments!.data![index].mentee!.lastName}',
                                          category:
                                              '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.completedAppointments!.data![index].mentee!.email}',
                                          fee:
                                              '\$${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.completedAppointments!.data![index].payment!} Fees',
                                          type:
                                              '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.completedAppointments!.data![index].appointmentTypeString}'
                                                  .capitalizeFirst,
                                          typeIcon: _consultantAppointmentLogic
                                                  .imagesForAppointmentTypes[
                                              (_consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .completedAppointments!
                                                      .data![index]
                                                      .appointmentTypeId!) -
                                                  1],
                                          date: _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .completedAppointments!
                                                      .data![index]
                                                      .date ==
                                                  null
                                              ? null
                                              : DateFormat('dd/MM/yy').format(
                                                  DateTime.parse(
                                                      _consultantAppointmentLogic
                                                          .getConsultantAppointmentModel
                                                          .data!
                                                          .completedAppointments!
                                                          .data![index]
                                                          .date!)),
                                          time: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .completedAppointments!
                                              .data![index]
                                              .time,
                                          rating: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .completedAppointments!
                                              .data![index]
                                              .rating!
                                              .toDouble(),
                                          status: 2,
                                          color: customGreenColor,
                                        ),
                                      ),
                                      index ==
                                              _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .completedAppointments!
                                                      .data!
                                                      .length -
                                                  1
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .1,
                                            )
                                          : const SizedBox()
                                    ],
                                  );
                                }),
                              ),

                        ///---cancelled
                        _consultantAppointmentLogic
                                .getConsultantAppointmentModel
                                .data!
                                .cancelledAppointments!
                                .data!
                                .isEmpty
                            ? Center(
                                child: Text(
                                  'No Record Found',
                                  style: TextStyle(
                                      fontFamily: SarabunFontFamily.regular,
                                      fontSize: 16.sp,
                                      color: customTextBlackColor),
                                ),
                              )
                            : ListView(
                                padding: const EdgeInsetsDirectional.all(0),
                                children: List.generate(
                                    _consultantAppointmentLogic
                                        .getConsultantAppointmentModel
                                        .data!
                                        .cancelledAppointments!
                                        .data!
                                        .length, (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.put(
                                              ConsultantAppointmentDetailLogic());
                                          Get.find<ConsultantAppointmentDetailLogic>()
                                                  .selectedAppointmentData =
                                              _consultantAppointmentLogic
                                                  .getConsultantAppointmentModel
                                                  .data!
                                                  .cancelledAppointments!
                                                  .data![index];
                                          Get.find<
                                                  ConsultantAppointmentDetailLogic>()
                                              .appointmentStatus = 3;
                                          Get.find<
                                                  ConsultantAppointmentDetailLogic>()
                                              .update();
                                          Get.toNamed(PageRoutes
                                              .consultantAppointmentDetail);
                                        },
                                        child: AppointmentDetailBox(
                                          image: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .cancelledAppointments!
                                              .data![index]
                                              .mentee!
                                              .imagePath,
                                          name: _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .cancelledAppointments!
                                                      .data![index]
                                                      .mentee!
                                                      .firstName ==
                                                  null
                                              ? '...'
                                              : '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.cancelledAppointments!.data![index].mentee!.firstName} '
                                                  '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.cancelledAppointments!.data![index].mentee!.lastName}',
                                          category:
                                              '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.cancelledAppointments!.data![index].mentee!.email}',
                                          fee:
                                              '\$${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.cancelledAppointments!.data![index].payment!} Fees',
                                          type:
                                              '${_consultantAppointmentLogic.getConsultantAppointmentModel.data!.cancelledAppointments!.data![index].appointmentTypeString}'
                                                  .capitalizeFirst,
                                          typeIcon: _consultantAppointmentLogic
                                                  .imagesForAppointmentTypes[
                                              (_consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .cancelledAppointments!
                                                      .data![index]
                                                      .appointmentTypeId!) -
                                                  1],
                                          date: _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .cancelledAppointments!
                                                      .data![index]
                                                      .date ==
                                                  null
                                              ? null
                                              : DateFormat('dd/MM/yy').format(
                                                  DateTime.parse(
                                                      _consultantAppointmentLogic
                                                          .getConsultantAppointmentModel
                                                          .data!
                                                          .cancelledAppointments!
                                                          .data![index]
                                                          .date!)),
                                          time: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .cancelledAppointments!
                                              .data![index]
                                              .time,
                                          rating: _consultantAppointmentLogic
                                              .getConsultantAppointmentModel
                                              .data!
                                              .cancelledAppointments!
                                              .data![index]
                                              .rating!
                                              .toDouble(),
                                          status: 3,
                                          color: customRedColor,
                                        ),
                                      ),
                                      index ==
                                              _consultantAppointmentLogic
                                                      .getConsultantAppointmentModel
                                                      .data!
                                                      .cancelledAppointments!
                                                      .data!
                                                      .length -
                                                  1
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .1,
                                            )
                                          : const SizedBox()
                                    ],
                                  );
                                }),
                              ),
                      ],
                    )),
          ),
        );
      });
    });
  }
}
