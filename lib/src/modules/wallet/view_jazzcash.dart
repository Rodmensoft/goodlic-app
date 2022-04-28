import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/wallet/logic.dart';
import 'package:consultant_product/src/modules/wallet/repo_post.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class DepositJazzCashView extends StatefulWidget {
  const DepositJazzCashView({Key? key}) : super(key: key);

  @override
  _DepositJazzCashViewState createState() => _DepositJazzCashViewState();
}

class _DepositJazzCashViewState extends State<DepositJazzCashView>
    with TickerProviderStateMixin {
  final logic = Get.put(WalletLogic());
  final state = Get.find<WalletLogic>().state;

  bool _canVibrate = true;
  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];

  final GlobalKey<FormState> _paymentFormKey = GlobalKey();

  AnimationController? slidAbleAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<WalletLogic>().scrollController2 = ScrollController()
      ..addListener(Get.find<WalletLogic>().scrollListener2);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<WalletLogic>().paymentAccountNumberTextController.clear();
      Get.find<WalletLogic>().jazzCashCnicTextController.clear();
      Get.find<WalletLogic>().amountController.clear();
    });
    slidAbleAnimationController = AnimationController.unbounded(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.find<WalletLogic>()
        .scrollController2!
        .removeListener(Get.find<WalletLogic>().scrollListener2);
    Get.find<WalletLogic>().scrollController2!.dispose();
    super.dispose();
    slidAbleAnimationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<WalletLogic>(
        builder: (_walletLogic) =>
            GetBuilder<GeneralController>(builder: (_generalController) {
          return ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            inAsyncCall: _generalController.formLoaderController!,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: NestedScrollView(
                controller: _walletLogic.scrollController2,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .2,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 0,
                      backgroundColor: _walletLogic.isShrink2
                          ? customThemeColor
                          : Colors.transparent,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
                          ],
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40.r))),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .23,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.w, 25.h, 16.w, 16.h),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              Text(
                                                'Jazzcash',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily.bold,
                                                    fontSize: 28.sp,
                                                    color:
                                                        customLightThemeColor),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                '',
                                                style: TextStyle(
                                                    fontFamily:
                                                        SarabunFontFamily
                                                            .medium,
                                                    fontSize: 12.sp,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Form(
                      key: _paymentFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///---heading
                          Text(
                            LanguageConstant.enterJazzCashDetails.tr,
                            style: state.subHeadingTextStyle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          ///---jazz-cash-number-field
                          Container(
                            decoration: BoxDecoration(
                                color: customTextFieldColor,
                                borderRadius: BorderRadius.circular(7)),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 20, 15, 20),
                              child: Column(
                                children: [
                                  ///---cnic-field
                                  TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6),
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                    ],
                                    style: state.textFieldTextStyle,
                                    controller:
                                        _walletLogic.jazzCashCnicTextController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              25.w, 15.h, 25.w, 15.h),
                                      hintText: LanguageConstant
                                          .enterLast6DigitsOfYourCNIC.tr,
                                      hintStyle: TextStyle(
                                          fontFamily: SarabunFontFamily.regular,
                                          fontSize: 16.sp,
                                          color: customTextGreyColor),
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
                                              color: customLightThemeColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .fieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  ///---number-field
                                  TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                    ],
                                    style: state.textFieldTextStyle,
                                    controller: _walletLogic
                                        .paymentAccountNumberTextController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              25.w, 15.h, 25.w, 15.h),
                                      hintText:
                                          LanguageConstant.jazzCashNumber.tr,
                                      hintStyle: TextStyle(
                                          fontFamily: SarabunFontFamily.regular,
                                          fontSize: 16.sp,
                                          color: customTextGreyColor),
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
                                              color: customLightThemeColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .fieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  ///---amount-field
                                  TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                    ],
                                    style: state.textFieldTextStyle,
                                    controller: _walletLogic.amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              25.w, 15.h, 25.w, 15.h),
                                      hintText: LanguageConstant.enterAmount.tr,
                                      hintStyle: TextStyle(
                                          fontFamily: SarabunFontFamily.regular,
                                          fontSize: 16.sp,
                                          color: customTextGreyColor),
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
                                              color: customLightThemeColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return LanguageConstant
                                            .fieldRequired.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: InkWell(
                  onTap: () {
                    if (_paymentFormKey.currentState!.validate()) {
                      _generalController.updateFormLoaderController(true);
                      postMethod(
                          context,
                          walletDepositJazzcashUrl,
                          {
                            'token': '123',
                            'user_id': Get.find<GeneralController>()
                                .storageBox
                                .read('userID'),
                            'mobile_no': _walletLogic
                                .paymentAccountNumberTextController.text,
                            'cnic':
                                _walletLogic.jazzCashCnicTextController.text,
                            'amount': _walletLogic.amountController.text,
                          },
                          true,
                          depositTransactionJazzcashRepo);
                    }
                  },
                  child: MyCustomBottomBar(
                    title: LanguageConstant.Continue.tr,
                    disable: false,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
