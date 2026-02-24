import 'package:intl/intl.dart';
import 'package:psbc/pages/tabs/home/print/req_print.dart';

import '../../../../utils/time_tool.dart';

class PrintState {

  String endTime = '';
  String beginTime = '';

  String selType = '发送邮箱';

  ReqPrint reqPrint = ReqPrint();

  List showTypeList = [
    '0',
    '1',
    // '2',
  ];

  PrintState() {
    Map<String,String> timeMap = DateRangeCalculator.getRecentMonthRange(6);
    beginTime = timeMap['start']??'';
    endTime = timeMap['end']??'';
    reqPrint.endTime = endTime;
    reqPrint.beginTime = beginTime;
    reqPrint.currency = '人民币';
    reqPrint.categoryType = '';
  }

}
