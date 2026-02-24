import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/bill_model.dart';
import '../bill_analyze/bill_analyze_view.dart';

class BillItemMothsWidget extends StatefulWidget {
  final int index;
  final BillList model;

  const BillItemMothsWidget(
      {super.key, required this.index, required this.model});

  @override
  State<BillItemMothsWidget> createState() => _BillItemMothsWidgetState();
}

class _BillItemMothsWidgetState extends State<BillItemMothsWidget> {

  double income = 0;
  double expenses = 0;

  String jieYu() {
    double _jy = income - expenses;
    if (_jy < 0) {
      return "- ¥${_jy.bankBalance.replaceAll('-', '')}";
    }
    return _jy.bankBalance;
  }

  @override
  void initState() {
    super.initState();
    income = widget.model.incomeTotal;
    expenses = widget.model.expensesTotal;
  }

  @override
  Widget build(BuildContext context) {
    bool noData = (income == 0 && expenses == 0);
    return Column(
      children: [
        widget.index == 0
            ? const SizedBox.shrink()
            : Container(
                width: 350.w,
                height: 10.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.w),
                      bottomRight: Radius.circular(12.w),
                    )),
              ),
        widget.index == 0
            ? const SizedBox.shrink()
            : SizedBox(
                height: 14.w,
                width: 1.sw,
              ),
        Container(
          width: 350.w,
          height: 103.h + (noData ? 60.w : 0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.w),
                  topRight: Radius.circular(12.w),
                ),
                child: Image(
                  image: 'bill_m_${widget.model.month}'.png,
                  width: 360.w,
                  height: 113.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: 5.w,
                  left: 17.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BaseText(
                            text: widget.model.month,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xff2E2E30),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          BaseText(
                            text: '月/${widget.model.year}',
                            fontSize: 12,
                            color: Color(0xff8E8E90),
                          ).withPadding(
                            top: 5.w,
                          ),
                        ],
                      ),
                      Container(
                        width: 65.w,
                        height: 26.w,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 18.w),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: 'szfx_item'.png3x,
                        )),
                        child: BaseText(
                          text: '收支分析',
                          fontSize: 10.w,
                          color: BColors.mainColor,
                        ),
                      ).withOnTap(onTap: () {
                        print(widget.model.toString());
                        if(int.parse(widget.model.month) < 10) {
                          Get.to(() => BillAnalyzePage(),arguments: {
                            'time':'${widget.model.year}-0${widget.model.month}',
                          });
                        }else{
                          Get.to(() => BillAnalyzePage(),arguments: {
                            'time':'${widget.model.year}-${widget.model.month}',
                          });
                        }
                      })
                    ],
                  ).withContainer(
                    width: 1.sw - 52.w,
                  )),
              Positioned(
                  top: 52.w,
                  left: 17.w,
                  child: Row(
                    children: [
                      _tagWidget(jieYu(), '结余', type: 'left').expanded(),
                      const BaseText(text: '=').withPadding(
                        right: 10.w,
                        left: 6.w,
                        bottom: 24.w,
                      ),
                      _tagWidget(
                              '¥${income.bankBalance}', '收入')
                          .expanded(),
                      const BaseText(text: '-').withPadding(
                        left: 10.w,
                        right: 6.w,
                        bottom: 24.w,
                      ),
                      _tagWidget('¥${expenses.bankBalance}',
                              '支出',
                              type: 'right')
                          .expanded(),
                    ],
                  ).withSizedBox(
                    width: 1.sw - 24.w - 34.w,
                  )),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 350.w,
                    height: 10.w + (noData ? 60.w : 0),
                    padding: EdgeInsets.only(top: 10.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.w),
                          topRight: Radius.circular(12.w),
                        )),
                    child: Center(
                      child: BaseText(
                        text: '本月暂无交易记录',
                        fontSize: 13,
                        color: Color(0xff999999),
                      ),
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget _tagWidget(String price, String name, {String type = 'center'}) {
    CrossAxisAlignment cross = CrossAxisAlignment.center;
    if (type == 'left') {
      cross = CrossAxisAlignment.start;
    }
    if (type == 'right') {
      cross = CrossAxisAlignment.end;
    }
    return Column(
      crossAxisAlignment: cross,
      children: [
        AutoScrollText(
          price,
          style: TextStyle(
              fontSize: 14,
              color: Color(0xff2E2E30),
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 6.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseText(
              text: name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xff2E2E30),
                fontSize: 14,
              ),
            )
          ],
        ),
      ],
    );
  }
}
