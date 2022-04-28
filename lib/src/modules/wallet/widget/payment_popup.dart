import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/modules/wallet/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

paymentBottomSheetForWallet(BuildContext context) async {
  return Get.bottomSheet(
    ///---payment-method-area
    GetBuilder<WalletLogic>(builder: (_walletLogic) {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: customTextBlackColor, width: 1)),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 25.h, 20.w, 7.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LanguageConstant.paymentMethod.tr,
                style: _walletLogic.state.headingTextStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              Wrap(
                children: List.generate(_walletLogic.paymentMethodList.length,
                    (index) {
                  return Padding(
                    padding: index % 2 == 0
                        ? EdgeInsetsDirectional.fromSTEB(0, 0, 8.w, 18.h)
                        : EdgeInsetsDirectional.fromSTEB(8.w, 0.h, 0.w, 18.h),
                    child: InkWell(
                      onTap: () {
                        _walletLogic.selectedPaymentType = index;
                        _walletLogic.update();
                        _walletLogic.amountController.clear();

                        Get.offNamed(PageRoutes.stripePaymentForWallet);
                      },
                      child: Container(
                        height: 61.h,
                        width: MediaQuery.of(context).size.width * .38,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: _walletLogic
                                        .paymentMethodList[index].isSelected!
                                    ? customLightThemeColor
                                    : Colors.white,
                                width: 2),
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: _walletLogic
                                        .paymentMethodList[index].isSelected!
                                    ? customLightThemeColor.withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.2),
                                spreadRadius: -2,
                                blurRadius: 15,
                                // offset: Offset(1,5)
                              )
                            ]),
                        child: _walletLogic.paymentMethodList[index].image!
                                .contains('braintreePayment')
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: SvgPicture.asset(
                                  '${_walletLogic.paymentMethodList[index].image}',
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    '${_walletLogic.paymentMethodList[index].image}',
                                    width:
                                        MediaQuery.of(context).size.width * .15,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );
    }),
  );
}
