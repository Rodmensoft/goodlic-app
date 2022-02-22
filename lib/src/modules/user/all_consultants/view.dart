import 'package:consultant_product/src/modules/user/all_consultants/widgets/medical.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../controller/general_controller.dart';
import 'logic.dart';

class AllConsultantsPage extends StatefulWidget {
  const AllConsultantsPage({Key? key}) : super(key: key);

  @override
  State<AllConsultantsPage> createState() => _AllConsultantsPageState();
}

class _AllConsultantsPageState extends State<AllConsultantsPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(AllConsultantsLogic());

  final state = Get.find<AllConsultantsLogic>().state;

  // int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    Get.find<AllConsultantsLogic>().scrollController = ScrollController()
      ..addListener(Get.find<AllConsultantsLogic>().scrollListener);

    /// for tab

    super.initState();
    // Create TabController for getting the index of current tab
    logic.tabController =
        TabController(length: logic.tabBarList.length, vsync: this);

    // logic.tabController.addListener(() {
    //   setState(() {
    //     _selectedIndex = logic.tabController.index;
    //   });
    //   print("Selected Index: " + logic.tabController.index.toString());
    // });
  }

  @override
  void dispose() {
    Get.find<AllConsultantsLogic>()
        .scrollController!
        .removeListener(Get.find<AllConsultantsLogic>().scrollListener);
    Get.find<AllConsultantsLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<AllConsultantsLogic>(builder: (_allConsultantsLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: DefaultTabController(
              length: _allConsultantsLogic.tabBarList.length,
              child: NestedScrollView(
                  controller: _allConsultantsLogic.scrollController,
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
                        backgroundColor: _allConsultantsLogic.isShrink
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
                              SvgPicture.asset(
                                  'assets/Icons/whiteBackArrow.svg'),
                            ],
                          ),
                        ),
                        actions: [
                          ///---notifications
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 15),
                            child: SvgPicture.asset(
                              'assets/Icons/notificationIcon.svg',
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      Text('Consultant',
                                          style: state.headingTextStyle),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                          'Best consultants just one click away',
                                          style: state.subHeadingTextStyle),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate(
                          TabBar(
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      6), // Creates border
                                  color: customLightThemeColor),
                              //  labelPadding: const EdgeInsets.all(10.0),
                              indicatorSize: TabBarIndicatorSize.tab,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.w, 10.h, 10.w, 5.h),
                              // indicatorPadding: const EdgeInsets.all(10.0),
                              automaticIndicatorColorAdjustment: true,
                              isScrollable: true,
                              controller: _allConsultantsLogic.tabController,
                              labelColor: Colors.white,
                              unselectedLabelColor: customLightThemeColor,
                              indicatorColor: Colors.transparent,
                              tabs: _allConsultantsLogic.tabBarList),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: _allConsultantsLogic.tabController,
                    children: const [
                      Medical(),
                      Medical(),
                      Medical(),
                      Medical(),
                      Medical(),
                    ],
                  )),
            ),
          ),
        );
      });
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // ADD THE COLOR YOU WANT AS BACKGROUND.
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
