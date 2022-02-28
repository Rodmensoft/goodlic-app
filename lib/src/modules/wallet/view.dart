import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/notififcation_icon.dart';
import 'logic.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final logic = Get.put(WalletLogic());

  final state = Get.find<WalletLogic>().state;

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<WalletLogic>().scrollController = ScrollController()
      ..addListener(Get.find<WalletLogic>().scrollListener);
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        borderColor: Colors.red,
        borderWidth: 5,
        color: Colors.lightBlue);
  }

  @override
  void dispose() {
    Get.find<WalletLogic>()
        .scrollController!
        .removeListener(Get.find<WalletLogic>().scrollListener);
    Get.find<WalletLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<WalletLogic>(builder: (_walletLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _walletLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                        expandedHeight:
                            MediaQuery.of(context).size.height * .24,
                        floating: true,
                        pinned: true,
                        snap: true,
                        elevation: 0,
                        backgroundColor: _walletLogic.isShrink!
                            ? customThemeColor
                            : Colors.transparent,
                        leading: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/Icons/whiteBackArrow.svg'),
                            ],
                          ),
                        ),
                        actions: const [
                          ///---notifications
                          CustomNotificationIcon()
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(40.r))),
                            child: Column(children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .27,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                      child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.w, 25.h, 16.w, 16.h),
                                    child: Stack(children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 25.h,
                                            ),
                                            Text('Amount In Wallet',
                                                style: state.descTextStyle),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('\$350.00',
                                                    style:
                                                        state.headingTextStyle),
                                                CircleAvatar(
                                                  radius: 20.r,
                                                  backgroundColor: Colors.white,
                                                  child: Center(
                                                      child: SvgPicture.asset(
                                                    'assets/Icons/add.svg',
                                                    height: 20.h,
                                                    width: 20.w,
                                                    color: customOrangeColor,
                                                    fit: BoxFit.cover,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ]),
                                  )),
                                ],
                              ),
                            ]),
                          ),
                        ))
                  ];
                },
                body: Column(
                  children: [
                    SizedBox(height: 25.h),
                    Text(
                      'Annual Record',
                      style: state.recordTextStyle,
                    ),
                    SizedBox(height: 65.h),
                    Center(
                        child: Container(
                            child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      tooltipBehavior: _tooltipBehavior,
                    )))
                  ],
                )),
          ),
        );
      });
    });
  }
}
