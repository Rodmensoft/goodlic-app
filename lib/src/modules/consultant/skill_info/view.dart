import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../../route_generator.dart';
import '../../../controller/general_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_bottom_bar.dart';
import 'logic.dart';

class SkillInfoPage extends StatefulWidget {
  const SkillInfoPage({Key? key}) : super(key: key);

  @override
  State<SkillInfoPage> createState() => _SkillInfoPageState();
}

class _SkillInfoPageState extends State<SkillInfoPage> {
  final logic = Get.put(SkillInfoLogic());

  final state = Get.find<SkillInfoLogic>().state;

  String? _currentGenderValue;
  final _gender = [
    "Male",
    "Female",
    "Others",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<SkillInfoLogic>().scrollController = ScrollController()
      ..addListener(Get.find<SkillInfoLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<SkillInfoLogic>()
        .scrollController!
        .removeListener(Get.find<SkillInfoLogic>().scrollListener);
    Get.find<SkillInfoLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<SkillInfoLogic>(builder: (_skillInfoLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: customThemeColor,
            body: NestedScrollView(
                controller: _skillInfoLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                        expandedHeight:
                            MediaQuery.of(context).size.height * .29,
                        floating: true,
                        pinned: true,
                        snap: true,
                        elevation: 0,
                        backgroundColor: _skillInfoLogic.isShrink
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
                        // actions: const [
                        //   ///---notifications
                        //   CustomNotificationIcon()
                        // ],
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
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Image.asset(
                                      'assets/images/registrationBackground.png',
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                    ),
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
                                            Text('Registration',
                                                style: state.headingTextStyle),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              'Register As A Mentor In Few Easy Steps',
                                              style: state.subHeadingTextStyle,
                                            ),
                                            SizedBox(height: 30.h),

                                            /// Registration Status

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 40.h,
                                                  width: 40.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              customGreenColor),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 22.sp,
                                                  )),
                                                ),
                                                SizedBox(height: 5.h),
                                                Container(
                                                  height: 5.h,
                                                  width: 50.w,
                                                  color: customGreenColor,
                                                ),
                                                Container(
                                                  height: 40.h,
                                                  width: 40.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              customGreenColor),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.check,
                                                      size: 22.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Container(
                                                  height: 5.h,
                                                  width: 50.w,
                                                  color: customGreenColor,
                                                ),
                                                Container(
                                                  height: 40.h,
                                                  width: 40.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              customOrangeColor),
                                                  child: Center(
                                                    child: Text('03',
                                                        style: state
                                                            .numberTextStyle!),
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Container(
                                                  height: 5.h,
                                                  width: 50.w,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  height: 40.h,
                                                  width: 40.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white),
                                                  child: Center(
                                                    child: Text(
                                                      '04',
                                                      style: state
                                                          .numberTextStyle!
                                                          .copyWith(
                                                              color:
                                                                  customTextGreyColor),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                              ],
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     const Text('\$350.00',
                                            //         style: TextStyle(
                                            //           color: Colors.white,
                                            //           fontSize: 22,
                                            //         )),
                                            //     CircleAvatar(
                                            //       radius: 20.r,
                                            //       backgroundColor: Colors.white,
                                            //       child: Center(
                                            //           child: SvgPicture.asset(
                                            //         'assets/Icons/add.svg',
                                            //         height: 20.h,
                                            //         width: 20.w,
                                            //         color: customOrangeColor,
                                            //         fit: BoxFit.cover,
                                            //       )),
                                            //     ),
                                            //   ],
                                            // ),
                                            /// status text
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10.w, 8.h, 15.w, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'General Info',
                                                    style: state.descTextStyle,
                                                  ),
                                                  Text(
                                                    'Educational Info',
                                                    style: state.descTextStyle,
                                                  ),
                                                  Text(
                                                    'Skill Info',
                                                    style: state.descTextStyle,
                                                  ),
                                                  Text(
                                                    'Schedule',
                                                    style: state.descTextStyle,
                                                  )
                                                ],
                                              ),
                                            )
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
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: customTextFieldColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0))),
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 25.h),

                          /// Institute field
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0.0, 16.w, 16.h),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      //  labelStyle: textStyle,
                                      errorStyle: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: customLightThemeColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent))),
                                  //   isEmpty: _currentGenderValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      icon: SvgPicture.asset(
                                          'assets/Icons/dropdownIcon.svg'),
                                      hint: Text('Department',
                                          style: TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.regular,
                                              fontSize: 16.sp,
                                              color: customTextGreyColor)),
                                      value: _currentGenderValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _currentGenderValue = newValue;
                                          state.didChange(newValue);
                                        });
                                      },
                                      items: _gender.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          /// Category field
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0.0, 16.w, 16.h),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      //  labelStyle: textStyle,
                                      errorStyle: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: customLightThemeColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent))),
                                  //   isEmpty: _currentGenderValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      icon: SvgPicture.asset(
                                          'assets/Icons/dropdownIcon.svg'),
                                      hint: Text('Category',
                                          style: TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.regular,
                                              fontSize: 16.sp,
                                              color: customTextGreyColor)),
                                      value: _currentGenderValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _currentGenderValue = newValue;
                                          state.didChange(newValue);
                                        });
                                      },
                                      items: _gender.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 25.h),

                          /// Button
                          Container(
                              height: 40.h,
                              width: 165.w,
                              decoration: BoxDecoration(
                                  color: customLightThemeColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r))),
                              child: Center(
                                child: Text(
                                  '+Add Skills',
                                  style: state.numberTextStyle,
                                ),
                              )),

                          /// Education detail Container
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 25.h, 16.w, 16.h),
                            child: Container(
                              // height: 172.h,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.w, 20.h, 18.w, 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Degree',
                                            style:
                                                state.educationHeadingTextStyle,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Subject',
                                            style:
                                                state.educationHeadingTextStyle,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                            'assets/Icons/trashIcon.svg')
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'BS CS',
                                            style: state
                                                .educationSubHeadingTextStyle,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Computer Science',
                                            style: state
                                                .educationSubHeadingTextStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0.h,
                      left: 15.w,
                      right: 15.w,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 45.h),
                        child: InkWell(
                            onTap: () {
                              Get.toNamed(PageRoutes.scheduleInfoScreen);
                            },
                            child: const MyCustomBottomBar(
                                title: 'Next Step', disable: false)),
                      ),
                    ),
                  ]),
                )),
          ),
        );
      });
    });
  }
}
