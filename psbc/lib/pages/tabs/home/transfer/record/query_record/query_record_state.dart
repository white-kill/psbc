import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../../config/model/record_list_model.dart';
import '../../../../../../utils/time_tool.dart';
import '../../../../../component/sheet_widget/picker_widget.dart';
import '../req_data.dart';

class Query_recordState {


  TextEditingController searchController = TextEditingController();
  ScrollController scController = ScrollController();
  ReqRecordData recordData = ReqRecordData();
  RefreshController refreshController = RefreshController();

  List<RecordListList> list = [];
  RecordListModel recordModel = RecordListModel();



  bool isYear = false;
  DateTimePickerNotifier mPickerNotifier = DateTimePickerNotifier();
  DateTimePickerNotifier pickerNotifier = DateTimePickerNotifier();

  //月份时间
  String yearTime = '';
  String temYearTime= '';


  String timeTitle = '近一年';
  String temTimeTitle = '';
  //  开始时间
  String beginTime = '';
  String temBeginTime = '';
  //结束时间
  String endTime = '';
  String temEndTime = '';


  TextEditingController amountController1 = TextEditingController();
  TextEditingController amountController2 = TextEditingController();

  String type1 = '全部';
  String temType1 = '';
  String type2 = '全部';
  String temType2 = '';
  String type3 = '全部';
  String temType3 = '';
  Query_recordState() {
    ///Initialize variables
    Map<String,String> timeMap = DateRangeCalculator.getRecentMonthRange(12);
    beginTime = timeMap['start']??'';
    endTime = timeMap['end']??'';
  }
}
