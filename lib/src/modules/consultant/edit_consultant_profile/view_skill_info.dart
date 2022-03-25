import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/repo_get.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/model_post_skill_info.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/repo_delete.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/repo_post.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
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
  final state = Get.find<EditConsultantProfileLogic>().state;

  final GlobalKey<FormState> _skillInfoFormKey = GlobalKey();

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
                              'department'.tr.capitalizeFirst!,
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
                            value: _editConsultantProfileLogic.selectedCategory,
                            items: _editConsultantProfileLogic.categoryDropDownList
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
                              _editConsultantProfileLogic
                                  .emptySelectedSubCategoriesIDList();
                              _editConsultantProfileLogic.emptyAllSubCategoriesList();
                              _editConsultantProfileLogic
                                  .emptyAllSubCategoriesForDropDownList();
                              _editConsultantProfileLogic
                                  .emptySelectedSubCategoriesList();
                              log(value.toString());
                              setState(() {
                                _editConsultantProfileLogic.selectedCategory = value;
                                _editConsultantProfileLogic
                                    .updateSelectedSubCategoriesList(value!);
                                _editConsultantProfileLogic
                                    .updateSelectedSubCategoriesIDList(
                                        _editConsultantProfileLogic
                                            .getParentCategoriesModel
                                            .data!
                                            .mentorCategories![
                                                _editConsultantProfileLogic
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
                                    'parent_id': _editConsultantProfileLogic
                                        .getParentCategoriesModel
                                        .data!
                                        .mentorCategories![_editConsultantProfileLogic
                                            .categoryDropDownList
                                            .indexOf(_editConsultantProfileLogic
                                                .selectedCategory!)]
                                        .id
                                  },
                                  false,
                                  getChildCategoryRepo);
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

                    ///---sub-category
                    Wrap(
                      children: List.generate(
                          _editConsultantProfileLogic
                              .allSubCategoriesForDropDownList.length,
                          (index) => SubCategoryDropDown(
                                selectedIndex: index,
                                selectedValue: '',
                                dropDownList: _editConsultantProfileLogic
                                    .allSubCategoriesForDropDownList[index],
                                onSelectionTap: (String? newValue) {
                                  if (_editConsultantProfileLogic
                                              .allSubCategoriesForDropDownList
                                              .length -
                                          1 >
                                      index) {
                                    ///--------------------------------------
                                    _editConsultantProfileLogic
                                        .allSubCategoriesForDropDownList
                                        .removeAt(_editConsultantProfileLogic
                                                .allSubCategoriesForDropDownList
                                                .length -
                                            1);
                                    for (int i = _editConsultantProfileLogic
                                                .allSubCategoriesForDropDownList
                                                .length -
                                            1;
                                        i > index;
                                        i--) {
                                      _editConsultantProfileLogic
                                          .allSubCategoriesForDropDownList
                                          .removeAt(i);
                                      setState(() {});
                                    }

                                    ///--------------------------------------
                                    for (int i = _editConsultantProfileLogic
                                                .allSubCategoriesList.length -
                                            1;
                                        i > index;
                                        i--) {
                                      _editConsultantProfileLogic.allSubCategoriesList
                                          .removeAt(i);
                                      setState(() {});
                                    }

                                    ///--------------------------------------
                                    for (int i = _editConsultantProfileLogic
                                                .selectedSubCategoriesList
                                                .length -
                                            1;
                                        i > index;
                                        i--) {
                                      _editConsultantProfileLogic
                                          .selectedSubCategoriesList
                                          .removeAt(i);
                                      _editConsultantProfileLogic
                                          .selectedSubCategoriesIDList
                                          .removeAt(i);
                                      setState(() {});
                                    }
                                    _editConsultantProfileLogic
                                        .updateSelectedSubCategoriesList(
                                            newValue!);
                                    _editConsultantProfileLogic.updateSelectedSubCategoriesIDList(
                                        _editConsultantProfileLogic
                                            .allSubCategoriesList[index]
                                            .data!
                                            .mentorCategories![_editConsultantProfileLogic
                                                .allSubCategoriesForDropDownList[
                                                    index]
                                                .indexOf(_editConsultantProfileLogic
                                                        .selectedSubCategoriesList[
                                                    _editConsultantProfileLogic
                                                            .selectedSubCategoriesList
                                                            .length -
                                                        1])]
                                            .id!);
                                    log('----01-->>$index');
                                    log('----02-->>${_editConsultantProfileLogic.allSubCategoriesList.length}');
                                    log('----03-->>${_editConsultantProfileLogic.selectedSubCategoriesList}');
                                    log('----04-->>${_editConsultantProfileLogic.selectedSubCategoriesList.indexOf(_editConsultantProfileLogic.selectedSubCategoriesList[_editConsultantProfileLogic.selectedSubCategoriesList.length - 1])}');
                                    log('----child-ID-->>${_editConsultantProfileLogic.allSubCategoriesList[index].data!.mentorCategories![_editConsultantProfileLogic.allSubCategoriesForDropDownList[index].indexOf(_editConsultantProfileLogic.selectedSubCategoriesList[_editConsultantProfileLogic.selectedSubCategoriesList.length - 1])].id}');

                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    getMethod(
                                        context,
                                        mentorChildCategoryDataUrl,
                                        {
                                          'token': '123',
                                          'parent_id': _editConsultantProfileLogic
                                              .allSubCategoriesList[index]
                                              .data!
                                              .mentorCategories![_editConsultantProfileLogic
                                                  .allSubCategoriesForDropDownList[
                                                      index]
                                                  .indexOf(_editConsultantProfileLogic
                                                          .selectedSubCategoriesList[
                                                      _editConsultantProfileLogic
                                                              .selectedSubCategoriesList
                                                              .length -
                                                          1])]
                                              .id,
                                        },
                                        false,
                                        getChildCategoryRepo);
                                  }

                                  if (_editConsultantProfileLogic
                                      .getChildCategoriesModel
                                      .data!
                                      .mentorCategories!
                                      .isNotEmpty) {
                                    _editConsultantProfileLogic
                                        .updateSelectedSubCategoriesList(
                                            newValue!);
                                    _editConsultantProfileLogic.updateSelectedSubCategoriesIDList(
                                        _editConsultantProfileLogic
                                            .allSubCategoriesList[index]
                                            .data!
                                            .mentorCategories![_editConsultantProfileLogic
                                                .allSubCategoriesForDropDownList[
                                                    index]
                                                .indexOf(_editConsultantProfileLogic
                                                        .selectedSubCategoriesList[
                                                    _editConsultantProfileLogic
                                                            .selectedSubCategoriesList
                                                            .length -
                                                        1])]
                                            .id!);
                                    log('----01-->>$index');
                                    log('----02-->>${_editConsultantProfileLogic.allSubCategoriesList.length}');
                                    log('----03-->>${_editConsultantProfileLogic.selectedSubCategoriesList}');
                                    log('----04-->>${_editConsultantProfileLogic.selectedSubCategoriesList.indexOf(_editConsultantProfileLogic.selectedSubCategoriesList[_editConsultantProfileLogic.selectedSubCategoriesList.length - 1])}');
                                    log('----child-ID-->>${_editConsultantProfileLogic.allSubCategoriesList[index].data!.mentorCategories![_editConsultantProfileLogic.allSubCategoriesForDropDownList[index].indexOf(_editConsultantProfileLogic.selectedSubCategoriesList[_editConsultantProfileLogic.selectedSubCategoriesList.length - 1])].id}');

                                    Get.find<GeneralController>()
                                        .updateFormLoaderController(true);
                                    getMethod(
                                        context,
                                        mentorChildCategoryDataUrl,
                                        {
                                          'token': '123',
                                          'parent_id': _editConsultantProfileLogic
                                              .allSubCategoriesList[index]
                                              .data!
                                              .mentorCategories![_editConsultantProfileLogic
                                                  .allSubCategoriesForDropDownList[
                                                      index]
                                                  .indexOf(_editConsultantProfileLogic
                                                          .selectedSubCategoriesList[
                                                      _editConsultantProfileLogic
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
                            log('IDS-------->>${_editConsultantProfileLogic.selectedSubCategoriesIDList}');
                            if (_editConsultantProfileLogic.getChildCategoriesModel
                                .data!.mentorCategories!.isEmpty) {
                              _editConsultantProfileLogic.forDisplaySkillList = [];
                              _editConsultantProfileLogic.update();
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
                                    'categories': _editConsultantProfileLogic
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
                                      title: 'failed!'.tr,
                                      titleColor: customDialogErrorColor,
                                      descriptions:
                                          '${'Select Category Please'.tr}!',
                                      text: 'ok'.tr,
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
                                _editConsultantProfileLogic.skillInfoPostModel.data ==
                                        null
                                    ? 'add_skill'.tr
                                    : 'update'.tr,
                                style: state.addButtonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///---added-record-preview
                    _editConsultantProfileLogic.skillInfoPostModel.data == null
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
                                                _editConsultantProfileLogic
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
                                                    '${index + 1}-> ${_editConsultantProfileLogic.skillInfoPostModel.data!.category![index].name}',
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
                                              _editConsultantProfileLogic
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
                    _editConsultantProfileLogic.forDisplaySkillList!.isEmpty
                        ? const SizedBox()
                        : Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(15, 28, 15, 20),
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
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: List.generate(_editConsultantProfileLogic
                                              .forDisplaySkillList!.length, (index) =>
                                              Padding(
                                                padding:  EdgeInsets.fromLTRB(0+(index.toDouble()*5), 6, 0, 0),
                                                child: Text(
                                                  '${index+1}-> ${_editConsultantProfileLogic
                                                      .forDisplaySkillList![index].category!.name}',
                                                  style: state
                                                      .previewLabelTextStyle,
                                                ),
                                              ),),
                                        ),
                                      ),

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
                      if (_editConsultantProfileLogic.skillInfoPostModel.data != null) {
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
                          _editConsultantProfileLogic.updateStepperIndex(4);
                        });
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: 'failed!'.tr,
                                titleColor: customDialogErrorColor,
                                descriptions: 'add_skill_please'.tr,
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
                        title: 'Next Step', disable: false)),
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
  final state = Get.find<EditConsultantProfileLogic>().state;

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
              'category'.tr.capitalizeFirst!,
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
                return 'field_required'.tr;
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
