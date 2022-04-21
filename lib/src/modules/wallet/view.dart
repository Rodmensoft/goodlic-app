import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/modules/wallet/repo_get.dart';
import 'package:consultant_product/src/modules/wallet/repo_post.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/notififcation_icon.dart';
import 'logic.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final logic = Get.put(WalletLogic());

  final state = Get.find<WalletLogic>().state;

  late TooltipBehavior _tooltipBehavior;

  GlobalKey<FormState> addAmountFormKey = GlobalKey();
  GlobalKey<FormState> withdrawAmountFormKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<WalletLogic>().scrollController = ScrollController()
      ..addListener(Get.find<WalletLogic>().scrollListener);
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        borderColor: Colors.red,
        borderWidth: 5,
        color: Colors.lightBlue);

    getMethod(
        context,
        getWalletBalanceUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID'),
        },
        true,
        getWalletBalanceRepo);
    getMethod(
        context,
        getWalletTransactionUrl,
        {
          'token': '123',
          'user_id': Get.find<GeneralController>().storageBox.read('userID'),
        },
        true,
        getWalletTransactionRepo);
  }

  @override
  void dispose() {
    Get.find<WalletLogic>()
        .scrollController!
        .removeListener(Get.find<WalletLogic>().scrollListener);
    Get.find<WalletLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<WalletLogic>(builder: (_walletLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: ModalProgressHUD(
            inAsyncCall: _generalController.formLoaderController!,
            child: Scaffold(
              backgroundColor: const Color(0xffFBFBFB),
              body: NestedScrollView(
                  controller: _walletLogic.scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      SliverAppBar(
                          expandedHeight:
                              MediaQuery.of(context).size.height * .24,
                          floating: true,
                          pinned: true,
                          snap: true,
                          elevation: 0,
                          backgroundColor: _walletLogic.isShrink
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
                                SvgPicture.asset(
                                    'assets/Icons/whiteBackArrow.svg'),
                              ],
                            ),
                          ),
                          actions: const [
                            ///---notifications
                            CustomNotificationIcon()
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            background: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(40.r))),
                              child: Column(children: [
                                Stack(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/bookAppointmentAppBar.svg',
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .27,
                                      fit: BoxFit.fill,
                                    ),
                                    SafeArea(
                                        child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.w, 25.h, 16.w, 16.h),
                                      child: Stack(children: [
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
                                                  LanguageConstant
                                                      .amountInWallet.tr,
                                                  style: state.descTextStyle),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _walletLogic
                                                          .getWalletBalanceLoader!
                                                      ? SizedBox(
                                                          height: 20.h,
                                                          width: 100.w,
                                                          child: SkeletonLoader(
                                                              period:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                              highlightColor:
                                                                  Colors.grey,
                                                              direction:
                                                                  SkeletonDirection
                                                                      .ltr,
                                                              builder:
                                                                  Container(
                                                                height: 20.h,
                                                                width: 100.w,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10
                                                                            .r),
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        )
                                                      : Text(
                                                          '\$${_walletLogic.getWalletBalanceModel.data!.userBalance}',
                                                          style: state
                                                              .headingTextStyle),
                                                  if (_generalController
                                                          .storageBox
                                                          .read('userRole') ==
                                                      'Mentee')
                                                    InkWell(
                                                      onTap: () {
                                                        _walletLogic
                                                            .amountController
                                                            .clear();
                                                        // paymentTypeDialog(
                                                        //     context);
                                                        Get.toNamed(PageRoutes
                                                            .stripePaymentForWallet);
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 20.r,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Center(
                                                            child: SvgPicture
                                                                .asset(
                                                          'assets/Icons/add.svg',
                                                          height: 20.h,
                                                          width: 20.w,
                                                          color:
                                                              customOrangeColor,
                                                          fit: BoxFit.cover,
                                                        )),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ]),
                                      ]),
                                    )),
                                  ],
                                ),
                              ]),
                            ),
                          ))
                    ];
                  },
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            // SizedBox(height: 25.h),
                            // Text(
                            //   'Annual Record',
                            //   style: state.recordTextStyle,
                            // ),
                            // SizedBox(height: 65.h),
                            // Center(
                            //     child: Container(
                            //         child: SfCartesianChart(
                            //   primaryXAxis: CategoryAxis(),
                            //   tooltipBehavior: _tooltipBehavior,
                            // ))),
                            // SizedBox(height: 30.h),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16.w, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('transaction_log'.tr,
                                      style: state.recordTextStyle),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            _walletLogic.getAllTransactionLoader!
                                ? SkeletonLoader(
                                    period: const Duration(seconds: 2),
                                    highlightColor: Colors.grey,
                                    direction: SkeletonDirection.ltr,
                                    builder: Wrap(
                                      children: List.generate(10, (index) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 0),
                                          child: Container(
                                            height: 70,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                          ),
                                        );
                                      }),
                                    ))
                                : _walletLogic.getAllTransactionList.isEmpty
                                    ? Center(
                                        child: Text(
                                          'not_available_yet!'.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25.sp,
                                              fontFamily:
                                                  SarabunFontFamily.bold,
                                              color: Colors.black),
                                        ),
                                      )
                                    : Wrap(
                                        children: List.generate(
                                        _walletLogic
                                            .getAllTransactionList.length,
                                        (index) => Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.w, 0, 16.w, 15.h),
                                          child: Container(
                                            // height: 90.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: customTextFieldColor),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 15.w),
                                                  Expanded(
                                                      child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: _walletLogic
                                                                .getAllTransactionList[
                                                                    index]
                                                                .type
                                                                .toString() ==
                                                            LanguageConstant
                                                                .deposit.tr
                                                        ? Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 12.r,
                                                                backgroundColor:
                                                                    customLightThemeColor,
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_downward,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 6.h,
                                                              ),
                                                              Text(
                                                                _walletLogic
                                                                    .getAllTransactionList[
                                                                        index]
                                                                    .type
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style: state
                                                                    .typeTextStyle,
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 12.r,
                                                                backgroundColor:
                                                                    customLightThemeColor,
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_upward,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 6.h,
                                                              ),
                                                              Text(
                                                                _walletLogic
                                                                    .getAllTransactionList[
                                                                        index]
                                                                    .type
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style: state
                                                                    .typeTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                  )),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/Icons/feeIcon.svg'),
                                                        Text(
                                                          '  \$${_walletLogic.getAllTransactionList[index].amount.toString()}',
                                                          style: state
                                                              .feeTextStyle,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _walletLogic
                                                          .getAllTransactionList[
                                                              index]
                                                          .createdAt
                                                          .toString()
                                                          .substring(0, 10),
                                                      style:
                                                          state.dateTextStyle,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                          ],
                        ),
                      ),
                      _walletLogic.getWalletBalanceLoader!
                          ? const SizedBox()
                          : _generalController.storageBox.read('userRole') ==
                                      'Mentee' ||
                                  _walletLogic.getWalletBalanceModel.data!
                                          .userBalance ==
                                      '0'
                              ? const SizedBox()
                              : Positioned(
                                  bottom: 0.h,
                                  left: 15.w,
                                  right: 15.w,
                                  child: InkWell(
                                    onTap: () {
                                      _walletLogic.withdrawAmountController
                                          .clear();
                                      customDialogForWithdrawAmount(context);
                                    },
                                    child: MyCustomBottomBar(
                                      title: 'go_for_withdraw'.tr,
                                      disable: false,
                                    ),
                                  ),
                                )
                    ],
                  )),
            ),
          ),
        );
      });
    });
  }

  void paymentTypeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    Get.toNamed(PageRoutes.depositJazzcash);
                  },
                  child: Text(
                    "Jazzcash",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    customDialogForAddAmount(context);
                  },
                  child: Text(
                    "Easypaisa",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          );
        });
  }

  customDialogForAddAmount(BuildContext context) {
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
                  key: addAmountFormKey,
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
                                'add_amount'.tr,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.sp,
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
                          controller: logic.easypaisaAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                25.w, 15.h, 25.w, 15.h),
                            hintText: LanguageConstant.amount.tr,
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
                                LanguageConstant.cancel.tr,
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
                                if (addAmountFormKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  Get.toNamed(PageRoutes.depositEasypaisa);
                                }
                              },
                              child: Text(
                                LanguageConstant.add.tr,
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
                                LanguageConstant.cancel.tr,
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
                                LanguageConstant.submit.tr,
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
}
