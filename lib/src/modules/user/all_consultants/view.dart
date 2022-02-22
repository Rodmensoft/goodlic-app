import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../utils/constants.dart';
import 'logic.dart';

class AllConsultantsPage extends StatefulWidget {
  const AllConsultantsPage({Key? key}) : super(key: key);

  @override
  State<AllConsultantsPage> createState() => _AllConsultantsPageState();
}

class _AllConsultantsPageState extends State<AllConsultantsPage> {
  final logic = Get.put(AllConsultantsLogic());

  final state = Get.find<AllConsultantsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          //  controller: _userHomeLogic.scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              ///---header
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * .35,
                floating: true,
                pinned: true,
                snap: true,
                elevation: 0,
                backgroundColor:
                    _userHomeLogic.isShrink ? customThemeColor : Colors.white,
                // backgroundColor: customThemeColor,
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/Icons/drawerIcon.svg'),
                  ],
                ),
                actions: [
                  ///---notifications
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 15),
                    child:
                        SvgPicture.asset('assets/Icons/notificationIcon.svg'),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/homeBackground.svg',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .4,
                        fit: BoxFit.fill,
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.w, 20.h, 16.w, 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50.h,
                              ),
                              const Text(
                                'Find Your',
                                style: TextStyle(
                                    fontFamily: SarabunFontFamily.medium,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text('Consultant', style: state.headingTextStyle),
                              SizedBox(
                                height: 20.h,
                              ),

                              ///---search-field
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  suffixIcon: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/Icons/searchIcon.svg'),
                                    ],
                                  ),
                                  hintText: 'Search Here',
                                  hintStyle: const TextStyle(
                                      fontFamily: SarabunFontFamily.medium,
                                      fontSize: 14,
                                      color: Color(0xffA3A7AA)),
                                  fillColor: customTextFieldColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field is required';
                                  } else if (!GetUtils.isEmail(value)) {
                                    return 'Enter Valid Email';
                                  } else {
                                    return null;
                                  }
                                },
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
          body:
              ListView(padding: const EdgeInsets.only(top: 0), children: const [
            // ///---top-consultants
            // TopConsultants(),
            //
            // ///---categories
            // CategoriesWidget(),
            //
            // ///---top-rated-consultant
            // TopRatedConsultants(),
          ])),
    );
  }
}
