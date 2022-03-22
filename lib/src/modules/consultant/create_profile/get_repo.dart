
import 'dart:developer';

import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/model_generic_data.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/model_get_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getGenericDataRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().mentorProfileGenericDataModel =
        MentorProfileGenericDataModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().mentorProfileGenericDataModel.status ==
        true) {
      ///---occupation
      Get.find<CreateProfileLogic>().emptyOccupationDropDownList();
      Get.find<CreateProfileLogic>().mentorProfileGenericDataModel.data!.occupations!.forEach((element) {
        Get.find<CreateProfileLogic>().updateOccupationDropDownList(element.name!);
      });
      ///---countries
      Get.find<CreateProfileLogic>().emptyCountryDropDownList();
      Get.find<CreateProfileLogic>().mentorProfileGenericDataModel.data!.countries!.forEach((element) {
        Get.find<CreateProfileLogic>().updateCountryDropDownList(element.name!);
      });
      ///---degrees
      Get.find<CreateProfileLogic>().emptyDegreeDropDownList();
      Get.find<CreateProfileLogic>().mentorProfileGenericDataModel.data!.degrees!.forEach((element) {
        Get.find<CreateProfileLogic>().updateDegreeDropDownList(element.name!);
      });
      ///---banks
      Get.find<CreateProfileLogic>().emptyBankDropDownList();
      Get.find<CreateProfileLogic>().mentorProfileGenericDataModel.data!.banks!.forEach((element) {
        Get.find<CreateProfileLogic>().updateBankDropDownList(element.name!);
      });

      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getGenericDataRepo ------>> ${Get.find<CreateProfileLogic>().mentorProfileGenericDataModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
getCitiesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().citiesByIdModel =
        CitiesByIdModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().citiesByIdModel.status ==
        true) {
      ///---cities
      Get.find<CreateProfileLogic>().emptyCityDropDownList();
      Get.find<CreateProfileLogic>().citiesByIdModel.data!.cities!.forEach((element) {
        Get.find<CreateProfileLogic>().updateCityDropDownList(element.name!);
      });

      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getCitiesRepo ------>> ${Get.find<CreateProfileLogic>().citiesByIdModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
getParentCategoryRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().getParentCategoriesModel =
        GetCategoriesModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().getParentCategoriesModel.status ==
        true) {
      ///---parent-category
      Get.find<CreateProfileLogic>().emptyCategoryDropDownList();
      Get.find<CreateProfileLogic>().getParentCategoriesModel.data!.mentorCategories!.forEach((element) {
        Get.find<CreateProfileLogic>().updateCategoryDropDownList(element.name!);
      });

      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getParentCategoryRepo ------>> ${Get.find<CreateProfileLogic>().getParentCategoriesModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}
getChildCategoryRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<CreateProfileLogic>().getChildCategoriesModel =
        GetCategoriesModel.fromJson(response);
    if (Get.find<CreateProfileLogic>().getChildCategoriesModel.status ==
        true) {
      ///---child-category
      // Get.find<CreateProfileLogic>().emptySubCategoryDropDownList();
      // Get.find<CreateProfileLogic>().getChildCategoriesModel.data!.mentorCategories!.forEach((element) {
      //   Get.find<CreateProfileLogic>().updateSubCategoryDropDownList(element.name!);
      // });

      if(Get.find<CreateProfileLogic>().getChildCategoriesModel.data!.mentorCategories!.isNotEmpty){
        List<String> tempList = [];
        Get.find<CreateProfileLogic>().getChildCategoriesModel.data!.mentorCategories!.forEach((element) {
          tempList.add(element.name!);
        });
        ///---get-all-child-category
        Get.find<CreateProfileLogic>().updateAllSubCategoriesList(Get.find<CreateProfileLogic>().getChildCategoriesModel);
        Get.find<CreateProfileLogic>().updateAllSubCategoriesForDropDownList(tempList);
      }


      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getChildCategoryRepo ------>> ${Get.find<CreateProfileLogic>().getChildCategoriesModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}