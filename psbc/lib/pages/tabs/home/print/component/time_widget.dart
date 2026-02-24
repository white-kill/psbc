import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/time_tool.dart';
import '../../../../component/sheet_widget/picker.dart';
import '../../../../component/sheet_widget/picker_widget.dart';
import '../print_logic.dart';
import '../print_state.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({super.key});

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {

  final PrintLogic logic = Get.find<PrintLogic>();
  final PrintState state = Get.find<PrintLogic>().state;


  DateTimePickerNotifier pickerNotifier1 = DateTimePickerNotifier();
  DateTimePickerNotifier pickerNotifier2 = DateTimePickerNotifier();


  List timeTag = [
    '近一个月',
    '近三个月',
    '近六个月'
  ];
  String selectTime = '近六个月';

  int monthInt(String title){
    switch (title) {
      case '近一个月':
        return 1;
      case '近三个月':
        return 3;
      case '近六个月':
        return 6;
      default:
        return 1;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 200.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, right: 12.w,top: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          BaseText(text: '查询范围',style: TextStyle(
            color: Color(0xff2E2E30),
            fontSize: 15,
          ),),
          SizedBox(height: 20.w,),
          Row(
            children: timeTag.map((e){
              int index = timeTag.indexOf(e);
              bool isSel = selectTime == e;
              return Container(
                width: 105.w,
                height: 35.w,
                margin: EdgeInsets.only(left: index == 0?0:7.w,right: index == 0?2:7.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.w)),
                  color:isSel?BColors.mainColor.withOpacity(0.1):const Color(0xffF6F6FA),
                ),
                alignment: Alignment.center,
                child: BaseText(text: e,color: isSel?BColors.mainColor:const Color(0xff333333),),
              ).withOnTap(onTap: (){
                selectTime = e;
                Map<String,String> timeMap = DateRangeCalculator.getRecentMonthRange(monthInt(e));
                state.beginTime = timeMap['start']??'';
                state.endTime = timeMap['end']??'';
                state.reqPrint.endTime = state.endTime;
                state.reqPrint.beginTime = state.beginTime;
                setState(() {});
              });
            }).toList(),
          ),
          SizedBox(height: 5.w,),
          _itemWidget(title: '起始日期', content: state.beginTime)
              .withOnTap(onTap: () {
            AbcPicker.showNewTime(
                title: '',
                initialDateTime: DateFormat('yyyy-MM-dd').parse(state.beginTime),
                dateTimePickerNotifier: pickerNotifier1,
                minDateTime: DateTime(2014,11,1),
                onDateTimeChanged: (data){
                  state.beginTime = DateFormat('yyyy-MM-dd').format(data);
                  state.reqPrint.beginTime = state.beginTime;
                  selectTime = '';
                  setState(() {});
                }
            );
          }),
          Container(width: 360.w, height: 0.8.w, color: Color(0xffF4F4F6)),
          _itemWidget(
            title: '结束日期',
            content: state.endTime,
          ).withOnTap(onTap: () {
            AbcPicker.showNewTime(
                title: '',
                dateTimePickerNotifier: pickerNotifier1,
                minDateTime: DateTime(2014,11,1),
                initialDateTime: DateFormat('yyyy-MM-dd').parse(state.endTime),
                onDateTimeChanged: (data){
                  state.endTime = DateFormat('yyyy-MM-dd').format(data);
                  state.reqPrint.endTime = state.endTime;
                  selectTime = '';
                  setState(() {});
                }
            );
          }),
        ],
      ),
    );
  }

  Widget _itemWidget({String title = '', String content = '', Widget? child}) {
    return Container(
      height: 45.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BaseText(text: title, color: Color(0xff333333), fontSize: 15),
              SizedBox(width: 27.w,),
              child ??
                  BaseText(
                    text: content,
                    color: Color(0xff2E2E30),
                    fontSize: 15,
                  ),
            ],
          ),

          child == null
              ? Image(
            image: 'ic_jt_right'.png3x,
            width: 25.w,
            height: 25.w,
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}
