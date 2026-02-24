import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psbc/utils/widget_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/bill_model.dart';

class BillItemWidget extends StatefulWidget {
  final bool showRadius;
  final BillList model;

  const BillItemWidget(
      {super.key, required this.showRadius, required this.model});

  @override
  State<BillItemWidget> createState() => _BillItemWidgetState();
}

class _BillItemWidgetState extends State<BillItemWidget> {
  String type(type) {
    if (type == '1') {
      return '+';
    }
    if (type == '2') {
      return '-';
    }
    return '+';
  }

  String getDisplayDay() {
    if (widget.model.transactionTime.isEmpty) {
      return widget.model.day;
    }

    try {
      // 解析 transactionTime，格式为 "2016-05-12"
      DateTime transactionDate = DateTime.parse(widget.model.transactionTime);
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime yesterday = today.subtract(Duration(days: 1));
      DateTime transactionDay = DateTime(
          transactionDate.year, transactionDate.month, transactionDate.day);

      if (transactionDay == today) {
        return '今天';
      } else if (transactionDay == yesterday) {
        return '昨天';
      } else {
        return widget.model.day;
      }
    } catch (e) {
      // 如果解析失败，返回原始的 day 值
      return widget.model.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 8.w, bottom: 8.w, right: 10.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: widget.showRadius
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(12.w),
                    bottomRight: Radius.circular(12.w),
                  )
                : null),
        child: widget.model.day == ''
            ? _itemContent()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42.w,
                    height: 19.w,
                    decoration: BoxDecoration(
                        color: const Color(0xffF6F6F9),
                        borderRadius: BorderRadius.all(Radius.circular(3.w))),
                    alignment: Alignment.center,
                    child: BaseText(
                      text: getDisplayDay(),
                      fontSize: 12,
                      color: Color(0xff8E8E91),
                    ),
                  ).withPadding(left: 20.w, bottom: 18.w, top: 8.w),
                  _itemContent(),
                ],
              ));
  }

  String _balance(String b) {
    if (b == '') return 0.0.bankBalance;
    return double.parse(b).bankBalance;
  }

  Widget _itemContent() {
    double amount =
        (widget.model.amount == '' ? 0 : double.parse(widget.model.amount));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        netImage(
          url: widget.model.icon,
          width: 20.w,
          height: 20.w,
        ).withPadding(top: 13.w, left: 20.w, right: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: widget.model.merchantBranch == ''
                      ? widget.model.excerpt
                      : widget.model.merchantBranch,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xff2E2E30),
                  ),
                ).withContainer(width: 180.w),
                BaseText(
                  text:
                      '${type(widget.model.type)}￥${amount.bankBalance.replaceAll('-', '')}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff2E2E30)),
                )
              ],
            ).withContainer(
              width: 290.w,
            ),
            SizedBox(
              height: widget.model.merchantBranch == '' ? 0 : 12.w,
            ),
            widget.model.merchantBranch == ''
                ? SizedBox.shrink()
                : BaseText(
                    text: widget.model.excerpt,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff2E2E30)),
                  ),
            SizedBox(
              height: 12.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: '${widget.model.bankCard}  ${widget.model.time}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff8E8E91)),
                ),
                BaseText(
                  text: '余额 ¥${_balance(widget.model.accountBalance)}',
                  color: Color(0xff8E8E91),
                  fontSize: 12,
                )
              ],
            ).withContainer(
              width: 290.w,
            )
          ],
        ),
      ],
    );
  }
}
