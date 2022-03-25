
import 'dart:developer';

import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/model_generic_data.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/model_get_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getGenericDataRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<EditConsultantProfileLogic>().mentorProfileGenericDataModel =
        MentorProfileGenericDataModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>().mentorProfileGenericDataModel.status ==
        true) {
      ///---occupation
      Get.find<EditConsultantProfileLogic>().emptyOccupationDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>().mentorProfileGenericDataModel.data!.occupations!) {
        if(element.id == Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.occupation!){
          Get.find<EditConsultantProfileLogic>().selectedOccupation = element.name;
        }
        Get.find<EditConsultantProfileLogic>().updateOccupationDropDownList(element.name!);
      }
      ///---countries
      Get.find<EditConsultantProfileLogic>().emptyCountryDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>().mentorProfileGenericDataModel.data!.countries!) {
        if(element.id == Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.country!){
          Get.find<EditConsultantProfileLogic>().selectedCountry = element.name;
        }
        Get.find<EditConsultantProfileLogic>().updateCountryDropDownList(element.name!);
      }
      ///---degrees
      Get.find<EditConsultantProfileLogic>().emptyDegreeDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>().mentorProfileGenericDataModel.data!.degrees!) {
        Get.find<EditConsultantProfileLogic>().updateDegreeDropDownList(element.name!);
      }
      ///---banks
      Get.find<EditConsultantProfileLogic>().emptyBankDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>().mentorProfileGenericDataModel.data!.banks!) {
        Get.find<EditConsultantProfileLogic>().updateBankDropDownList(element.name!);
      }

      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getGenericDataRepo ------>> ${Get.find<EditConsultantProfileLogic>().mentorProfileGenericDataModel.success}');
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
    Get.find<EditConsultantProfileLogic>().citiesByIdModel =
        CitiesByIdModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>().citiesByIdModel.status ==
        true) {
      ///---cities
      Get.find<EditConsultantProfileLogic>().emptyCityDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>().citiesByIdModel.data!.cities!) {
        Get.find<EditConsultantProfileLogic>().updateCityDropDownList(element.name!);
      }

      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getCitiesRepo ------>> ${Get.find<EditConsultantProfileLogic>().citiesByIdModel.success}');
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
    Get.find<EditConsultantProfileLogic>().getParentCategoriesModel =
        GetCategoriesModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>().getParentCategoriesModel.status ==
        true) {
      ///---parent-category
      Get.find<EditConsultantProfileLogic>().emptyCategoryDropDownList();
      for (var element in Get.find<EditConsultantProfileLogic>().getParentCategoriesModel.data!.mentorCategories!) {
        Get.find<EditConsultantProfileLogic>().updateCategoryDropDownList(element.name!);
      }
      getMethod(
          context,
          mentorChildCategoryDataUrl,
          {
            'token': '123',
            'parent_id': Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.mentor!.categories![
            Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.mentor!.categories!.length-1
            ].id
          },
          false,
          getChildCategoryRepo);
      // Get.find<GeneralController>().updateFormLoaderController(false);
      log('getParentCategoryRepo ------>> ${Get.find<EditConsultantProfileLogic>().getParentCategoriesModel.success}');
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
    Get.find<EditConsultantProfileLogic>().getChildCategoriesModel =
        GetCategoriesModel.fromJson(response);
    if (Get.find<EditConsultantProfileLogic>().getChildCategoriesModel.status ==
        true) {
      ///---child-category
      // Get.find<EditConsultantProfileLogic>().emptySubCategoryDropDownList();
      // Get.find<EditConsultantProfileLogic>().getChildCategoriesModel.data!.mentorCategories!.forEach((element) {
      //   Get.find<EditConsultantProfileLogic>().updateSubCategoryDropDownList(element.name!);
      // });

      if(Get.find<EditConsultantProfileLogic>().getChildCategoriesModel.data!.mentorCategories!.isNotEmpty){
        List<String> tempList = [];
        for (var element in Get.find<EditConsultantProfileLogic>().getChildCategoriesModel.data!.mentorCategories!) {
          tempList.add(element.name!);
        }
        ///---get-all-child-category
        Get.find<EditConsultantProfileLogic>().updateAllSubCategoriesList(Get.find<EditConsultantProfileLogic>().getChildCategoriesModel);
        Get.find<EditConsultantProfileLogic>().updateAllSubCategoriesForDropDownList(tempList);
      }


      Get.find<GeneralController>().updateFormLoaderController(false);
      log('getChildCategoryRepo ------>> ${Get.find<EditConsultantProfileLogic>().getChildCategoriesModel.success}');
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);

    log('Exception........................');
  }
}