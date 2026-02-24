import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/utils/widget_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../../config/model/receipt_model.dart';
import '../../../../../../../config/model/record_list_model.dart';

class HdItemWidget1 extends StatefulWidget {
  final ReceiptList model;

  const HdItemWidget1({super.key, required this.model});

  @override
  State<HdItemWidget1> createState() => _HdItemWidget1State();
}

class _HdItemWidget1State extends State<HdItemWidget1> {

  String type(type){
    return '';
    if(type == '1'){
      return '+';
    }
    if(type == '2'){
      return '-';
    }
    return '+';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.w),
      padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 12.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.w))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            text: widget.model.excerpt,
            style: const TextStyle(fontSize: 16, color: Color(0xff333333)),
          ),
          SizedBox(
            height: 10.w,
          ),
          BaseText(
            text:widget.model.oppositeAccount.maskBankCardNumber(
              prefixLength: 4,
              fixStr: ' ',
              maskCharCount: 6,
            ),
          ),

          Container(
            width: 1.sw,
            height: 0.5.w,
            margin: EdgeInsets.only(top: 6.w,bottom: 10.w),
            color: Color(0xffdedede),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                text: widget.model.transactionTime,
                color: Color(0xff999999),
                fontSize: 13,
              ),

              BaseText(
                text: '${type(widget.model.detail.type??'')}¥${widget.model.amount.bankBalance}',
                fontSize: 15,
              ),
            ],
          )
        ],
      ),
    );
  }
}
