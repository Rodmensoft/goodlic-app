import 'dart:developer';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/wallet/razorpay_payment/repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:resize/resize.dart';

class RazorPayWalletView extends StatefulWidget {
  const RazorPayWalletView({Key? key}) : super(key: key);

  // String? amount;
  // RazorPayView({Key? key, this.amount}) : super(key: key);

  @override
  _RazorPayWalletViewState createState() => _RazorPayWalletViewState();
}

class _RazorPayWalletViewState extends State<RazorPayWalletView> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final descController = TextEditingController();

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    // amountController.text = widget.amount.toString();
    initializeRazorPay();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void initializeRazorPay() {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  launchRazorPay() {

    var option = {
      'key': '${GlobalConfiguration().get('razorpay_key')}',
      'amount': num.parse(amountController.text) * 100,
      'name': nameController.text,
    };
    try {
      _razorpay.open(option);
    } catch (e) {
      log('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log('payment Successful');
    log('${response.orderId} \n ${response.paymentId} \n ${response.signature}');
    // showLoading('Success');
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.success.tr,
            titleColor: customDialogSuccessColor,
            descriptions: 'Add To Wallet Successfully!',
            text: LanguageConstant.ok.tr,
            functionCall: () {
              //Navigator.pop(context);
              Get.back();
              Get.find<GeneralController>().updateFormLoaderController(true);

              postMethod(
                  context,
                  walletDepositUrl,
                  {
                    'token': '123',
                    'user_id': Get.find<GeneralController>().storageBox.read('userID'),
                    'amount': amountController.text,
                  },
                  true,
                  razorWalletDeposiRepo);
            },
            img: 'assets/Icons/dialog_success.svg',
          );
        });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('Payment Failed');
    log('${response.code} \n ${response.message}');
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.failed.tr,
            titleColor: customDialogErrorColor,
            descriptions: '${LanguageConstant.tryAgain.tr}!',
            text: LanguageConstant.ok.tr,
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/Icons/dialog_error.svg',
          );
        });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('Failed payment');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
      return ModalProgressHUD(
        inAsyncCall: _bookAppointmentLogic.formLoaderController!,
        progressIndicator: const CircularProgressIndicator(
          color: customThemeColor,
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/Icons/whiteBackArrow.svg',
                  ),
                ],
              ),
            ),
            backgroundColor: customThemeColor,
          ),

          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    // Text(
                    //   'Razor Pay',
                    //   style: TextStyle(
                    //       fontFamily: SarabunFontFamily.bold,
                    //       fontSize: 28.sp,
                    //       color: customTextBlackColor),
                    // ),
                    SvgPicture.asset(
                      'assets/Icons/razorpay.svg',
                      height: 40.h,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child:

                          /// Amount
                          TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                          hintText: 'Amount',
                          hintStyle: TextStyle(fontFamily: SarabunFontFamily.regular, fontSize: 16.sp, color: customTextGreyColor),
                          fillColor: customTextFieldColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                          focusedBorder:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: customLightThemeColor)),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    /// name
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]"))],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                          hintText: 'Name',
                          hintStyle: TextStyle(fontFamily: SarabunFontFamily.regular, fontSize: 16.sp, color: customTextGreyColor),
                          fillColor: customTextFieldColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                          focusedBorder:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: customLightThemeColor)),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 25.h),

                    /// Make Payment Button
                    InkWell(
                      onTap: () {

                        launchRazorPay();
                      },
                      child: const MyCustomBottomBar(
                        title: 'Make Payment',
                        disable: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      );
    });
  }
}
