import '../../../../../config/model/notice_data_model.dart';

class TransferNoticeState {

  List titles = [
    '交易时间',
    '收款人',
    '收款账号',
    '附言',
    '收款银行',
    '付款账户',
    '受理方式'
  ];
  NoticeDataModel data = NoticeDataModel();
  TransferNoticeState() {
    ///Initialize variables
  }
}
