import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import '../../../../../config/model/notice_data_model.dart';
import 'transfer_notice_state.dart';

class TransferNoticeLogic extends GetxController {
  final TransferNoticeState state = TransferNoticeState();

  String valueStr(String name){
    if(name == '交易时间') return state.data.transactionTime;
    if(name == '收款人') return state.data.oppositeName;
    if(name == '收款账号') {
      return state.data.oppositeAccount.maskBankCardNumber(
        prefixLength: 6,
        fixStr: ' ',
        maskCharCount: 6,
      );
    }
    if(name == '附言') return state.data.postscript;
    if(name == '收款银行') return state.data.oppositeBank;
    if(name == '付款账户') return AppConfig.config.abcLogic.card();
    if(name == '受理方式') return '实时';
    return '';
  }

  @override
  void onInit() {
    super.onInit();
    state.data = Get.arguments['model']??NoticeDataModel();
  }
}
