import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../../config/model/analyze_all_model.dart';
import '../../../../component/sheet_widget/picker_widget.dart';

class BillAnalyzeState {
  AnalyzeAllModel analyzeModel = AnalyzeAllModel();
  List<AnalyzeAllTrendList> trendList = [];
  List<FlSpot> spots = [];
  int? touchedIndex;

  String selectedTimeType = '月度';
  String dateTime = '';
  DateTimePickerNotifier pickerNotifier = DateTimePickerNotifier();

  ScrollController chatScrollController = ScrollController();


  BillAnalyzeState() {
    ///Initialize variables
    dateTime = DateFormat('yyyy-MM').format(DateTime.now());

    for (int i = 0; i < 180; i++) {
      spots.add(FlSpot(i.toDouble(), 0));
    }

  }
}
