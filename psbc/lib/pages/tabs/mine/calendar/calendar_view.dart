import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../component/right_widget.dart';

class CalendarPage extends BaseStateless {
  CalendarPage({Key? key}) : super(key: key, title: '待办日历');

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Widget initBody(BuildContext context) {
    DateTime _targetDateTime = DateTime.now();

    return Stack(
      children: [
        Image(image: "daiban".png3x, fit: BoxFit.fitWidth,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 月份选择器和待办列表
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BaseText(
                        text: DateFormat('yyyy年M月').format(_targetDateTime),
                        fontSize: 16,
                        color: Color(0xff333333),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff999999),
                        size: 20.w,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.format_list_bulleted,
                        color: Color(0xff333333),
                        size: 20.w,
                      ),
                      SizedBox(width: 4.w),
                      BaseText(
                        text: '待办列表',
                        fontSize: 14,
                        color: Color(0xff333333),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 日历组件
            Container(
              width: 1.sw,
              height: 260.w,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: CalendarCarousel(
                pageScrollPhysics: NeverScrollableScrollPhysics(),
                onDayPressed: (DateTime date, List events) {
                  // 日期点击事件
                },
                weekendTextStyle: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 13,
                  height: 1.0,
                ),
                thisMonthDayBorderColor: Colors.transparent,
                weekFormat: false,
                customGridViewPhysics: NeverScrollableScrollPhysics(),
                showHeader: false,
                todayTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.0,
                ),
                todayButtonColor: Colors.transparent,
                selectedDayTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.0,
                ),
                selectedDayButtonColor: Colors.transparent,
                prevDaysTextStyle: TextStyle(
                  color: Color(0xffCCCCCC),
                  fontSize: 13,
                  height: 1.0,
                ),
                nextDaysTextStyle: TextStyle(
                  color: Color(0xffCCCCCC),
                  fontSize: 13,
                  height: 1.0,
                ),
                daysTextStyle: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 13,
                  height: 1.0,
                ),
                weekdayTextStyle: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 13,
                  height: 1.0,
                ),
                headerTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                iconColor: Colors.black,
                childAspectRatio: 1.05,
                locale: 'zh',
                weekDayFormat: WeekdayFormat.narrow,
                customDayBuilder: (
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                    ) {
                  if (isToday) {
                    return Center(
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Color(0xFF136D45),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: BaseText(
                            text: '今',
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
