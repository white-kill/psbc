import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:psbc/utils/widget_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/model/record_list_model.dart';

class RecordItemWidget extends StatefulWidget {
  final RecordListList model;

  const RecordItemWidget({super.key, required this.model});

  @override
  State<RecordItemWidget> createState() => _RecordItemWidgetState();
}

class _RecordItemWidgetState extends State<RecordItemWidget> {

  String type(type){
    if(type == '1'){
      return '+';
    }
    if(type == '2'){
      return '-';
    }
    return '+';
  }

  Color getAmountColor(String? type){
    if(type == '1'){
      return Color(0xffFD0100);
    }
    return Color(0xff333333);
  }
  
  String formatTransactionTime(String? transactionTime) {
    if (transactionTime == null || transactionTime.isEmpty) {
      return '';
    }
    try {
      // 将 2026/01/05 10:05:05 格式转换为 DateTime
      String normalizedTime = transactionTime.replaceAll('/', '-');
      DateTime dateTime = DateTime.parse(normalizedTime);
      // 格式化为 2026-01
      return DateFormat('yyyy-MM').format(dateTime);
    } catch (e) {
      return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.model.day != '' ? Container(
          width: 1.sw,
          height: 36.w,
          color: Color(0xffF7F7F7),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16.w),
          child: BaseText(
            text: formatTransactionTime(widget.model.detail?.transactionTime),
            fontSize: 14.sp,
            color: Color(0xff666666),
          ),
        ):const SizedBox.shrink(),
        Container(
          margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.w),
          padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 12.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.w))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  netImage(
                    url: widget.model.icon,
                    width: 28.w,
                    height: 28.w,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: widget.model.oppositeName,
                        style: const TextStyle(fontSize: 16, color: Color(0xff333333)),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      BaseText(
                        text: widget.model.detail?.transactionTime.replaceAll("/", "-") ?? "",
                        color: Color(0xff999999),
                        fontSize: 12,
                      ),
                    ],
                  ).withSizedBox(
                      width: 180.w
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BaseText(
                    text: '${type(widget.model.detail?.type??'')}¥${widget.model.amount.abs().bankBalance}',
                    fontSize: 15,
                    color: getAmountColor(widget.model.detail?.type),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  BaseText(
                    text: widget.model.detail?.type == '1' ? '他行汇入' : '已汇出',
                    color: Color(0xff999999),
                    fontSize: 12,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
