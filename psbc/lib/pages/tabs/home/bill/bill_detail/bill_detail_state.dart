import '../../../../../config/model/bill_model.dart';

class BillDetailState {

  BillListBillDetail billDetail = BillListBillDetail();


  List titles_0 = [
    '交易卡号',
    '交易时间',
    '交易渠道',
    '收款账号',
    '收款银行',
    '附言',
    '摘要',
    '交易流水号',
  ];
  List titles_1 = [
    '交易卡号',
    '交易时间',
    '交易渠道',
    '付款银行',
    '付款账号',
    '附言',
    '摘要',
    '交易流水号',
  ];


  List titles1 = [
    '交易类型',
    '所属账本',
    '不计入本月收支',
    '附注'
  ];

  List titles3 = [
    '通知收款人',
    '查看往来记录',
    '给Ta转账'
  ];

  BillDetailState() {
    ///Initialize variables
  }
}
