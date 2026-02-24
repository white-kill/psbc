import '../card_transfer/card_req.dart';

class TransferResultState {

  List titleNames = [
    '收款账号',
    '',
    '开户行',
    '手续费',
    '受理方式',
    '附言',
    '付款账号',
    '可用余额'
  ];

  List tgaNames = [
    '继续转账',
    '',
    '往来转账记录',
    '',
    '转入天天盈',
  ];

  CardReq cardReq = CardReq();
  TransferResultState() {
    ///Initialize variables
  }
}
