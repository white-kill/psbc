import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/model/analyze_all_model.dart';
import 'package:psbc/config/net_config/apis.dart';

import 'bill_analyze_state.dart';

class BillAnalyzeLogic extends GetxController {
  final BillAnalyzeState state = BillAnalyzeState();

  var switchValue = false.obs;

  bool isZc = true;

  @override
  void onInit() {
    super.onInit();
    state.dateTime = Get.arguments?['time']??DateFormat('yyyy-MM').format(DateTime.now());
    billAnalysis();
  }

  void billAnalysis(){
    Http.get(Apis.billAnalysis,queryParameters: {
      'type':state.selectedTimeType == '月度'?'0':'1',
      'dateTime':state.dateTime,
    }).then((v){
      if(v != null){
        state.spots.clear();
        state.analyzeModel = AnalyzeAllModel.fromJson(v);
        state.trendList = state.analyzeModel.trendList;
        update(['updateUI']);
        state.spots = generateRandomData(state.analyzeModel.trendList);
        update(['updateChat']);
        jumpAt();
      }
    });
  }



  String timeStr(){
    if(state.selectedTimeType == '月度'){
     return  state.dateTime.split('-').last + '月排行榜';
    }
    return state.dateTime + '年排行榜';
  }

  List<AnalyzeAllCateogryList> catList(){
    if(isZc){
      return state.analyzeModel.expensesCateogryList;
    }
    return state.analyzeModel.incomeCateogryList;
  }

  List<AnalyzeRankList> rankList(){
    if(isZc){
      return state.analyzeModel.expensesRankList;
    }
    return state.analyzeModel.incomeRankList;
  }

  double price(){
    double priceAll = 0.0;
    if(isZc){
      state.analyzeModel.expensesRankList.forEach((e){
        priceAll = priceAll + e.amount.abs();
      });
    }else {
      state.analyzeModel.incomeRankList.forEach((e){
        priceAll = priceAll + e.amount.abs();
      });
    }
    return priceAll;

  }


  void jumpAt(){
    int idx = (state.analyzeModel.trendList.length - 1) -( state.touchedIndex??0);
    state.chatScrollController.animateTo((idx * 64).w,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,);
  }

  List<FlSpot> generateRandomData(List<AnalyzeAllTrendList> trendList) {
    // 1. 先将原始数据反转，这样第一个元素就是原来的最后一个
    final reversedList = trendList.reversed.toList();

    List<FlSpot> spots = [];

    for (int i = 0; i < reversedList.length; i++) {
      final e = reversedList[i];
      if(isMatch(state.dateTime, e.dateTime)){
        state.touchedIndex = i;
      }
      // print(e.dateTime);
      // x 轴使用递增的索引 i，y 轴使用反转后的数据
      spots.add(FlSpot(i.toDouble(), isZc?e.expenses.abs():e.income));
    }
    // state.touchedIndex = spots.length -1;
    return spots;
  }

  bool isMatch(String input, String listDate) {
    if (input.length == 4) {
      return listDate.startsWith(input);
    } else {
      return listDate.startsWith(input);
    }
  }



}
