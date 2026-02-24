import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import 'bill_detail_state.dart';

class BillDetailLogic extends GetxController {
  final BillDetailState state = BillDetailState();

  var categoryText = ''.obs;
  var categoryImg = ''.obs;
  String temCategoryText = '';

  var noShow = true.obs;

  List fTitles = [];

  @override
  void onInit() {
    super.onInit();
    state.billDetail = Get.arguments['model'];
    categoryText.value = state.billDetail.transactionCategory;
    categoryImg.value = state.billDetail.icon;
    if(state.billDetail.type == '2'){
      fTitles = state.titles_0;
    }else {
      fTitles = state.titles_1;
    }
  }

  String type() {
    if (state.billDetail.type == '1') {
      return '+';
    }
    if (state.billDetail.type == '2') {
      return '-';
    }
    return '+';
  }

  String valueStr(String name) {
    switch (name) {
      case '交易卡号':
        return AppConfig.config.abcLogic.card();
      case '交易时间':
        return state.billDetail.transactionTime;
      case '交易渠道':
        return state.billDetail.transactionChannel;
      case '收款账号':
      case '付款账号':
        return state.billDetail.oppositeAccount.maskBankCardNumber(
          prefixLength: 6,
          fixStr: ' ',
          maskCharCount: 6,
        );

      case '付款银行':
      case '收款银行':
        return state.billDetail.oppositeBankName == ''?'--':state.billDetail.oppositeBankName;
      case '附言':
        return state.billDetail.merchantBranch == ''
            ? '无附言'
            : state.billDetail.merchantBranch;
      case '摘要':
        return state.billDetail.excerpt;
      case '交易流水号':
        return state.billDetail.postscriptno;
      default:
        return '';
    }
  }
}
