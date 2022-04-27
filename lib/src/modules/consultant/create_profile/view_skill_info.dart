import 'dart:developer';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/get_repo.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/model_post_skill_info.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/repo_delete.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/repo_post.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class SkillInfoView extends StatefulWidget {
  const SkillInfoView({Key? key}) : super(key: key);

  @override
  _SkillInfoViewState createState() => _SkillInfoViewState();
}

class _SkillInfoViewState extends State<SkillInfoView> {
  final state = Get.find<CreateProfileLogic>().state;

  final GlobalKey<FormState> _skillInfoFormKey = GlobalKey();

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
                key: _skillInfoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///---category
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.w, 25.h, 15.w, 16.h),
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
                              LanguageConstant.department.tr.capitalizeFirst!,
                              style: state.hintTextStyle,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 14.h, 15.w, 14.h),
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
                            isExpanded: true,
                            focusColor: Colors.white,
                            style: state.textFieldTextStyle,
                            iconEnabledColor: customThemeColor,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 25,
                            value: _createProfileLogic.selectedCategory,
                            items: _createProfileLogic.categoryDropDownList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: state.textFieldTextStyle,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              _createProfileLogic
                                  .emptySelectedSubCategoriesIDList();
                              _createProfileLogic.emptyAllSubCategoriesList();
                              _createProfileLogic
                                  .emptyAllSubCategoriesForDropDownList();
                              _createProfileLogic
                                  .emptySelectedSubCategoriesList();
                              log(value.toString());
                              setState(() {
                                _createProfileLogic.selectedCategory = value;
                                _createProfileLogic
                                    .updateSelectedSubCategoriesList(value!);
                                _createProfileLogic
                                    .updateSelectedSubCategoriesIDList(
                                        _createProfileLogic
                                            .getParentCategoriesModel
                                            .data!
                                            .mentorCategories![
                                                _createProfileLogic
                                                    .categoryDropDownList
                                                    .indexOf(value)]
                                            .id!);
                              });
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              getMethod(
                                  context,
                                  mentorChildCategoryDataUrl,
                                  {
                                    'token': '123',
                                    'parent_id': _createProfileLogic
                                        .getParentCategoriesModel
                                        .data!
                                        .mentorCategories![_createProfileLogic
                                            .categoryDropDownList
                                            .indexOf(_createProfileLogic
                                                .selectedCategory!)]
                                        .id
                                  },
                                  false,
                                  getChildCategoryRepo);
                            },
                            validator: (String? value) {
                              if (value == null) {
                                return LanguageConstant.fieldRequired.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    ///---sub-category
                    Wrap(
                      children: List.generate(
                          _createProfileLogic
                              .allSubCategoriesForDropDownList.length,
                          (index) => SubCategoryDropDown(
                                selectedIndex: index,
                                selectedValue: '',
                                dropDownList: _createProfileLogic
                                    .allSubCategoriesForDropDownList[index],
                                onSelectionTap: (String? newValue) {
                                  if (_createProfileLogic
                                              .allSubCategoriesForDropDownList
                                              .length -
                                          1 >
                                      index) {
                                    ///--------------------------------------
                                    _createProfileLogic
                                        .allSubCategoriesForDropDownList
                                        .removeAt(_createProfileLogic
                                                .allSubCategoriesForDropDownList
                                                .length -
                                            1);
                                    for (int i = _createProfileLogic
                                                .allSubCategoriesForDropDownList
                                                .length -
                                            1;
                                        i > index;
                                        i--) {
                                      _createProfileLogic
                                          .allSubCategoriesForDropDownList
                                          .removeAt(i);
                                      setState(() {});
                                    }

                                    ///--------------------------------------
                                    for (int i = _createProfileLogic
                                                .allSubCategoriesList.length -
                                            1;
                                        i > index;
                                        i--) {
                                      _createProfileLogic.allSubCategoriesList
                                          .removeAt(i);
                                      setState(() {});
                                    }

                                    ///--------------------------------------
                                    for (int i = _createProfileLogic
                                                .selectedSubCategoriesList
                                                .length -
                                            1;
                                        i > index;
                                        i--) {
                                      _createProfileLogic
                                          .selectedSubCategoriesList
                                          .removeAt(i);
                                      _createProfileLogic
                                          .selectedSubCategoriesIDList
                                          .removeAt(i);
                                      setState(() {});
                                    }
                                    _createProfileLogic
                                        .updateSelectedSubCategoriesList(
                                            newValue!);
                                    _createProfileLogic.updateSelectedSubCategoriesIDList(
                                        _createProfileLogic
                                            .allSubCategoriesList[index]
                                            .data!
                                            .mentorCategories![_createProfileLogic
                                                .allSubCategoriesForDropDownList[
                                                    index]
                                                .indexOf(_createProfileLogic
                                                        .selectedSubCategoriesList[
                                                    _createProfileLogic
                                                            .selectedSubCategoriesList
                                                            .length -
                                                        1])]
                                            .id!);
                                    log('----01-->>$index');
                                    log('----02-->>${_createProfileLogic.allSubCategoriesList.length}');
                                    log('----03-->>${_createProfileLogic.selectedSubCategoriesList}');
                                    log('----04-->>${_createProfileLogic.selectedSubCategoriesList.indexOf(_createProfileLogic.selectedSubCategoriesList[_createProfileLogic.selectedSubCategoriesList.length - 1])}');
                                    log('----child-ID-->>${_createProfileLogic.allSubCategoriesList[index].data!.mentorCategories![_createProfileLogic.allSubCategoriesForDropDownList[index].indexOf(_createProfileLogic.selectedSubCategoriesList[_createProfileLogic.selectedSubCategoriesList.length - 1])].id}');

                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    getMethod(
                                        context,
                                        mentorChildCategoryDataUrl,
                                        {
                                          'token': '123',
                                          'parent_id': _createProfileLogic
                                              .allSubCategoriesList[index]
                                              .data!
                                              .mentorCategories![_createProfileLogic
                                                  .allSubCategoriesForDropDownList[
                                                      index]
                                                  .indexOf(_createProfileLogic
                                                          .selectedSubCategoriesList[
                                                      _createProfileLogic
                                                              .selectedSubCategoriesList
                                                              .length -
                                                          1])]
                                              .id,
                                        },
                                        false,
                                        getChildCategoryRepo);
                                  }

                                  if (_createProfileLogic
                                      .getChildCategoriesModel
                                      .data!
                                      .mentorCategories!
                                      .isNotEmpty) {
                                    _createProfileLogic
                                        .updateSelectedSubCategoriesList(
                                            newValue!);
                                    _createProfileLogic.updateSelectedSubCategoriesIDList(
                                        _createProfileLogic
                                            .allSubCategoriesList[index]
                                            .data!
                                            .mentorCategories![_createProfileLogic
                                                .allSubCategoriesForDropDownList[
                                                    index]
                                                .indexOf(_createProfileLogic
                                                        .selectedSubCategoriesList[
                                                    _createProfileLogic
                                                            .selectedSubCategoriesList
                                                            .length -
                                                        1])]
                                            .id!);
                                    log('----01-->>$index');
                                    log('----02-->>${_createProfileLogic.allSubCategoriesList.length}');
                                    log('----03-->>${_createProfileLogic.selectedSubCategoriesList}');
                                    log('----04-->>${_createProfileLogic.selectedSubCategoriesList.indexOf(_createProfileLogic.selectedSubCategoriesList[_createProfileLogic.selectedSubCategoriesList.length - 1])}');
                                    log('----child-ID-->>${_createProfileLogic.allSubCategoriesList[index].data!.mentorCategories![_createProfileLogic.allSubCategoriesForDropDownList[index].indexOf(_createProfileLogic.selectedSubCategoriesList[_createProfileLogic.selectedSubCategoriesList.length - 1])].id}');

                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    getMethod(
                                        context,
                                        mentorChildCategoryDataUrl,
                                        {
                                          'token': '123',
                                          'parent_id': _createProfileLogic
                                              .allSubCategoriesList[index]
                                              .data!
                                              .mentorCategories![_createProfileLogic
                                                  .allSubCategoriesForDropDownList[
                                                      index]
                                                  .indexOf(_createProfileLogic
                                                          .selectedSubCategoriesList[
                                                      _createProfileLogic
                                                              .selectedSubCategoriesList
                                                              .length -
                                                          1])]
                                              .id,
                                        },
                                        false,
                                        getChildCategoryRepo);
                                  }
                                },
                              )),
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
                            log('IDS-------->>${_createProfileLogic.selectedSubCategoriesIDList}');
                            if (_createProfileLogic.getChildCategoriesModel
                                .data!.mentorCategories!.isEmpty) {
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              postMethod(
                                  context,
                                  mentorSkillInfoUrl,
                                  {
                                    'token': '123',
                                    'mentor_id': Get.find<GeneralController>()
                                        .storageBox
                                        .read('userID'),
                                    'categories': _createProfileLogic
                                        .selectedSubCategoriesIDList
                                  },
                                  true,
                                  mentorSkillInfoRepo);
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: LanguageConstant.failed.tr,
                                      titleColor: customDialogErrorColor,
                                      descriptions:
                                          '${LanguageConstant.selectCategoryPlease.tr}!',
                                      text: LanguageConstant.ok.tr,
                                      functionCall: () {
                                        Navigator.pop(context);
                                      },
                                      img: 'assets/dialog_error.svg',
                                    );
                                  });
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
                                _createProfileLogic.skillInfoPostModel.data ==
                                        null
                                    ? LanguageConstant.addSkill.tr
                                    : LanguageConstant.update.tr,
                                style: state.addButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///---added-record-preview
                    _createProfileLogic.skillInfoPostModel.data == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 28, 15, 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 15, 7, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                _createProfileLogic
                                                    .skillInfoPostModel
                                                    .data!
                                                    .category!
                                                    .length,
                                                (index) => Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0 +
                                                          (index.toDouble() *
                                                              5),
                                                      6,
                                                      0,
                                                      0),
                                                  child: Text(
                                                    '${index + 1}-> ${_createProfileLogic.skillInfoPostModel.data!.category![index].name}',
                                                    style: state
                                                        .previewLabelTextStyle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _generalController
                                                  .updateFormLoaderController(
                                                      true);
                                              postMethod(
                                                  context,
                                                  mentorSkillInfoDeleteUrl,
                                                  {
                                                    'token': '123',
                                                    'mentor_id': Get.find<
                                                            GeneralController>()
                                                        .storageBox
                                                        .read('userID')
                                                  },
                                                  true,
                                                  deleteEducationRepo);
                                              _createProfileLogic
                                                      .skillInfoPostModel =
                                                  SkillInfoPostModel();
                                              setState(() {});
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .all(8.0),
                                              child: SvgPicture.asset(
                                                  'assets/Icons/deleteIcon.svg'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ))),
                  ],
                ),
              )),
              bottomNavigationBar: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                child: InkWell(
                    onTap: () {
                      if (_createProfileLogic.skillInfoPostModel.data != null) {
                        setState(() {
                          _createProfileLogic
                              .stepperList[_createProfileLogic.stepperIndex!]
                              .isSelected = false;
                          _createProfileLogic
                              .stepperList[_createProfileLogic.stepperIndex!]
                              .isCompleted = true;
                          _createProfileLogic
                              .stepperList[
                                  _createProfileLogic.stepperIndex! + 1]
                              .isSelected = true;
                          _createProfileLogic.updateStepperIndex(4);
                        });
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: LanguageConstant.failed.tr,
                                titleColor: customDialogErrorColor,
                                descriptions:
                                    LanguageConstant.addSkillPlease.tr,
                                text: LanguageConstant.ok.tr,
                                functionCall: () {
                                  Navigator.pop(context);
                                },
                                img: 'assets/dialog_error.svg',
                              );
                            });
                      }
                    },
                    child: MyCustomBottomBar(
                        title: LanguageConstant.nextStep.tr, disable: false)),
              )),
        ),
      ),
    );
  }
}

class SubCategoryDropDown extends StatefulWidget {
  const SubCategoryDropDown(
      {Key? key,
      required this.selectedIndex,
      required this.selectedValue,
      required this.dropDownList,
      required this.onSelectionTap})
      : super(key: key);

  final int? selectedIndex;
  final String? selectedValue;
  final List<String>? dropDownList;
  final Function? onSelectionTap;

  @override
  _SubCategoryDropDownState createState() => _SubCategoryDropDownState();
}

class _SubCategoryDropDownState extends State<SubCategoryDropDown> {
  final state = Get.find<CreateProfileLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 16.h),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            hint: Text(
              LanguageConstant.category.tr.capitalizeFirst!,
              style: state.hintTextStyle,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsetsDirectional.fromSTEB(15.w, 14.h, 15.w, 14.h),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: customLightThemeColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Colors.red)),
            ),
            isExpanded: true,
            focusColor: Colors.white,
            style: state.textFieldTextStyle,
            iconEnabledColor: customThemeColor,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 25,
            items: widget.dropDownList!
                .map<DropdownMenuItem<String>>((String value) {
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
                widget.onSelectionTap!(value);
              });
            },
            validator: (String? value) {
              if (value == null) {
                return LanguageConstant.fieldRequired.tr;
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }
}
