import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../bill_analyze_logic.dart';
import '../bill_analyze_state.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  // 记录当前点击选中的点的索引

  final BillAnalyzeLogic logic = Get.find<BillAnalyzeLogic>();
  final BillAnalyzeState state = Get.find<BillAnalyzeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (BillAnalyzeLogic c) {
        final int dataCount = state.spots.length;
        final double pointSpacing = 80.w;
        final double chartWidth = (dataCount - 1) * pointSpacing + 64.w;
        return  Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text:
                          '￥${logic.isZc ? state.analyzeModel.expenses.bankBalance : state.analyzeModel.income.bankBalance}'
                              .replaceAll('-', ''),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff333333)),
                    ).withPadding(
                      top: 15.w,
                      bottom: 15.w,
                      left: 15.w,
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.only(right: 0.w),
                      reverse: true,
                      controller: state.chatScrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                          width: chartWidth,
                          child: Column(
                            children: [
                              Row(
                                children: state.spots.map((e) {
                                  int index = state.spots.indexOf(e);
                                  return Container(
                                    height: 20.w,
                                    alignment: Alignment.center,
                                    child: BaseText(
                                      text: '¥${state.spots[index].y}',
                                      fontSize: 11,
                                      color: const Color(0xffCCCCCC),
                                    ),
                                  ).expanded();
                                }).toList(),
                              ).withContainer(
                                padding: EdgeInsets.only(
                                    left: (chartWidth / state.spots.length) / 2,
                                    right:
                                        (chartWidth / state.spots.length) / 2),
                              ),
                              LineChart(
                                mainData(state.spots),
                                key: const ValueKey('BillAnalyzeChart'),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              ).withContainer(
                                height: 220.w,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              );
      },
      id: 'updateChat',
    );
  }

  LineChartData mainData(List<FlSpot> spots) {
    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: false,
        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
          // 当发生点击或长按等交互时
          if (!event.isInterestedForInteractions ||
              touchResponse == null ||
              touchResponse.lineBarSpots == null) {
            return;
          }
          // 更新选中的点索引并刷新UI
          setState(() {
            state.touchedIndex = touchResponse.lineBarSpots!.first.spotIndex;
          });
        },
        // 选中时的指示器样式
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return const TouchedSpotIndicatorData(
              FlLine(color: Colors.transparent),
              FlDotData(show: true),
            );
          }).toList();
        },
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        verticalInterval: 1,
        getDrawingVerticalLine: (value) {
          // 核心逻辑：判断当前绘制的垂直线是否属于被点击的点
          final bool isTouched =
              state.touchedIndex != null && value.toInt() == state.touchedIndex;
          return FlLine(
            color: isTouched
                ? const Color(0xff0D703E)
                : const Color(0xffe7e8e8), // 选中变红
            strokeWidth: 1, // 选中加粗
            dashArray: [5, 5], // 红色虚线效果
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xffe7e8e8), width: 1),
        ),
      ),
      minX: -1,
      maxX:
          state.spots.isNotEmpty ? (state.spots.length - 1).toDouble() + 1 : 10,
      //spots.length -1,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          preventCurveOverShooting: true,
          color: const Color(0xff0D703E),
          barWidth: 2,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              // final bool isSelected = index == touchedIndex;
              return FlDotCirclePainter(
                radius: 2,
                color: Colors.white, // 选中的点变红
                strokeColor: const Color(0xff0D703E),
                strokeWidth: 2,
              );
            },
          ),
          belowBarData: BarAreaData(show: true,

            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff0D703E).withValues(alpha: 0.06),
                const Color(0xff0D703E).withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    // 选中的刻度文字也可以同步变色
    final bool isSelected =
        state.touchedIndex != null && value.toInt() == state.touchedIndex;
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: isSelected ? Colors.black : Color(0xff999999),
    );
    bool c = value.toInt() >= state.trendList.length;
    bool c1 = value.toInt() < 0;
    final reversedList = state.trendList.reversed.toList();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
          c1 || c
              ? ''
              : formatDate(reversedList[value.toInt()].dateTime, value.toInt()),
          style: style),
      // child: Text(value.toString(), style: style),
    );
  }

  String formatDate(String dateStr, int index) {
    if (index >= state.trendList.length) return '';
    DateTime dt = DateTime.parse(dateStr);
    if (state.selectedTimeType == '月度') {
      if(dt.month == 12){
        return '${DateFormat('MM月').format(dt)}(${dt.year})';
      }
      return DateFormat('MM月').format(dt);
    }
    return DateFormat('yyyy年').format(dt);
  }
}
