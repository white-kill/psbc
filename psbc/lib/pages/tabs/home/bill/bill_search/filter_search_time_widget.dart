import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psbc/pages/component/sheet_widget/picker_widget.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/abc_button.dart';
import '../../../../../utils/time_tool.dart';
import 'bill_search_logic.dart';
import 'bill_search_state.dart';

extension DateTimeExtensions on DateTime {
  /// 获取当月的第一天
  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  /// 获取当月的最后一天
  DateTime get lastDayOfMonth {
    return DateTime(year, month + 1, 0);
  }
}

class FilterSearchTimeWidget extends StatefulWidget {
  const FilterSearchTimeWidget({super.key});

  @override
  State<FilterSearchTimeWidget> createState() => _FilterSearchTimeWidgetState();
}

class _FilterSearchTimeWidgetState extends State<FilterSearchTimeWidget> {
  final BillSearchLogic logic = Get.find<BillSearchLogic>();
  final BillSearchState state = Get.find<BillSearchLogic>().state;


  String timeType = '1';
  bool changeTag = true;

  List title = [
    '近一个月',
    '近三个月',
    '近半年',
    '近一年',
    '近两年',
  ];

  int monthInt(String title){
    switch (title) {
      case '近一个月':
        return 1;
      case '近三个月':
        return 3;
      case '近半年':
        return 6;
      case '近一年':
        return 12;
      case '近两年':
        return 24;
      default:
        return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    resetData();
  }

  void resetData(){
    if(state.isMonth){
      state.temMothTime = state.mothTime;
      String monthStr = state.mothTime;
      DateTime date = parseYearMonthString(monthStr);
      state.temBeginTime =  DateFormat('yyyy-MM-dd').format(date.firstDayOfMonth);
      state.temEndTime = DateFormat('yyyy-MM-dd').format(date.lastDayOfMonth);
      Future.delayed(const Duration(milliseconds: 200),(){
        state.mPickerNotifier.jumpTime(convertToDate(state.temMothTime));
      });
    }else{
      state.temTimeTitle = state.timeTitle;
      state.temBeginTime = state.beginTime;
      state.temEndTime = state.endTime;
      changeTag = false;
      Future.delayed(const Duration(milliseconds: 200),(){
        if(timeType == '1'){
          state.pickerNotifier.jumpTime(DateTime.parse(state.temBeginTime));
        }
        if(timeType == '2'){
          state.pickerNotifier.jumpTime(DateTime.parse(state.temEndTime));
        }
      }).then((v){
        Future.delayed(const Duration(milliseconds: 400),(){
          changeTag = true;
        });
      });
    }
  }


  DateTime parseYearMonthString(String monthStr) {
    try {
      List<String> parts = monthStr.split('-');
      if (parts.length != 2) {
        throw const FormatException('格式错误，应为 YYYY-MM');
      }

      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);

      if (month < 1 || month > 12) {
        throw const FormatException('月份必须在 1-12 之间');
      }

      return DateTime(year, month);
    } catch (e) {
      throw FormatException('无效的日期格式: $monthStr');
    }
  }

  DateTime convertToDate(String yearMonth) {
    List<String> parts = yearMonth.split('-');
    if (parts.length != 2) {
      throw FormatException('格式错误，请输入 yyyy-MM 格式的字符串');
    }

    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);

