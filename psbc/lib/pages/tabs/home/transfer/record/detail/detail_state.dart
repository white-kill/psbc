import '../../../../../../config/model/bill_model.dart';

class DetailState {

  List titles = [
    '交易卡号',
    '交易时间',
    '摘要',
    '收款人',
    '收款账号',
    '收款银行',
    '附言',
    '转账流水号',
    '人行报文标识号',
  ];

  List titles1 = [
    '交易卡号',
    '交易时间',
    '摘要',
    '付款人',
    '付款账号',
    '付款行名',
    '附言',
  ];

  BillListBillDetail billDetail = BillListBillDetail();

  DetailState() {
    ///Initialize variables
  }
}
