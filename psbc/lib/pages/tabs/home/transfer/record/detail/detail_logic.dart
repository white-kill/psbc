import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import '../../../../../../config/app_config.dart';
import 'detail_state.dart';

class TransferDetailLogic extends GetxController {
  final DetailState state = DetailState();

  List titleName = [];

  @override
  void onInit() {
    super.onInit();
    state.billDetail = Get.arguments['model'];
    if (state.billDetail.type == '1') {
      titleName.addAll(state.titles1);
    } else {
      titleName.addAll(state.titles);
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
      case '摘要':
        return state.billDetail.excerpt;
      case '收款人':
      case '付款人':
        return state.billDetail.oppositeName;
      case '收款账号':
      case '付款账号':
        return state.billDetail.oppositeAccount.maskBankCardNumber(
          prefixLength: 6,
          fixStr: ' ',
          maskCharCount: 6,
        );
      case '收款银行':
      case '付款行名':
        return state.billDetail.oppositeBankName;
      case '附言':
        return state.billDetail.merchantBranch == ''
            ? '无附言'
            : state.billDetail.merchantBranch;

      case '转账流水号':
        return state.billDetail.certificateNo;
      case '人行报文标识号':
        return state.billDetail.postscriptno;
      default:
        return '';
    }
  }
}