    // 创建 DateTime 对象（默认是当月第一天）
    return DateTime(year, month);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: Column(
        children: [
          Container(
            width: 1.sw,
            height: 60.w,
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(
                            text: "月份选择",
                            style: TextStyle(color: state.isMonth
                                    ? BColors.mainColor
                                    : Colors.black),),
                        SizedBox(
                          height: 10.w,
                        ),
                        Container(
                          width: 18.w,
                          height: 2.h,
                          decoration: BoxDecoration(
                              color: state.isMonth
                                  ? BColors.mainColor
                                  : Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(4.w))),
                        )
                      ],
                    ).withOnTap(onTap: () {
                      state.isMonth = true;
                      changeTag = false;
                      Future.delayed(const Duration(milliseconds: 200),(){
                        if(state.temMothTime != ''){
                          state.mPickerNotifier.jumpTime(convertToDate(state.temMothTime));
                        }
                      }).then((v){
                        Future.delayed(const Duration(milliseconds: 200),(){
                          changeTag = true;
                        });
                      });
                      setState(() {});
                    }),
                    SizedBox(
                      width: 45.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseText(
                          text: "自定义",
                          style: TextStyle(
                              color: !state.isMonth
                                  ? BColors.mainColor
                                  : Colors.black),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Container(
                          width: 18.w,
                          height: 2.h,
                          decoration: BoxDecoration(
                              color: !state.isMonth
                                  ? BColors.mainColor
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                        )
                      ],
                    ).withOnTap(onTap: () {
                      state.isMonth = false;
                      setState(() {});
                      changeTag = false;
                      Future.delayed(const Duration(milliseconds: 200),(){
                        if(timeType == '1'){
                          state.pickerNotifier.jumpTime(DateTime.parse(state.temBeginTime));
                        }
                        if(timeType == '2'){
                          state.pickerNotifier.jumpTime(DateTime.parse(state.temEndTime));
                        }
                      }).then((v){
                        Future.delayed(const Duration(milliseconds: 400),(){
                          changeTag = true;
                        });
                      });
                    }),
                  ],
                ),
                SizedBox(
                  width: 24.w,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          state.isMonth
              ? const SizedBox.shrink()
              : Container(
                  child: Column(
                    children: [
                      Container(
                        width: 1.sw,
                        padding: EdgeInsets.only(
                            left: 12.w, top: 12.w, bottom: 12.w),
                        alignment: Alignment.centerLeft,
                        child: BaseText(
                          text: '交易时间',
                          fontSize: 15,
                        ),
                      ),
                      VerticalGridView(
                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                        widgetBuilder: (_, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: state.temTimeTitle == title[index]
                                    ? BColors.mainColor.withOpacity(0.1)
                                    : const Color(0xffF7F7F9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.w))),
                            alignment: Alignment.center,
                            child: BaseText(
                              text: title[index],
                              style: TextStyle(
                                color: state.temTimeTitle == title[index]
                                    ? BColors.mainColor
                                    : Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ).withOnTap(onTap: () {
                            state.timeTitle = title[index];
                            Map<String,String> timeMap = DateRangeCalculator.getRecentMonthRange(monthInt(state.timeTitle));
                            state.temBeginTime = '';
                            state.temEndTime = '';
                            state.beginTime = timeMap['start']??'';
                            state.endTime = timeMap['end']??'';
                            Get.back();
                            logic.sureTimeButton();
                          });
                        },
                        itemCount: title.length,
                        crossCount: 3,
                        mainHeight: 32.w,
                        spacing: 10.w,
                        crossSpacing: 15.w,
                      ),
                      Container(
                        width: 1.sw,
                        height: 50.w,
                        padding: EdgeInsets.only(left: 12.w),
                        alignment: Alignment.centerLeft,
                        child: BaseText(
                          text: '自定义',
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150.w,
                            height: 36.w,
                            padding: EdgeInsets.only(left: 6.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w)),
                              color:timeType == '1'?BColors.mainColor.withOpacity(0.1):const Color(0xffF7F7F9),
                            ),
                            child: BaseText(
                              text: state.temBeginTime,
                              fontSize: 12.sp,
                              color: timeType == '1'?BColors.mainColor:Color(0xff9999999),
                            ),
                          ).withOnTap(onTap: () {

                            changeTag = false;
                            Future.delayed(const Duration(milliseconds: 200),(){
                              timeType = '1';
                              state.pickerNotifier.jumpTime(DateTime.parse(state.temBeginTime));
                              setState(() {});
                            }).then((v){
                              Future.delayed(const Duration(milliseconds: 400),(){
                                changeTag = true;
                              });
                            });

                          }),
                          Container(
                            width: 20.w,
                            // height: 1.w,
                            // color: const Color(0xff999999),
                            margin: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: BaseText(text: '至'),
                          ),
                          Container(
                            width: 150.w,
                            height: 36.w,
                            padding: EdgeInsets.only(left: 6.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w)),
                              color: timeType == '2'?BColors.mainColor.withOpacity(0.1):const Color(0xffF7F7F9),
                            ),
                            child: BaseText(
                              text: state.temEndTime,
                              fontSize: 12.sp,
                              color: timeType == '2'?BColors.mainColor:Color(0xff9999999),
                            ),
                          ).withOnTap(onTap: () {
                            changeTag = false;
                            Future.delayed(const Duration(milliseconds: 200),(){
                              timeType = '2';
                              state.pickerNotifier.jumpTime(DateTime.parse(state.temEndTime));
                              setState(() {});
                            }).then((v){
                              Future.delayed(const Duration(milliseconds: 400),(){
                                changeTag = true;
                              });
                            });
                          })
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 180.w,
                        child: DateTimePicker(
                          dateTimePickerNotifier: state.pickerNotifier,
                          onDateTimeChanged: (DateTime date) {
                            if(changeTag){
                              state.temTimeTitle = '';
                              if(timeType == '1'){
                                state.temBeginTime = DateFormat("yyyy-MM-dd").format(date);
                              }
                              if(timeType == '2'){
                                state.temEndTime = DateFormat("yyyy-MM-dd").format(date);
                              }
                              setState(() {});
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
          state.isMonth
              ? Container(
                  alignment: Alignment.center,
                  height: 160.w,
                  child: DateTimePicker(
                    dateTimePickerNotifier: state.mPickerNotifier,
                    showDay: false,
                    initialDateTime: parseYearMonthString(state.mothTime),
                    onDateTimeChanged: (DateTime date) {
                      if(changeTag){
                        state.temMothTime = DateFormat("yyyy-MM").format(date);
                        state.temTimeTitle = '';
                        String currentMonth = DateFormat('yyyy-MM').format(date);
                        var result1 = DateUtils.getFormattedFirstAndLastDay(currentMonth);
                        state.temBeginTime = result1['firstDay']??'';
                        state.temEndTime = result1['lastDay']??'';
                      }
                    },
                  ),
                )
              : Container(),
          SizedBox(
            height: 30.w,
          ),
          AbcButton(
            title: '确定',
            bgColor: BColors.mainColor,
            radius: 6.w,
            onTap: () {
              Get.back();
              if(state.isMonth){
                state.mothTime = state.temMothTime;
                DateTime date = parseYearMonthString(state.mothTime);
                state.beginTime =  DateFormat('yyyy-MM-dd').format(date.firstDayOfMonth);
                state.endTime = DateFormat('yyyy-MM-dd').format(date.lastDayOfMonth);
                state.temBeginTime = '';
              }else {
                state.timeTitle = state.temTimeTitle;
                state.beginTime = state.temBeginTime;
                state.endTime = state.temEndTime;
              }
              state.temBeginTime = '';
              state.temEndTime = '';
              logic.sureTimeButton();
            },
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
          ),
        ],
      ),
    );
  }
}
