import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psbc/config/app_config.dart';

import 'transfer_result_state.dart';

class TransferResultLogic extends GetxController {
  final TransferResultState state = TransferResultState();

  String time = '';
  @override
  void onInit() {
    super.onInit();
    state.cardReq = Get.arguments['req'];
    DateTime now = DateTime.now();
    String formattedDate2 = DateFormat('yyyy/MM/dd HH:mm:ss').format(now);
    time = formattedDate2;
  }


  String valueStr(String name){
    if(name == '收款账号'){
      return formatBankCardNumber(state.cardReq.cardNo);
    }
    if(name == '开户行'){
      return state.cardReq.bankName;
    }
    if(name == '手续费'){
      return '￥0.00';
    }
    if(name == '受理方式'){
      return '实时';
    }
    if(name == '附言'){
      return state.cardReq.purpose == ''?'--':state.cardReq.purpose;
    }
    if(name == '付款账号'){
      return AppConfig.config.abcLogic.card();
    }
    if(name == '可用余额'){
      return '¥' + AppConfig.config.abcLogic.balance();
    }
    return '';
  }

  String formatBankCardNumber(String cardNumber) {
    String digits = cardNumber.replaceAll(RegExp(r'[^\d]'), '');
    StringBuffer formatted = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted.write(' ');
      }
      formatted.write(digits[i]);
    }

    return formatted.toString().trim();
  }

}
