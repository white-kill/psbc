import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psbc/pages/component/sheet_widget/picker_widget.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../utils/abc_button.dart';
import '../../../../../../utils/time_tool.dart';
import '../record_logic.dart';
import '../record_state.dart';

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

class FilterRecordTimeWidget extends StatefulWidget {
  const FilterRecordTimeWidget({super.key});

  @override
  State<FilterRecordTimeWidget> createState() => _FilterRecordTimeWidgetState();
}

class _FilterRecordTimeWidgetState extends State<FilterRecordTimeWidget> {
  final RecordLogic logic = Get.find<RecordLogic>();
  final RecordState state = Get.find<RecordLogic>().state;

  String timeType = '1';
  bool changeTag = true;

  List title = [
    '近一个月',
    '近三个月',
    '近半年',
    '近一年',
  ];

  int monthInt(String title) {
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

  void resetData() {
    if (state.isYear) {
      state.temYearTime = state.yearTime == ''?DateTime.now().year.toString():state.yearTime;
      String monthStr = state.yearTime == ''?DateTime.now().year.toString():state.yearTime;
      DateTime date = parseYearMonthString(monthStr);
      state.temBeginTime =
          DateFormat('yyyy-MM-dd').format(date.firstDayOfMonth);
      state.temEndTime = DateFormat('yyyy-MM-dd').format(date.lastDayOfMonth);
      Future.delayed(const Duration(milliseconds: 200), () {
        state.mPickerNotifier.jumpTime(convertToDate(state.temYearTime));
      });
    } else {
      state.temTimeTitle = state.timeTitle;
      state.temBeginTime = state.beginTime;
      state.temEndTime = state.endTime;
      changeTag = false;
      Future.delayed(const Duration(milliseconds: 200), () {
        if (timeType == '1') {
          state.pickerNotifier.jumpTime(DateTime.parse(state.temBeginTime));
        }
        if (timeType == '2') {
          state.pickerNotifier.jumpTime(DateTime.parse(state.temEndTime));
        }
      }).then((v) {
        Future.delayed(const Duration(milliseconds: 400), () {
          changeTag = true;
        });
      });
    }
  }

  DateTime parseYearMonthString(String dateStr) {
    try {
      // 去除首尾空格
      dateStr = dateStr.trim();

      List<String> parts = dateStr.split('-');

      if (parts.length == 1) {
        // 只有年份的情况，例如 "2022"
        int year = int.parse(parts[0]);
        // 获取当前日期
        DateTime now = DateTime.now();
        // 使用传入的年份，但保持当前月份和日期
        return DateTime(year, now.month, now.day);
      } else if (parts.length == 2) {
        // 年-月格式，例如 "2022-12"
        int year = int.parse(parts[0]);
        int month = int.parse(parts[1]);

        if (month < 1 || month > 12) {
          throw const FormatException('月份必须在 1-12 之间');
        }

        return DateTime(year, month);
      } else {
        throw const FormatException('格式错误，应为 YYYY 或 YYYY-MM');
      }
    } on FormatException {
      rethrow; // 重新抛出已经捕获的FormatException
    } catch (e) {
      throw FormatException('无效的日期格式: $dateStr', e);
    }
  }

  DateTime convertToDate(String dateStr) {
    // 去除首尾空格
    dateStr = dateStr.trim();

    List<String> parts = dateStr.split('-');

    if (parts.length == 1) {
      // 只有年份的情况
      int year = int.parse(parts[0]);
      // 获取当前日期
      DateTime now = DateTime.now();
      // 使用传入的年份，但保持当前月份和日期
      return DateTime(year, now.month, now.day);
    } else if (parts.length == 2) {
      // 年-月格式
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);

      if (month < 1 || month > 12) {
        throw FormatException('月份必须在 1-12 之间: $dateStr');
      }

      return DateTime(year, month);
    } else {
      throw FormatException('格式错误，请输入 YYYY 或 YYYY-MM 格式的字符串: $dateStr');
    }
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
                          text: "年份选择",
                          style: TextStyle(
                              color: state.isYear
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
                              color: state.isYear
                                  ? BColors.mainColor
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                        )
                      ],
                    ).withOnTap(onTap: () {
                      state.isYear = true;
                      changeTag = false;
                      Future.delayed(const Duration(milliseconds: 200), () {
                        state.mPickerNotifier
                            .jumpTime(convertToDate(state.temYearTime == ''?DateTime.now().year.toString():state.yearTime));
                      }).then((v) {
                        Future.delayed(const Duration(milliseconds: 400), () {
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
                              color: !state.isYear
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
                              color: !state.isYear
                                  ? BColors.mainColor
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                        )
                      ],
                    ).withOnTap(onTap: () {
                      state.isYear = false;
                      setState(() {});
                      changeTag = false;
                      Future.delayed(const Duration(milliseconds: 200), () {
                        if (timeType == '1') {
                          state.pickerNotifier
                              .jumpTime(DateTime.parse(state.temBeginTime));
                        }
                        if (timeType == '2') {
                          state.pickerNotifier
                              .jumpTime(DateTime.parse(state.temEndTime));
                        }
                      }).then((v) {
                        Future.delayed(const Duration(milliseconds: 400), () {
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
          state.isYear
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
                            Map<String, String> timeMap =
                                DateRangeCalculator.getRecentMonthRange(
                                    monthInt(state.timeTitle));
                            state.temBeginTime = '';
                            state.temEndTime = '';
                            state.beginTime = timeMap['start'] ?? '';
                            state.endTime = timeMap['end'] ?? '';
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
                              color: timeType == '1'
                                  ? BColors.mainColor.withOpacity(0.1)
                                  : const Color(0xffF7F7F9),
                            ),
                            child: BaseText(
                              text: state.temBeginTime,
                              fontSize: 12.sp,
                              color: timeType == '1'
                                  ? BColors.mainColor
                                  : Color(0xff9999999),
                            ),
                          ).withOnTap(onTap: () {
                            changeTag = false;
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              timeType = '1';
                              state.pickerNotifier
                                  .jumpTime(DateTime.parse(state.temBeginTime));
                              setState(() {});
                            }).then((v) {
                              Future.delayed(const Duration(milliseconds: 400),
                                  () {
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
                              color: timeType == '2'
                                  ? BColors.mainColor.withOpacity(0.1)
                                  : const Color(0xffF7F7F9),
                            ),
                            child: BaseText(
                              text: state.temEndTime,
                              fontSize: 12.sp,
                              color: timeType == '2'
                                  ? BColors.mainColor
                                  : Color(0xff9999999),
                            ),
                          ).withOnTap(onTap: () {
                            changeTag = false;
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              timeType = '2';
                              state.pickerNotifier
                                  .jumpTime(DateTime.parse(state.temEndTime));
                              setState(() {});
                            }).then((v) {
                              Future.delayed(const Duration(milliseconds: 400),
                                  () {
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
                            if (changeTag) {
                              state.temTimeTitle = '';
                              if (timeType == '1') {
                                state.temBeginTime =
                                    DateFormat("yyyy-MM-dd").format(date);
                              }
                              if (timeType == '2') {
                                state.temEndTime =
                                    DateFormat("yyyy-MM-dd").format(date);
                              }
                              setState(() {});
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
          state.isYear
              ? Container(
                  alignment: Alignment.center,
                  height: 160.w,
                  child: DateTimePicker(
                    dateTimePickerNotifier: state.mPickerNotifier,
                    showDay: false,
                    showMonth: false,
                    initialDateTime: parseYearMonthString(state.yearTime == ''
                        ? DateTime.now().year.toString()
                        : state.yearTime),
                    onDateTimeChanged: (DateTime date) {
                      if (changeTag) {
                        state.temYearTime = DateFormat("yyyy").format(date);
                        state.temTimeTitle = '';
                        String currentTime = DateFormat('yyyy-MM').format(date);
                        var result1 =
                            DateUtils.getFormattedFirstAndLastDay(currentTime);
                        state.temBeginTime = result1['firstDay'] ?? '';
                        state.temEndTime = result1['lastDay'] ?? '';
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
              if (state.isYear) {
                state.yearTime = state.temYearTime;
                state.temBeginTime = '';
                state.endTime = '${state.yearTime}-12-31';
                state.beginTime = '2020-01-01';
              } else {
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
