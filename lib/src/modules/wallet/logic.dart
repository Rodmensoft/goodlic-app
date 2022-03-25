import 'package:consultant_product/src/modules/wallet/model_deposit_wallet.dart';
import 'package:consultant_product/src/modules/wallet/model_get_all_transaction.dart';
import 'package:consultant_product/src/modules/wallet/model_get_wallet_balance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class WalletLogic extends GetxController {
  final WalletState state = WalletState();

  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
  ScrollController? scrollController2;
  bool lastStatus2 = true;
  double height2 = 100.h;

  bool get isShrink2 {
    return scrollController2!.hasClients &&
        scrollController2!.offset > (height2 - kToolbarHeight);
  }

  void scrollListener2() {
    if (isShrink2 != lastStatus2) {
      lastStatus2 = isShrink2;
      update();
    }
  }




  GetWalletBalanceModel getWalletBalanceModel = GetWalletBalanceModel();
  GetAllTransactionModel getAllTransactionModel = GetAllTransactionModel();
  DepositWalletModel depositWalletModel = DepositWalletModel();

  TextEditingController amountController = TextEditingController();
  TextEditingController easypaisaAmountController = TextEditingController();
  TextEditingController withdrawAmountController = TextEditingController();
  TextEditingController jazzCashCnicTextController = TextEditingController();
  TextEditingController paymentAccountNumberTextController = TextEditingController();

  final RefreshController refreshAppointmentsController =
  RefreshController(initialRefresh: false);


  updateRefreshController(){
    refreshAppointmentsController.refreshCompleted();
    update();
  }

  bool? getWalletBalanceLoader = true;

  updateGetWalletBalanceLoader(bool? newValue) {
    getWalletBalanceLoader = newValue;
    update();
  }

  bool? getAllTransactionLoader = true;

  updateGetAllTransactionLoader(bool? newValue) {
    getAllTransactionLoader = newValue;
    update();
  }

  bool? getAllTransactionMoreLoader = false;

  updateGetAllTransactionMoreLoader(bool? newValue) {
    getAllTransactionMoreLoader = newValue;
    update();
  }

  List<TransactionsModel> getAllTransactionList = [];

  updateGetAllTransactionList(
      TransactionsModel transactionsModel) {
    getAllTransactionList.add(transactionsModel);
    update();
  }

  emptyGetAllTransactionList() {
    getAllTransactionList = [];
    update();
  }
}
