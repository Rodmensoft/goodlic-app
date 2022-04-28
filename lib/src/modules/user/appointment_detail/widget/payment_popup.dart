import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/modules/user/appointment_detail/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

paymentBottomSheetForLater(BuildContext context) async {
  return Get.bottomSheet(
    ///---payment-method-area
    GetBuilder<AppointmentDetailLogic>(builder: (_appointmentDetailLogic) {
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
                'Payment Method',
                style: _appointmentDetailLogic.state.headingTextStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              Wrap(
                children: List.generate(
                    _appointmentDetailLogic.paymentMethodList.length, (index) {
                  return Padding(
                    padding: index % 2 == 0
                        ? EdgeInsetsDirectional.fromSTEB(0, 0, 8.w, 18.h)
                        : EdgeInsetsDirectional.fromSTEB(8.w, 0.h, 0.w, 18.h),
                    child: InkWell(
                      onTap: () {
                        _appointmentDetailLogic.selectedPaymentType = index;
                        _appointmentDetailLogic.update();
                        _appointmentDetailLogic.amountController.clear();

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Get.toNamed(PageRoutes.stripePaymentForLater);
                      },
                      child: Container(
                        height: 61.h,
                        width: MediaQuery.of(context).size.width * .38,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: _appointmentDetailLogic
                                        .paymentMethodList[index].isSelected!
                                    ? customLightThemeColor
                                    : Colors.white,
                                width: 2),
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: _appointmentDetailLogic
                                        .paymentMethodList[index].isSelected!
                                    ? customLightThemeColor.withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.2),
                                spreadRadius: -2,
                                blurRadius: 15,
                                // offset: Offset(1,5)
                              )
                            ]),
                        child: _appointmentDetailLogic
                                .paymentMethodList[index].image!
                                .contains('braintreePayment')
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: SvgPicture.asset(
                                  '${_appointmentDetailLogic.paymentMethodList[index].image}',
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    '${_appointmentDetailLogic.paymentMethodList[index].image}',
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
