import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/my_appointment/widgets/appontment_detail_box.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:consultant_product/src/widgets/sliver_delegate_tab_fix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class MyAppointmentPage extends StatefulWidget {
  const MyAppointmentPage({Key? key}) : super(key: key);

  @override
  State<MyAppointmentPage> createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<MyAppointmentPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(MyAppointmentLogic());

  final state = Get.find<MyAppointmentLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<MyAppointmentLogic>().tabController =
        TabController(length: logic.tabBarList.length, vsync: this);

    Get.find<MyAppointmentLogic>().scrollController = ScrollController()
      ..addListener(Get.find<MyAppointmentLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<MyAppointmentLogic>()
        .scrollController!
        .removeListener(Get.find<MyAppointmentLogic>().scrollListener);
    Get.find<MyAppointmentLogic>().scrollController!.dispose();
    Get.find<MyAppointmentLogic>().tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<MyAppointmentLogic>(builder: (_myAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: DefaultTabController(
              length: _myAppointmentLogic.tabBarList.length,
              child: NestedScrollView(
                  controller: _myAppointmentLogic.scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      MyCustomSliverAppBar(
                        heading: 'My Appointments',
                        subHeading: 'Manage and See Your Appointments Log',
                        isShrink: _myAppointmentLogic.isShrink,
                      ),
                      SliverPersistentHeader(
                        delegate: SliverAppBarDelegate(TabBar(
                          indicator: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(6), // Creates border
                              color: customLightThemeColor),
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 10.h, 15.w, 5.h),
                          automaticIndicatorColorAdjustment: true,
                          controller: _myAppointmentLogic.tabController,
                          labelColor: Colors.white,
                          labelStyle: state.tabBarSelectedTextStyle,
                          unselectedLabelStyle: state.tabBarUnSelectedTextStyle,
                          unselectedLabelColor: customLightThemeColor,
                          tabs: _myAppointmentLogic.tabBarList,
                        )),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: _myAppointmentLogic.tabController,
                    children: [
                      ///---pending
                      ListView(
                        padding: const EdgeInsetsDirectional.all(0),
                        children: List.generate(6, (index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.toNamed(PageRoutes.appointmentDetail);
                                },
                                child: const AppointmentDetailBox(
                                  image:
                                      'assets/images/dummyTopRatedConsultant.png',
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
                              ),
                              index == 5
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                    )
                                  : const SizedBox()
                            ],
                          );
                        }),
                      ),

                      ///---completed
                      ListView(
                        padding: const EdgeInsetsDirectional.all(0),
                        children: List.generate(6, (index) {
                          return Column(
                            children: [
                              const AppointmentDetailBox(
                                image:
                                'assets/images/dummyTopRatedConsultant.png',
                                name: 'William Smith',
                                category: 'Financial Advisor',
                                fee: '\$25 Fees',
                                type: 'Video Call',
                                typeIcon: 'assets/Icons/videoCallIcon.svg',
                                date: '17/02/22',
                                time: '9:10 AM',
                                status: 1,
                                color: customGreenColor,
                                rating: 4.0,
                              ),
                              index == 5
                                  ? SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    .1,
                              )
                                  : const SizedBox()
                            ],
                          );
                        }),
                      ),

                      ///---cancelled
                      ListView(
                        padding: const EdgeInsetsDirectional.all(0),
                        children: List.generate(6, (index) {
                          return Column(
                            children: [
                              const AppointmentDetailBox(
                                image:
                                'assets/images/dummyTopRatedConsultant.png',
                                name: 'William Smith',
                                category: 'Financial Advisor',
                                fee: '\$25 Fees',
                                type: 'Video Call',
                                typeIcon: 'assets/Icons/videoCallIcon.svg',
                                date: '17/02/22',
                                time: '9:10 AM',
                                status: 2,
                                color: customRedColor,
                                rating: 4.0,
                              ),
                              index == 5
                                  ? SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    .1,
                              )
                                  : const SizedBox()
                            ],
                          );
                        }),
                      ),                    ],
                  )),
            ),
          ),
        );
      });
    });
  }
}
