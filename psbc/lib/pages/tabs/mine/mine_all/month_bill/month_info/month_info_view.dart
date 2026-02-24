import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/config/model/month_info_model.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:wb_base_widget/text_widget/text_tool.dart';

import '../../../../home/bill/bill_analyze/bill_analyze_view.dart';
import 'month_info_logic.dart';
import 'month_info_state.dart';

class MonthInfoPage extends BaseStateless {
  MonthInfoPage({Key? key}) : super(key: key);

  final MonthInfoLogic logic = Get.put(MonthInfoLogic());
  final MonthInfoState state = Get.find<MonthInfoLogic>().state;

  @override
  Color? get background => Colors.white;

  @override
  Widget? get titleWidget => Obx(() => logic.showPage.value
      ? Container(
          width: 120.w,
          height: 40.w,
          alignment: Alignment.center,
          child: BaseText(
            text: '${state.month}月账单',
            color: const Color(0xff111111),
            fontSize: 18.sp,
          ),
        )
      : const SizedBox.shrink());

  @override
  Widget initBody(BuildContext context) {
    return Obx(() {
      return logic.showPage.value
          ? GetBuilder<MonthInfoLogic>(builder:(_){
            return Container(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      Image(
                        image: 'y_zd_info'.png3x,
                        width: 1.sw,
                      ),

                      Positioned(
                          left: 30.w,
                          top: 175.w,
                          child: Container(
                            width: 1.sw - 60.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                BaseText(text: '资产概况',fontSize: 16,color: Color(0xff333333),),
                                SizedBox(height: 32.w,),
                                Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          BaseText(text: '月末总资产',fontSize: 13,color: Color(0xff66666F),),
                                          SizedBox(height: 12.w,),
                                          BaseText(
                                            text:
                                            '¥ ${state.infoModel.totalAmount.bankBalance}',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15
                                            ),
                                          )
                                        ],
                                      ),
                                    ).expanded(),
                                    SizedBox(width: 12.w,),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              BaseText(text: '较上月',fontSize: 13,color: Color(0xff66666F),),
                                              Image(image: state.infoModel.upTotalAmount < 0?'13'.png:'14'.png,width: 12.w,height: 12.w,),
                                            ],
                                          ),
                                          SizedBox(height: 12.w,),
                                          BaseText(
                                            text: '¥ ${state.infoModel.upTotalAmount.bankBalance}',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15
                                            ),
                                          )
                                        ],
                                      ),
                                    ).expanded(),
                                  ],
                                )
                              ],
                            ),
                          )),

                      Positioned(
                          left: 30.w,
                          top: 336.w,
                          child: Container(
                            width: 1.sw - 60.w,
                            height: 40.w,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 21.w),
                                  child: BaseText(
                                    text:
                                    '¥ ${AppConfig.config.abcLogic.balance()}',
                                    color: Color(0xff333333),
                                  ),
                                ).expanded(),
                                Container(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: BaseText(
                                    text: '¥ 0.00',
                                    color: Color(0xff333333),
                                  ),
                                ).expanded(),
                              ],
                            ),
                          )),
                      Positioned(
                          left: 30.w,
                          top: 336.w + 55.w,
                          child: Container(
                            width: 1.sw - 60.w,
                            height: 40.w,
                            child: Container(
                              width: 1.sw - 60.w,
                              height: 40.w,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 21.w),
                              child: BaseText(
                                text: '¥ 0.00',
                                color: Color(0xff333333),
                              ),
                            ),
                          )),
                      Positioned(
                          left: 30.w,
                          top: 336.w + 395.w,
                          child: Container(
                            width: 1.sw - 60.w,
                            height: 40.w,
                            child: Row(
                              children: [
                                Container(
                                  child: BaseText(
                                    text: '¥ ${AppConfig.config.abcLogic.balance()}',
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ).expanded(),
                                Container(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: BaseText(
                                    text: '¥ 0.00',
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ).expanded(),
                              ],
                            ),
                          )),
                      Positioned(
                          left: 30.w,
                          top: 336.w + 465.w,
                          child: Container(
                            width: 1.sw - 60.w,
                            height: 40.w,
                            child: Row(
                              children: [
                                Container(
                                  child: BaseText(
                                    text:
                                    '¥ ${AppConfig.config.abcLogic.balance()}',
                                    color: Color(0xff333333),
                                  ),
                                ).expanded(),
                                Container(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: BaseText(
                                    text: '¥ 0.00',
                                    color: Color(0xff333333),
                                  ),
                                ).expanded(),
                              ],
                            ),
                          )),
                      Positioned(
                          left: 0.w,
                          top: 336.w + 465.w + 50,
                          child: _IncomeExpenseChart(
                            width: 1.sw,
                            height: 250.w,
                          )),


                      // 底部更多收支分析
                      Positioned(
                          top: 1180.w,
                          child: Container(
                            width: 1.sw,
                            height: 45.w,
                          ).withOnTap(onTap: () {
                            Get.to(() => BillAnalyzePage(),arguments: {
                              'time':state.dateTime,
                            });
                          }))
                    ],
                  )
                ],
              ),
            );
      },id: 'updateUI',): Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: 'm_hj'.png3x),
                  SizedBox(
                    height: 30.w,
                  ),
                  Row(
                    children: [
                      (logic.value1.value
                              ? Image(
                                  image: 'm_dg'.png3x,
                                  width: 25.w,
                                  height: 25.w,
                                )
                              : CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      BColors.mainColor),
                                  strokeWidth: 1.5,
                                  backgroundColor: Colors.grey[200],
                                ))
                          .withContainer(
                        alignment: Alignment.center,
                        width: 15.w,
                        height: 15.w,
                        margin: EdgeInsets.only(left: 80.w),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      BaseText(
                        text: '月末资产变化情况统计...',
                        color: logic.value1.value
                            ? Colors.black
                            : Color(0xffC9C9C9),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.w,
                  ),
                  Row(
                    children: [
                      (logic.value2.value
                              ? Image(
                                  image: 'm_dg'.png3x,
                                  width: 25.w,
                                  height: 25.w,
                                )
                              : CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      BColors.mainColor),
                                  strokeWidth: 1.5,
                                  backgroundColor: Colors.grey[200],
                                ))
                          .withContainer(
                        alignment: Alignment.center,
                        width: 15.w,
                        height: 15.w,
                        margin: EdgeInsets.only(left: 80.w),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      BaseText(
                        text: '上月收支情况及历史对比分析...',
                        color: logic.value2.value
                            ? Colors.black
                            : Color(0xffC9C9C9),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.w,
                  ),
                  Row(
                    children: [
                      (logic.value3.value
                              ? Image(
                                  image: 'm_dg'.png3x,
                                  width: 25.w,
                                  height: 25.w,
                                )
                              : CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      BColors.mainColor),
                                  strokeWidth: 1.5,
                                  backgroundColor: Colors.grey[200],
                                ))
                          .withContainer(
                        alignment: Alignment.center,
                        width: 15.w,
                        height: 15.w,
                        margin: EdgeInsets.only(left: 80.w),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      BaseText(
                        text: '上月手机银行使用情况...',
                        color: logic.value3.value
                            ? Colors.black
                            : Color(0xffC9C9C9),
                      )
                    ],
                  ),
                ],
              ),
            );
    });
  }
}

