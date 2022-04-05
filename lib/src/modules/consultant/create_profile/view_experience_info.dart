import 'dart:io';

import 'package:consultant_product/src/api_services/header.dart';
import 'package:consultant_product/src/api_services/logic.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/model_post_experience_info.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/repo_delete.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:consultant_product/src/widgets/upload_image_button.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class ExperienceInfoView extends StatefulWidget {
  const ExperienceInfoView({Key? key}) : super(key: key);

  @override
  _ExperienceInfoViewState createState() => _ExperienceInfoViewState();
}

class _ExperienceInfoViewState extends State<ExperienceInfoView> {
  final state = Get.find<CreateProfileLogic>().state;

  final GlobalKey<FormState> _experienceInfoFormKey = GlobalKey();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyFromController = TextEditingController();
  final TextEditingController _companyToController = TextEditingController();

  File? experienceImage;
  List experienceImagesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      builder: (_generalController) => GetBuilder<CreateProfileLogic>(
        builder: (_createProfileLogic) => ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: customThemeColor,
          ),
          inAsyncCall: _generalController.formLoaderController!,
          child: Scaffold(
              backgroundColor: customTextFieldColor,
              body: SingleChildScrollView(
                  child: Form(
                    key: _experienceInfoFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///---company-field
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 25.h, 15.w, 16.h),
                          child: TextFormField(
                            style: state.textFieldTextStyle,
                            controller: _companyNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  25.w, 15.h, 25.w, 15.h),
                              hintText: 'company_name'.tr.capitalizeFirst,
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

                        ///---from-to
                        Row(
                          children: [
                            ///---from
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.w, 0, 8.w, 16.h),
                                child: Theme(
                                  data: ThemeData(
                                      colorScheme: ColorScheme.fromSwatch()
                                          .copyWith(
                                          primary: customThemeColor)),
                                  child: DateTimeField(
                                    controller: _companyFromController,
                                    style: state.textFieldTextStyle,
                                    decoration: InputDecoration(
                                        hintText: 'from'.tr.capitalizeFirst,
                                        hintStyle: state.hintTextStyle,
                                        contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 15.w, 15.h),
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
                                                color:
                                                customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: Colors.red)),
                                        suffixIcon: Padding(
                                          padding:
                                          const EdgeInsetsDirectional
                                              .all(15.0),
                                          child: SvgPicture.asset(
                                            'assets/Icons/calendarIcon.svg',
                                          ),
                                        )),
                                    initialValue: _createProfileLogic
                                        .selectedCompanyFromDate,
                                    format: DateFormat('dd-MM-yyyy'),
                                    onShowPicker:
                                        (context, currentValue) async {
                                      final date = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate: currentValue ??
                                              DateTime.now(),
                                          lastDate: DateTime.now());
                                      if (date != null) {
                                        return date;
                                      } else {
                                        return currentValue;
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'field_required'.tr;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _createProfileLogic
                                                .selectedCompanyFromDate =
                                            value;
                                      });
                                      log(value.toString());
                                    },
                                  ),
                                ),
                              ),
                            ),

                            ///---to
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.w, 0, 15.w, 16.h),
                                child: Theme(
                                  data: ThemeData(
                                      colorScheme: ColorScheme.fromSwatch()
                                          .copyWith(
                                          primary: customThemeColor)),
                                  child: DateTimeField(
                                    controller: _companyToController,
                                    style: state.textFieldTextStyle,
                                    decoration: InputDecoration(
                                        hintText: 'To'.tr.capitalizeFirst,
                                        hintStyle: state.hintTextStyle,
                                        contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 15.w, 15.h),
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
                                                color:
                                                customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: Colors.red)),
                                        suffixIcon: Padding(
                                          padding:
                                          const EdgeInsetsDirectional
                                              .all(15.0),
                                          child: SvgPicture.asset(
                                            'assets/Icons/calendarIcon.svg',
                                          ),
                                        )),
                                    initialValue: _createProfileLogic
                                        .selectedCompanyToDate,
                                    format: DateFormat('dd-MM-yyyy'),
                                    onShowPicker:
                                        (context, currentValue) async {
                                      final date = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate: currentValue ??
                                              DateTime.now(),
                                          lastDate: DateTime.now());
                                      if (date != null) {
                                        return date;
                                      } else {
                                        return currentValue;
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'field_required'.tr;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _createProfileLogic
                                            .selectedCompanyToDate = value;
                                      });
                                      log(value.toString());
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ///---picture
                        experienceImage == null
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
                                    experienceImage!,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),

                        ///---add-button
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (_experienceInfoFormKey.currentState!
                                    .validate()) {
                                  if (experienceImage != null) {
                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    _mentorExperienceInfoRepo(experienceImage);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            title: 'sorry!'.tr,
                                            titleColor: customDialogErrorColor,
                                            descriptions:
                                                'upload_your_experience_certificate'.tr,
                                            text: 'ok'.tr,
                                            functionCall: () {
                                              Navigator.pop(context);
                                            },
                                            img: 'assets/dialog_error.svg',
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
                                    '+${'add_experience'.tr}',
                                    style: state.addButtonTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        ///---added-record-preview
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(15, 28, 15, 20),
                            child: Wrap(
                              children: List.generate(
                                  _createProfileLogic.forDisplayExperienceList!
                                      .length, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            15, 15, 7, 15),
                                        child: Column(
                                          children: [
                                            ///---company-name
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
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'company'.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_createProfileLogic.forDisplayExperienceList![index].company}',
                                                        softWrap: true,
                                                        overflow:
                                                            TextOverflow.ellipsis,
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
                                                        mentorExperienceInfoDeleteUrl,
                                                        {
                                                          'token': '123',
                                                          'id': _createProfileLogic
                                                              .forDisplayExperienceList![
                                                                  index]
                                                              .id
                                                        },
                                                        true,
                                                        deleteEducationRepo);
                                                    _createProfileLogic
                                                        .forDisplayExperienceList!
                                                        .removeAt(index);
                                                    setState(() {});
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                        'assets/Icons/deleteIcon.svg'),
                                                  ),
                                                )
                                              ],
                                            ),

                                            const SizedBox(
                                              height: 14,
                                            ),

                                            ///---from-to
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
                                                        'from'.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_createProfileLogic.forDisplayExperienceList![index].from}',
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
                                                        'To'.tr,
                                                        style: state
                                                            .previewLabelTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '${_createProfileLogic.forDisplayExperienceList![index].to}',
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
                padding:  EdgeInsets.symmetric(horizontal: 15.w),
                child: InkWell(
                  onTap: () {
                    if (_createProfileLogic
                        .forDisplayExperienceList!.isNotEmpty) {
                      setState(() {
                        _createProfileLogic.stepperScrollController.animateTo(
                          _createProfileLogic
                              .stepperScrollController.position.maxScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                        _createProfileLogic
                            .stepperList[_createProfileLogic.stepperIndex!]
                            .isSelected = false;
                        _createProfileLogic
                            .stepperList[_createProfileLogic.stepperIndex!]
                            .isCompleted = true;
                        _createProfileLogic
                            .stepperList[_createProfileLogic.stepperIndex! + 1]
                            .isSelected = true;
                        _createProfileLogic.updateStepperIndex(3);
                      });
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: 'failed!'.tr,
                              titleColor: customDialogErrorColor,
                              descriptions: 'add_work_experience_please'.tr,
                              text: 'ok'.tr,
                              functionCall: () {
                                Navigator.pop(context);
                              },
                              img: 'assets/dialog_error.svg',
                            );
                          });
                    }
                  },
                    child: const MyCustomBottomBar(
                        title: 'Next Step', disable: false)
                ),
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
                      experienceImagesList = [];
                    });
                    experienceImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Camera,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,maxHeight: 600));
                    if (experienceImagesList != null) {
                      setState(() {
                        experienceImage = File(experienceImagesList[0].path);
                      });
                      log(experienceImagesList[0].path);
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
                      experienceImagesList = [];
                    });
                    experienceImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Gallery,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,maxHeight: 600));
                    if (experienceImagesList != null) {
                      setState(() {
                        experienceImage = File(experienceImagesList[0].path);
                      });
                      log(experienceImagesList[0].path);
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

  _mentorExperienceInfoRepo(File? file1) async {
    dio_instance.FormData formData =
        dio_instance.FormData.fromMap(<String, dynamic>{
      'token': '123',
      'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
      'company': _companyNameController.text,
      'from': DateFormat('yyyy-MM-dd')
          .format(Get.find<CreateProfileLogic>().selectedCompanyFromDate!)
          .toString(),
      'to': DateFormat('yyyy-MM-dd')
          .format(Get.find<CreateProfileLogic>().selectedCompanyToDate!)
          .toString(),
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

      response = await dio.post(mentorExperienceInfoUrl, data: formData);

      log('StatusCode------>> ${response.statusCode}');
      log('Response $mentorExperienceInfoUrl------>> ${response.data}');
      if (response.statusCode == 200) {
        Get.find<CreateProfileLogic>().experienceInfoPostModel =
            ExperienceInfoPostModel.fromJson(response.data);
        if (Get.find<CreateProfileLogic>().experienceInfoPostModel.status ==
            true) {
          Get.find<CreateProfileLogic>().updateForDisplayExperienceList(
              Get.find<CreateProfileLogic>()
                  .experienceInfoPostModel
                  .data!
                  .experience);
          Get.snackbar('${'added_successfully'.tr}!', '',
              colorText: Colors.black,
              backgroundColor: Colors.white);
          Get.find<GeneralController>().updateFormLoaderController(false);
          setState(() {
            _companyNameController.clear();
            _companyFromController.clear();
            _companyToController.clear();
            Get.find<CreateProfileLogic>().emptyDateFields();
            experienceImage = null;
          });
          log('mentorExperienceInfoRepo ------>> ${Get.find<CreateProfileLogic>().experienceInfoPostModel.success}');
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
                  img: 'assets/dialog_error.svg',
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
                img: 'assets/dialog_error.svg',
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
              img: 'assets/dialog_error.svg',
            );
          });
      log('ResponseError $mentorExperienceInfoUrl-->> ${e}');
    }
  }
}
