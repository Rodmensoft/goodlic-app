import 'dart:developer';
import 'dart:io';
import 'package:consultant_product/src/api_services/header.dart';
import 'package:consultant_product/src/api_services/logic.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/model_post_education_info.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/repo_delete.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:consultant_product/src/widgets/upload_image_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class EducationalInfoView extends StatefulWidget {
  const EducationalInfoView({Key? key}) : super(key: key);

  @override
  _EducationalInfoViewState createState() => _EducationalInfoViewState();
}

class _EducationalInfoViewState extends State<EducationalInfoView> {
  final state = Get.find<EditConsultantProfileLogic>().state;

  final GlobalKey<FormState> _educationalInfoFormKey = GlobalKey();

  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  File? degreeImage;
  List degreeImagesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      builder: (_generalController) => GetBuilder<EditConsultantProfileLogic>(
        builder: (_editConsultantProfileLogic) => ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: customThemeColor,
          ),
          inAsyncCall: _generalController.formLoaderController!,
          child: Scaffold(
              backgroundColor: customTextFieldColor,
              body: SingleChildScrollView(
                  child: Form(
                    key: _educationalInfoFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///---institution-field
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 25.h, 15.w, 16.h),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z ]"))
                            ],
                            style: state.textFieldTextStyle,
                            controller: _institutionController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  25.w, 15.h, 25.w, 15.h),
                              hintText: 'Institute',
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
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'field_required'.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        ///---degree-subject
                        Row(
                          children: [
                            ///---degree
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 8.w, 16.h),
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField<String>(
                                      onTap: () {
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      },
                                      hint: Text(
                                        'Degree',
                                        style: state.hintTextStyle,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                15.w, 14.h, 15.w, 14.h),
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        border: OutlineInputBorder(
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
                                                BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                      ),
                                      isExpanded: true,
                                      focusColor: Colors.white,
                                      style: state.textFieldTextStyle,
                                      iconEnabledColor: customThemeColor,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      iconSize: 25,
                                      value: _editConsultantProfileLogic.selectedDegree,
                                      items: _editConsultantProfileLogic
                                          .degreeDropDownList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: state.textFieldTextStyle,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        log(value.toString());
                                        setState(() {
                                          _editConsultantProfileLogic.selectedDegree =
                                              value;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value == null) {
                                          return 'field_required'.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            ///---subject
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[a-z A-Z ]"))
                                  ],
                                  style: state.textFieldTextStyle,
                                  controller: _subjectController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: 'Subject',
                                    hintStyle: state.hintTextStyle,
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent)),
                                    border: OutlineInputBorder(
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
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Colors.red)),
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'field_required'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///---year
                        Row(
                          children: [
                            ///---year
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 15.w, 16.h),
                                child: TextFormField(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            // Need to use container to add size constraint.
                                            width: 300,
                                            height: 300,
                                            child: Theme(
                                              data: ThemeData(
                                                  colorScheme: ColorScheme
                                                      .fromSwatch()
                                                      .copyWith(
                                                      primary:
                                                      customThemeColor)),
                                              child: YearPicker(
                                                firstDate: DateTime(
                                                    DateTime.now().year - 50,
                                                    1),
                                                lastDate: DateTime(
                                                    DateTime.now().year, 1),

                                                // save the selected date to _selectedDate DateTime variable.
                                                // It's used to set the previous selected date when
                                                // re-showing the dialog.

                                                selectedDate: DateTime.now(),
                                                onChanged: (DateTime dateTime) {
                                                  setState(() {
                                                    _editConsultantProfileLogic
                                                        .selectedYear =
                                                        DateFormat('yyyy')
                                                            .format(dateTime);
                                                    log('YEAR--->>${_editConsultantProfileLogic.selectedYear}');
                                                    _yearController =
                                                        TextEditingController(
                                                            text: _editConsultantProfileLogic
                                                                .selectedYear);
                                                  });
                                                  // close the dialog when year is selected.
                                                  Navigator.pop(context);
                                                  // Do something with the dateTime selected.
                                                  // Remember that you need to use dateTime.year to get the year
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  readOnly: true,
                                  controller: _yearController,
                                  style: state.textFieldTextStyle,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                    hintText: 'Year',
                                    hintStyle: state.hintTextStyle,
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.all(
                                              15.0),
                                      child: SvgPicture.asset(
                                          'assets/Icons/calendarIcon.svg'),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent)),
                                    border: OutlineInputBorder(
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
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Colors.red)),
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'field_required'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),

                            const Spacer()
                          ],
                        ),

                        ///---picture
                        degreeImage == null
                            ? InkWell(
                                onTap: () {
                                  imagePickerDialog(context);
                                },
                                child: const UploadImageButton())
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25.h),
                                  child: SizedBox(
                                    height: 103.h,
                                    width: 190.w,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          degreeImage!,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ),

                        ///---add-button
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (_educationalInfoFormKey.currentState!
                                    .validate()) {
                                  if (degreeImage != null) {
                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    mentorEducationInfoRepo(degreeImage);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            title: 'sorry!'.tr,
                                            titleColor: customDialogErrorColor,
                                            descriptions:
                                                'upload_your_degree_picture'.tr,
                                            text: 'ok'.tr,
                                            functionCall: () {
                                              Navigator.pop(context);
                                            },
                                            img: 'assets/Icons/dialog_error.svg',
                                          );
                                        });
                                  }
                                }
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * .45,
                                decoration: BoxDecoration(
                                    color: customLightThemeColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    '+${'add_education'.tr}',
                                    style: state.addButtonTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        ///---added-record-preview
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 15, 15, 20),
                            child: Wrap(
                              children: List.generate(
                                  _editConsultantProfileLogic.forDisplayEducationList!
                                      .length, (index) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 15, 7, 15),
                                        child: Column(
                                          children: [
                                            ///---institution
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'institute'.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_editConsultantProfileLogic.forDisplayEducationList![index].institute}',
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: state
                                                            .previewValueTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      _generalController
                                                          .updateFormLoaderController(
                                                              true);
                                                      postMethod(
                                                          context,
                                                          mentorEducationalInfoDeleteUrl,
                                                          {
                                                            'token': '123',
                                                            'id': _editConsultantProfileLogic
                                                                .forDisplayEducationList![
                                                                    index]
                                                                .id
                                                          },
                                                          true,
                                                          deleteEducationRepo);
                                                      _editConsultantProfileLogic
                                                          .forDisplayEducationList!
                                                          .removeAt(index);
                                                      setState(() {});
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .all(8.0),
                                                      child: SvgPicture.asset(
                                                          'assets/Icons/deleteIcon.svg'),
                                                    ))
                                              ],
                                            ),

                                            const SizedBox(
                                              height: 14,
                                            ),

                                            ///---degree-subject
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'degree'.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_editConsultantProfileLogic.forDisplayEducationList![index].degree}',
                                                        style: state
                                                            .previewValueTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'subject'.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_editConsultantProfileLogic.forDisplayEducationList![index].subject}',
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: state
                                                            .previewValueTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            ),

                                            ///---degree-subject
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'year'.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_editConsultantProfileLogic.forDisplayEducationList![index].period}',
                                                        style: state
                                                            .previewValueTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer()
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              }),
                            )),
                      ],
                    ),
                  )),
              bottomNavigationBar: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                child: InkWell(
                    onTap: () {
                      if (_editConsultantProfileLogic
                          .forDisplayEducationList!.isNotEmpty) {
                        setState(() {
                          _editConsultantProfileLogic
                              .stepperList[_editConsultantProfileLogic.stepperIndex!]
                              .isSelected = false;
                          _editConsultantProfileLogic
                              .stepperList[_editConsultantProfileLogic.stepperIndex!]
                              .isCompleted = true;
                          _editConsultantProfileLogic
                              .stepperList[
                                  _editConsultantProfileLogic.stepperIndex! + 1]
                              .isSelected = true;
                          _editConsultantProfileLogic.updateStepperIndex(2);
                        });
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: 'failed!'.tr,
                                titleColor: customDialogErrorColor,
                                descriptions: 'add_education_please'.tr,
                                text: 'ok'.tr,
                                functionCall: () {
                                  Navigator.pop(context);
                                },
                                img: 'assets/Icons/dialog_error.svg',
                              );
                            });
                      }
                    },
                    child: const MyCustomBottomBar(
                        title: 'Next Step', disable: false)),
              )),
        ),
      ),
    );
  }

  void imagePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      degreeImagesList = [];
                    });
                    degreeImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Camera,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (degreeImagesList != null) {
                      setState(() {
                        degreeImage = File(degreeImagesList[0].path);
                      });
                      log(degreeImagesList[0].path);
                    }
                  },
                  child: Text(
                    "Camera",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      degreeImagesList = [];
                    });
                    degreeImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Gallery,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (degreeImagesList != null) {
                      setState(() {
                        degreeImage = File(degreeImagesList[0].path);
                      });
                      log(degreeImagesList[0].path);
                    }
                  },
                  child: Text(
                    "Gallery",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  )),
            ],
          );
        });
  }

  mentorEducationInfoRepo(File? file1) async {
    dio_instance.FormData formData =
        dio_instance.FormData.fromMap(<String, dynamic>{
      'token': '123',
      'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
      'institute': _institutionController.text,
      'degree': Get.find<EditConsultantProfileLogic>().selectedDegree,
      'subject': _subjectController.text,
      'period': _yearController.text,
      'image': await dio_instance.MultipartFile.fromFile(
        file1!.path,
      )
    });
    dio_instance.Dio dio = dio_instance.Dio();
    setCustomHeader(dio, 'Authorization',
        'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
    dio_instance.Response response;
    try {
      log('postData--->> ${formData.fields}');

      response = await dio.post(mentorEducationalInfoPostUrl, data: formData);

      log('StatusCode------>> ${response.statusCode}');
      log('Response $mentorEducationalInfoPostUrl------>> ${response.data}');
      if (response.statusCode == 200) {
        Get.find<EditConsultantProfileLogic>().educationInfoPostModel =
            EducationInfoPostModel.fromJson(response.data);
        if (Get.find<EditConsultantProfileLogic>().educationInfoPostModel.status ==
            true) {
          Get.find<EditConsultantProfileLogic>().updateForDisplayEducationList(
              Get.find<EditConsultantProfileLogic>()
                  .educationInfoPostModel
                  .data!
                  .education);
          Get.snackbar('${'added_successfully'.tr}!', '',
              colorText: Colors.black,
              backgroundColor: customThemeColor.withOpacity(0.5));

          Get.find<GeneralController>().updateFormLoaderController(false);
          setState(() {
            _institutionController.clear();
            _subjectController.clear();
            _yearController.clear();
            Get.find<EditConsultantProfileLogic>().selectedDegree = null;
            degreeImage = null;
          });
          log('mentorEducationInfoRepo ------>> ${Get.find<EditConsultantProfileLogic>().educationInfoPostModel.success}');
        } else {
          Get.find<GeneralController>().updateFormLoaderController(false);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: 'failed!'.tr,
                  titleColor: customDialogErrorColor,
                  descriptions: 'try_again!'.tr,
                  text: 'ok'.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_error.svg',
                );
              });
        }
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'failed!'.tr,
                titleColor: customDialogErrorColor,
                descriptions: 'try_again!'.tr,
                text: 'ok'.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
    } on dio_instance.DioError catch (e) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'failed!'.tr,
              titleColor: customDialogErrorColor,
              descriptions: 'try_again!'.tr,
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
      log('ResponseError $mentorEducationalInfoPostUrl-->> ${e}');
    }
  }
}