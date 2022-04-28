
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/wallet/logic.dart';
import 'package:consultant_product/src/modules/wallet/repo_post.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

GlobalKey<FormState> withdrawAmountFormKey = GlobalKey();
customDialogForWithdrawAmount(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: withdrawAmountFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 3,
                            blurRadius: 9,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'withdraw_request'.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          15, 15, 15, 15),
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: SarabunFontFamily.regular,
                            fontSize: 16.sp,
                            color: Colors.black),
                        controller:
                        Get.find<WalletLogic>().withdrawAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              25.w, 15.h, 25.w, 15.h),
                          hintText: 'add_amount'.tr,
                          hintStyle: TextStyle(
                              fontFamily: SarabunFontFamily.regular,
                              fontSize: 16.sp,
                              color: customTextGreyColor),
                          fillColor: customTextFieldColor,
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
                          } else if (int.parse(Get.find<WalletLogic>()
                              .withdrawAmountController
                              .text
                              .toString()) >
                              int.parse(Get.find<WalletLogic>()
                                  .getWalletBalanceModel
                                  .data!
                                  .userBalance!)) {
                            return 'you_do_not_have_sufficient_balance'.tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'cancel'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: customThemeColor),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (withdrawAmountFormKey.currentState!
                                  .validate()) {
                                Navigator.pop(context);
                                Get.find<GeneralController>()
                                    .updateFormLoaderController(true);
                                postMethod(
                                    context,
                                    walletWithdrawUrl,
                                    {
                                      'token': '123',
                                      'user_id': Get.find<GeneralController>()
                                          .storageBox
                                          .read('userID'),
                                      'amount': Get.find<WalletLogic>()
                                          .withdrawAmountController
                                          .text
                                    },
                                    true,
                                    withdrawTransactionRepo);
                              }
                            },
                            child: Text(
                              'submit'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: customThemeColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}