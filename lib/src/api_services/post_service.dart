import 'dart:developer';
import 'dart:io';
import 'package:consultant_product/src/api_services/header.dart';
import 'package:consultant_product/src/api_services/logic.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

postMethod(
    BuildContext context,
    String apiUrl,
    dynamic postData,
    bool addAuthHeader,
    Function executionMethod   // for performing functionalities
    ) async{

  dio_instance.Response response;
  dio_instance.Dio dio = dio_instance.Dio();

  // dio.options.connectTimeout = 10000;
  // dio.options.receiveTimeout = 6000;


  setAcceptHeader(dio);
  setContentHeader(dio);

  //-- if API need headers then this if works and it based on bool value come from function calling
  if(addAuthHeader && Get.find<ApiLogic>().storageBox.hasData('authToken')){
    setCustomHeader(dio, 'Authorization', 'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
  }else if(addAuthHeader && !Get.find<ApiLogic>().storageBox.hasData('authToken')){}

  if(apiUrl == fcmService){
    setCustomHeader(dio, 'Content-Type', 'application/json');
    setCustomHeader(dio, 'Authorization', 'key=AAAAzbp8oYc:APA91bFdJUSDhhvlyuryxb0Gg9wStY85gsqqQarJrR3Cx1bmL2mGewaR6TVcnlG_'
        '2IvK885eQF74ufNjVpR-pXMHjpZIWickj19CMTcit4pacdZ1MzVgbAWK_R6EmJTG4P4pMN8Dmwd7');

  }

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      log('Internet Connected');
      Get.find<ApiLogic>().changeInternetCheckerState(true);
      try{

        log('postData--->> $postData');
        response = await dio.post(apiUrl, data: postData);

        if(response.statusCode == 200){
          log('StatusCode------>> ${response.statusCode}');
          log('Response $apiUrl------>> ${response.data}');

          executionMethod(context,true, response.data);
        }else{

          executionMethod(context,false, {'status':null});
          log('StatusCode------>> ${response.statusCode}');
          log('Response $apiUrl------>> $response');
        }
      } on dio_instance.DioError catch (e){

        executionMethod(context,false,{'status':null});

        if(e.response != null){
          log('Dio Error From Get $apiUrl -->> ${e.response}');
        }else{
          log('Dio Error From Get $apiUrl -->> $e');
        }
      }
    }
  } on SocketException catch (_) {

    Get.find<GeneralController>().updateFormLoaderController(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'failed!'.tr,
            titleColor: customDialogErrorColor,
            descriptions: '${'internet_not_connected'.tr}!',
            text: 'ok'.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
    Get.find<ApiLogic>().changeInternetCheckerState(false);
    log('Internet Not Connected');
  }


}