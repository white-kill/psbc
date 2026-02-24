import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../config/model/bill_serach_model.dart';
import '../../../../../utils/time_tool.dart';
import '../../../../component/sheet_widget/picker_widget.dart';

class BillSearchState {
  TextEditingController textController = TextEditingController();


  bool isMonth = false;
  DateTimePickerNotifier mPickerNotifier = DateTimePickerNotifier();
  DateTimePickerNotifier pickerNotifier = DateTimePickerNotifier();

  //月份时间
  String mothTime = '';
  String temMothTime= '';


  String timeTitle = '近一年';
  String temTimeTitle = '';
  //  开始时间
  String beginTime = '';
  String temBeginTime = '';
  //结束时间
  String endTime = '';
  String temEndTime = '';

  ScrollController scController = ScrollController();

  int pageNum = 1;
  String keyword = '';

  BillSerachModel serachModel = BillSerachModel();
  List<BillSerachList> list = [];

  RefreshController refreshController = RefreshController();

  BillSearchState() {
    ///Initialize variables
    DateTime now = DateTime.now();
    mothTime = DateFormat('yyyy-MM').format(now);
    Map<String,String> timeMap = DateRangeCalculator.getRecentMonthRange(12);
    beginTime = timeMap['start']??'';
    endTime = timeMap['end']??'';
  }
}
