import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../config/model/apply_record_model.dart';

class ApplyRecordState {
  int pageNum = 1;
  List<ApplyRecordList> list = [];
  ApplyRecordModel recordModel = ApplyRecordModel();
  RefreshController refreshController = RefreshController();
  List titles = [
    '申请日期',
    '获取方式',
    '文件提取码',
    '邮件序列号',
    '起始时间',
    '截止时间',
    '接收邮箱'
  ];

  List titles1 = [
    '申请日期',
    '获取方式',
    '起始时间',
    '截止时间',
    ''
  ];
  ApplyRecordState() {
    ///Initialize variables
  }
}
