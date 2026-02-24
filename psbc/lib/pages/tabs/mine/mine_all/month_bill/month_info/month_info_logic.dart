import 'package:get/get.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/model/month_info_model.dart';
import 'package:psbc/config/net_config/apis.dart';

import 'month_info_state.dart';

class MonthInfoLogic extends GetxController {
  final MonthInfoState state = MonthInfoState();

  var value1 = false.obs;
  var value2 = false.obs;
  var value3 = false.obs;
  var showPage = false.obs;
  @override
  void onInit() async {
    super.onInit();

    state.dateTime = Get.arguments['dateTime'];
    state.month = Get.arguments['month'];
    await Future.delayed(const Duration(seconds: 1));
    value1.value = true;
    await Future.delayed(const Duration(seconds: 1));
    value2.value = true;
    await Future.delayed(const Duration(seconds: 1));
    value3.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    showPage.value = true;
    getData();
  }
  
  void getData(){
    // 如果传入了趋势数据，直接使用
    final dynamic trendData = Get.arguments['trendData'];
    if (trendData != null && trendData is List) {
      // 从传入的 dateTime 中提取年份
      int targetYear;
      try {
        if (state.dateTime.isNotEmpty) {
          // dateTime 格式应该是 "yyyy-MM"
          final parts = state.dateTime.split('-');
          if (parts.isNotEmpty) {
            targetYear = int.parse(parts[0]);
          } else {
            targetYear = DateTime.now().year;
          }
        } else {
          targetYear = DateTime.now().year;
        }
      } catch (e) {
        targetYear = DateTime.now().year;
      }
      
      // 将传入的趋势数据转换为 MonthInfoIncomeExpenseAnalysisTrend 列表
      List<MonthInfoIncomeExpenseAnalysisTrend> allTrends = trendData.map((item) {
        return MonthInfoIncomeExpenseAnalysisTrend()
          ..dateTime = item['dateTime'] ?? ''
          ..income = (item['income'] ?? 0).toDouble()
          ..expenses = (item['expenses'] ?? 0).toDouble();
      }).toList();
      
      // 筛选出该年的数据
      List<MonthInfoIncomeExpenseAnalysisTrend> yearTrends = allTrends.where((trend) {
        try {
          if (trend.dateTime.isEmpty) return false;
          final parts = trend.dateTime.split('-');
          if (parts.isNotEmpty) {
            final int year = int.parse(parts[0]);
            return year == targetYear;
          }
          return false;
        } catch (e) {
          return false;
        }
      }).toList();
      
      // 按月份排序（1月到12月）
      yearTrends.sort((a, b) {
        try {
          final aParts = a.dateTime.split('-');
          final bParts = b.dateTime.split('-');
          if (aParts.length >= 2 && bParts.length >= 2) {
            final aMonth = int.parse(aParts[1]);
            final bMonth = int.parse(bParts[1]);
            return aMonth.compareTo(bMonth);
          }
          return 0;
        } catch (e) {
          return 0;
        }
      });
      
      // 确保只有12个月的数据（如果超过12个月，取前12个月）
      if (yearTrends.length > 12) {
        yearTrends = yearTrends.sublist(0, 12);
      }
      
      // 将数据存储到 state 的 trendList 中
      state.trendList = yearTrends;
      update(['updateUI']);
      return;
    }

    // 否则调用API获取数据
    Http.get(Apis.monthBill,queryParameters: {
      'dateTime':state.dateTime,
    }).then((v){
      state.infoModel = MonthInfoModel.fromJson(v);
      // 将网络获取的数据也存储到 trendList
      state.trendList = state.infoModel.incomeExpenseAnalysis.trend;
      update(['updateUI']);
    });
  }
}