class _IncomeExpenseChart extends StatefulWidget {
  final double width;
  final double height;

  const _IncomeExpenseChart({
    required this.width,
    required this.height,
  });

  @override
  State<_IncomeExpenseChart> createState() => _IncomeExpenseChartState();
}

class _IncomeExpenseChartState extends State<_IncomeExpenseChart> {
  final MonthInfoLogic logic = Get.find<MonthInfoLogic>();
  final MonthInfoState state = Get.find<MonthInfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    // 直接使用 state.trendList
    final trendList = state.trendList;
    
    if (trendList.isEmpty) {
      return Container(
        width: widget.width,
        height: widget.height,
        color: Colors.white,
      );
    }

    // 直接使用传入的数据，有多少展示多少
    List<MonthInfoIncomeExpenseAnalysisTrend> fullTrendList = List.from(trendList);

    // 如果还没有选中点，默认选中最后一个点（最新的数据在右边）
    if (state.touchedIndex == null && fullTrendList.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state.touchedIndex == null) {
          setState(() {
            state.touchedIndex = fullTrendList.length - 1;
          });
          logic.update(['updateUI']);
        }
      });
    }

    // 准备数据点（从右往左，最新的在右边）
    List<FlSpot> incomeSpots = [];
    List<FlSpot> expenseSpots = [];
    
    double maxY = 0;
    for (int i = 0; i < fullTrendList.length; i++) {
      final trend = fullTrendList[i];
      // 收入和支出都使用绝对值，确保都是正数显示
      final double income = trend.income.abs();
      final double expense = trend.expenses.abs();
      incomeSpots.add(FlSpot(i.toDouble(), income));
      expenseSpots.add(FlSpot(i.toDouble(), expense));
      maxY = [maxY, income, expense].reduce((a, b) => a > b ? a : b);
    }

    // 确保有足够的Y轴空间
    maxY = maxY * 1.2;

    // 计算图表宽度：一个屏幕显示5个数据点
    final int visibleDataCount = 5;
    final double pointSpacing = widget.width / visibleDataCount; // 每个数据点的间距
    final double chartWidth = fullTrendList.length * pointSpacing; // 图表总宽度

    return GetBuilder<MonthInfoLogic>(
      id: 'updateUI',
      builder: (_) {
        // 初始化滚动位置：从左边开始（最新数据在右边，从右往左展示）
        if (fullTrendList.length > visibleDataCount && 
            !state.chartScrollController.hasClients) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.chartScrollController.hasClients) {
              // 滚动到最右边，显示最新的5个数据点
              state.chartScrollController.jumpTo(
                state.chartScrollController.position.maxScrollExtent,
              );
            }
          });
        }

        return Container(
          width: widget.width,
          height: widget.height,
          color: Colors.white,
          clipBehavior: Clip.none, // 允许内容超出边界，确保月份显示
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            controller: state.chartScrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: chartWidth,
              height: widget.height,
              child: Stack(
                clipBehavior: Clip.none, // 允许内容超出边界，确保月份显示
                children: [
                  // 图表
                  SizedBox(
                    width: chartWidth,
                    height: widget.height,
                    child: LineChart(
                      _buildChartData(incomeSpots, expenseSpots, maxY, fullTrendList, pointSpacing),
                      key: const ValueKey('IncomeExpenseChart'),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                  // 工具提示框 - 显示选中点的收入支出信息，跟随选中点移动（在滚动视图内）
                  if (state.touchedIndex != null && 
                      state.touchedIndex! >= 0 && 
                      state.touchedIndex! < fullTrendList.length)
                    _buildTooltipPositioned(state.touchedIndex!, fullTrendList, incomeSpots, expenseSpots, maxY, pointSpacing),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  LineChartData _buildChartData(
    List<FlSpot> incomeSpots,
    List<FlSpot> expenseSpots,
    double maxY,
    List<MonthInfoIncomeExpenseAnalysisTrend> trendList,
    double pointSpacing,
  ) {
    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: false,
        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
          // 只在有有效交互时更新选中状态，点击后保持选中
          if (event.isInterestedForInteractions &&
              touchResponse != null &&
              touchResponse.lineBarSpots != null &&
              touchResponse.lineBarSpots!.isNotEmpty) {
            setState(() {
              state.touchedIndex = touchResponse.lineBarSpots!.first.spotIndex;
            });
            logic.update(['updateUI']);
          }
          // 不处理触摸结束事件，保持选中状态
        },
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: const Color(0xff0D703E),
                strokeWidth: 1,
                dashArray: [5, 5],
              ),
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
          final bool isTouched =
              state.touchedIndex != null && value.toInt() == state.touchedIndex;
          return FlLine(
            color: isTouched
                ? const Color(0xff0D703E)
                : const Color(0xffe7e8e8),
            strokeWidth: 1,
            dashArray: [5, 5],
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
            reservedSize: 50.w, // 使用响应式单位，增加预留空间，确保月份显示完整
            interval: 1,
            getTitlesWidget: (value, meta) {
              final int index = value.toInt();
              // 只显示整数索引的月份，避免显示边界外的值（如 -0.5 或 length-1+0.5）
              if (index < 0 || index >= trendList.length || value != value.toInt()) {
                return const SizedBox();
              }
              final trend = trendList[index];
              final bool isSelected =
                  state.touchedIndex != null && index == state.touchedIndex;
              try {
                DateTime dt = DateTime.parse(trend.dateTime);
                final String monthText = DateFormat('M月').format(dt);
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 10.w, // 月份文字距离轴线的间距，使用响应式单位
                  child: BaseText(
                    text: monthText,
                    style: TextStyle(
                      fontSize: 12.sp, // 使用响应式字体大小
                      color: isSelected
                          ? const Color(0xff111111)
                          : const Color(0xff999999),
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                );
              } catch (e) {
                // 如果日期解析失败，返回一个占位符用于调试
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 10.w,
                  child: BaseText(
                    text: '${index + 1}月',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xff999999),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: false, // 隐藏X轴线
      ),
      minX: 0,
      maxX: incomeSpots.isNotEmpty ? (incomeSpots.length - 1).toDouble() : 11,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        // 收入线（绿色）
        LineChartBarData(
          spots: incomeSpots,
          isCurved: true,
          preventCurveOverShooting: true,
          color: const Color(0xff0D703E), // 绿色
          barWidth: 2,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              final bool isSelected = index == state.touchedIndex;
              // 只显示选中的点的圆圈（最后一个点默认选中）
              if (!isSelected) {
                return FlDotCirclePainter(
                  radius: 0,
                  color: Colors.transparent,
                  strokeColor: Colors.transparent,
                  strokeWidth: 0,
                );
              }
              return FlDotCirclePainter(
                radius: 4,
                color: Colors.white,
                strokeColor: const Color(0xff0D703E),
                strokeWidth: 2,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
        ),
        // 支出线（橙色）
        LineChartBarData(
          spots: expenseSpots,
          isCurved: true,
          preventCurveOverShooting: true,
          color: const Color(0xffFF8C42), // 橙色
          barWidth: 2,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              final bool isSelected = index == state.touchedIndex;
              // 只显示选中的点的圆圈（最后一个点默认选中）
              if (!isSelected) {
                return FlDotCirclePainter(
                  radius: 0,
                  color: Colors.transparent,
                  strokeColor: Colors.transparent,
                  strokeWidth: 0,
                );
              }
              return FlDotCirclePainter(
                radius: 4,
                color: Colors.white,
                strokeColor: const Color(0xffFF8C42),
                strokeWidth: 2,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }


  Widget _buildTooltipPositioned(
    int index,
    List<MonthInfoIncomeExpenseAnalysisTrend> trendList,
    List<FlSpot> incomeSpots,
    List<FlSpot> expenseSpots,
    double maxY,
    double pointSpacing,
  ) {
    // 计算图表总宽度
    final double chartWidth = trendList.length * pointSpacing;
    if (index < 0 || index >= trendList.length) {
      return const SizedBox();
    }

    final trend = trendList[index];
    
    // 格式化金额显示
    final NumberFormat formatter = NumberFormat('#,###.00');
    final String incomeStr = formatter.format(trend.income.abs());
    final String expenseStr = formatter.format(trend.expenses.abs());
    
    // 使用 TextTool 测量实际文本宽度（考虑不同字符的实际宽度）
    final String incomeText = '收入 ¥$incomeStr';
    final String expenseText = '支出 ¥$expenseStr';
    
    // 测量文本实际宽度
    final Size incomeSize = TextTool.boundingTextSize(
      incomeText,
      fontSize: 12.sp,
    );
    
    final Size expenseSize = TextTool.boundingTextSize(
      expenseText,
      fontSize: 12.sp,
    );
    
    // 取较宽的文本宽度，加上图标、间距和padding
    final double maxTextWidth = incomeSize.width > expenseSize.width 
        ? incomeSize.width 
        : expenseSize.width;
    final double tooltipWidth = maxTextWidth + 40.w; // 40.w 是图标、间距和padding
    final double tooltipHeight = 70.w;
    
    // 计算选中点在图表中的X坐标位置（考虑滚动）
    final double chartHeight = widget.height;
    
    // 计算点在图表中的X坐标（基于pointSpacing）
    // 工具提示框现在在滚动视图内，所以直接使用图表内的坐标
    final double leftPadding = 50.w;
    final double pointX = leftPadding + (index * pointSpacing);
    // 计算选中点的Y坐标位置
    final double incomeY = incomeSpots[index].y;
    final double expenseY = expenseSpots[index].y;
    final double pointYValue = incomeY > expenseY ? incomeY : expenseY;
    
    final double chartTopPadding = 10.w;
    final double bottomPadding = 35.w;
    final double availableHeight = chartHeight - chartTopPadding - bottomPadding;
    final double relativeY = 1 - (pointYValue / maxY);
    final double pointY = chartTopPadding + relativeY * availableHeight;

    // 计算工具提示框位置（在滚动视图内，基于图表总宽度）
    final double spacing = 20.w;
    final double chartTotalWidth = chartWidth;
    final double minLeft = 10.w;
    final double maxRight = chartTotalWidth - 10.w;
    final double spaceOnLeft = pointX - minLeft;
    final double spaceOnRight = maxRight - pointX;
    
    double left;
    double leftIfRight = pointX + spacing;
    double leftIfLeft = pointX - tooltipWidth - spacing;
    bool preferRight = spaceOnRight >= spaceOnLeft;
    
    if (preferRight) {
      left = leftIfRight;
      if (left + tooltipWidth > maxRight) {
        left = leftIfLeft;
        if (left < minLeft) {
          left = leftIfRight;
        }
      }
    } else {
      left = leftIfLeft;
      if (left < minLeft) {
        left = leftIfRight;
        if (left + tooltipWidth > maxRight) {
          left = leftIfLeft;
        }
      }
    }
    
    // 边界处理，保持最小间距
    if (left < minLeft) {
      double minSpacing = 5.w;
      double idealLeft = pointX - tooltipWidth - minSpacing;
      left = idealLeft < minLeft ? idealLeft : idealLeft;
    }
    // 修复右侧贴边问题：确保工具提示框右边到图表右边界有间距
    if (left + tooltipWidth > maxRight - spacing) {
      // 如果工具提示框太靠近右边界，向左调整，保持间距
      double adjustedLeft = maxRight - tooltipWidth - spacing;
      // 如果调整后工具提示框左边到点的距离仍然足够，则使用调整后的位置
      if (adjustedLeft >= pointX + spacing || adjustedLeft >= pointX - tooltipWidth - spacing) {
        left = adjustedLeft;
      } else {
        // 如果调整后距离点太近，则保持原来的位置，但确保右边有间距
        // 如果原位置会超出边界，则强制调整
        if (left + tooltipWidth > maxRight) {
          left = maxRight - tooltipWidth - spacing;
        }
      }
    }
    
    // 垂直位置
    double top;
    final double topPadding = 10.w;
    final double availableSpaceAbove = pointY - topPadding;
    final double availableSpaceBelow = (chartHeight - bottomPadding) - pointY;
    
    if (availableSpaceAbove >= availableSpaceBelow) {
      top = pointY - tooltipHeight - 10.w;
      if (top < topPadding) {
        top = topPadding;
      }
    } else {
      top = pointY + 20.w;
      if (top + tooltipHeight > chartHeight - bottomPadding) {
        top = chartHeight - bottomPadding - tooltipHeight - 5.w;
      }
    }

    return Positioned(
      left: left,
      top: top,
      child: _buildTooltip(index, trendList),
    );
  }

  Widget _buildTooltip(int index, List<MonthInfoIncomeExpenseAnalysisTrend> trendList) {
    if (index < 0 || index >= trendList.length) {
      return const SizedBox();
    }
    final trend = trendList[index];
    final NumberFormat formatter = NumberFormat('#,###.00');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Color(0xff0D703E),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              BaseText(
                text: '收入 ¥${formatter.format(trend.income.abs())}',
                fontSize: 12,
                color: const Color(0xff333333),
              ),
            ],
          ),
          SizedBox(height: 6.w),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Color(0xffFF8C42),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              BaseText(
                text: '支出 ¥${formatter.format(trend.expenses.abs())}',
                fontSize: 12,
                color: const Color(0xff333333),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

