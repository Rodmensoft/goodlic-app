import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../../route_generator.dart';
import '../../../controller/general_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_bottom_bar.dart';
import 'logic.dart';

class GeneralInfoPage extends StatefulWidget {
  const GeneralInfoPage({Key? key}) : super(key: key);

  @override
  State<GeneralInfoPage> createState() => _GeneralInfoPageState();
}

class _GeneralInfoPageState extends State<GeneralInfoPage> {
  final logic = Get.put(GeneralInfoLogic());

  final state = Get.find<GeneralInfoLogic>().state;

  /// gender
  String? _currentGenderValue;
  final _gender = [
    "Male",
    "Female",
    "Others",
  ];

  /// religion
  String? _currentReligionValue;
  final _religion = [
    "Islam",
    "Others",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<GeneralInfoLogic>().scrollController = ScrollController()
      ..addListener(Get.find<GeneralInfoLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<GeneralInfoLogic>()
        .scrollController!
        .removeListener(Get.find<GeneralInfoLogic>().scrollListener);
    Get.find<GeneralInfoLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<GeneralInfoLogic>(builder: (_generalInfoLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: customThemeColor,
            body: NestedScrollView(
                controller: _generalInfoLogic.scrollController,
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
                        backgroundColor: _generalInfoLogic.isShrink
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
                                  'assets/Icons/whiteBackArrow.svg',
                              ),
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
                                      width: MediaQuery.of(context).size.width * .8,
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
                                                              customOrangeColor),
                                                  child: Center(
                                                    child: Text(
                                                      '01',
                                                      style:
                                                          state.numberTextStyle,
                                                    ),
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
                                                      '02',
                                                      style: state
                                                          .numberTextStyle!
                                                          .copyWith(
                                                              color:
                                                                  customTextGreyColor),
                                                    ),
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
                                                      '03',
                                                      style: state
                                                          .numberTextStyle!
                                                          .copyWith(
                                                              color:
                                                                  customTextGreyColor),
                                                    ),
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
                  child: Stack(
                    children:[  SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 25.h),
                          InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/upload.png',
                              height: 103.h,
                              width: 190.w,
                            ),
                          ),
                          // SizedBox(height: 20.h),
                          /// your name field
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 20.h, 16.w, 16.h),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z ]"))
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    25.w, 15.h, 25.w, 15.h),
                                hintText: 'Your Name',
                                hintStyle: state.hintTextStyle,
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: customLightThemeColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field is required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          /// father name field
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0.h, 16.w, 16.h),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z ]"))
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    25.w, 15.h, 25.w, 15.h),
                                hintText: 'Father Name',
                                hintStyle: state.hintTextStyle,
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: customLightThemeColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field is required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          /// enter CNIC field
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0.h, 16.w, 16.h),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    25.w, 15.h, 25.w, 15.h),
                                hintText: 'Enter CNIC',
                                hintStyle: state.hintTextStyle,
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: customLightThemeColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field is required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          /// Address field
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0.h, 16.w, 16.h),
                            child: TextFormField(
                              maxLines: 6,
                              minLines: 3,

                              keyboardType: TextInputType.text,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                              // ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    25.w, 15.h, 25.w, 15.h),
                                hintText: 'Enter Address',
                                hintStyle: state.hintTextStyle,
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: const BorderSide(
                                        color: customLightThemeColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field is required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          /// Dropdowns  ///
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0.h, 16.w, 16.h),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Dropdown gender field
                                  SizedBox(
                                    height: 65,
                                    width: 160,
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
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent))),
                                          //   isEmpty: _currentGenderValue == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              icon: SvgPicture.asset(
                                                  'assets/Icons/dropdownIcon.svg'),
                                              hint: Text('Gender',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          SarabunFontFamily
                                                              .regular,
                                                      fontSize: 16.sp,
                                                      color:
                                                          customTextGreyColor)),
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

                                  /// Dropdown Religion field
                                  SizedBox(
                                    height: 65,
                                    width: 160,
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              errorStyle: const TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16.0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent))),

                                          //   isEmpty: _currentReligionValue == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              icon: SvgPicture.asset(
                                                  'assets/Icons/dropdownIcon.svg'),
                                              hint: Text(
                                                'Religion',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.regular,
                                                    fontSize: 16.sp,
                                                    color: customTextGreyColor),
                                              ),
                                              value: _currentReligionValue,
                                              isDense: true,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _currentReligionValue =
                                                      newValue;
                                                  state.didChange(newValue);
                                                });
                                              },
                                              items:
                                                  _religion.map((String value) {
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
                                  )
                                ]),
                          ),

                          /// Dropdowns ///
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0.h, 16.w, 16.h),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Dropdown DOB field
                                  SizedBox(
                                    height: 65,
                                    width: 160,
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
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent))),
                                          //   isEmpty: _currentGenderValue == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              icon: SvgPicture.asset(
                                                  'assets/Icons/calendarIcon.svg'),
                                              hint: Text('DOB',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          SarabunFontFamily
                                                              .regular,
                                                      fontSize: 16.sp,
                                                      color:
                                                          customTextGreyColor)),
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

                                  /// Dropdown Occupation field
                                  SizedBox(
                                    height: 65,
                                    width: 160,
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              errorStyle: const TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16.0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Colors.transparent))),

                                          //   isEmpty: _currentReligionValue == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              icon: SvgPicture.asset(
                                                  'assets/Icons/dropdownIcon.svg'),
                                              hint: Text(
                                                'Occupation',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.regular,
                                                    fontSize: 16.sp,
                                                    color: customTextGreyColor),
                                              ),
                                              value: _currentReligionValue,
                                              isDense: true,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _currentReligionValue =
                                                      newValue;
                                                  state.didChange(newValue);
                                                });
                                              },
                                              items:
                                                  _religion.map((String value) {
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
                                  )
                                ]),
                          ),

                          /// Dropdowns ///
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.w, 0.h, 16.w, 16.h),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Dropdown Country field
                                  SizedBox(
                                    height: 65,
                                    width: 160,
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
                                                      color:
                                                      customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.r),
                                                  borderSide: const BorderSide(
                                                      color:
                                                      Colors.transparent))),
                                          //   isEmpty: _currentGenderValue == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              icon: SvgPicture.asset(
                                                  'assets/Icons/dropdownIcon.svg'),
                                              hint: Text('Country',
                                                  style: TextStyle(
                                                      fontFamily:
                                                      SarabunFontFamily
                                                          .regular,
                                                      fontSize: 16.sp,
                                                      color:
                                                      customTextGreyColor)),
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

                                  /// Dropdown City field
                                  SizedBox(
                                    height: 65,
                                    width: 160,
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              errorStyle: const TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16.0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                      customLightThemeColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                      Colors.transparent))),

                                          //   isEmpty: _currentReligionValue == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              icon: SvgPicture.asset(
                                                  'assets/Icons/dropdownIcon.svg'),
                                              hint: Text(
                                                'City',
                                                style: TextStyle(
                                                    fontFamily:
                                                    SarabunFontFamily.regular,
                                                    fontSize: 16.sp,
                                                    color: customTextGreyColor),
                                              ),
                                              value: _currentReligionValue,
                                              isDense: true,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _currentReligionValue =
                                                      newValue;
                                                  state.didChange(newValue);
                                                });
                                              },
                                              items:
                                              _religion.map((String value) {
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
                                  )
                                ]),
                          ),
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
                                Get.toNamed(PageRoutes.educationalInfoScreen);
                              },
                              child: const MyCustomBottomBar(
                                  title: 'Next Step', disable: false)),
                        ),
                      ),
            ]
                  ),
                )),
          ),
        );
      });
    });
  }
}
