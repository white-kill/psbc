import 'package:flutter/material.dart';
import 'package:psbc/config/model/month_info_model.dart';

class MonthInfoState {
  String dateTime = '';
  String month = '';
  MonthInfoModel infoModel = MonthInfoModel();
  int? touchedIndex; // 用于跟踪选中的图表点
  ScrollController chartScrollController = ScrollController(); // 图表滚动控制器
  List<MonthInfoIncomeExpenseAnalysisTrend> trendList = []; // 存储趋势数据列表
  
  MonthInfoState() {
    ///Initialize variables
  }
}
