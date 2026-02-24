import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/bill_model.dart';
import '../../../../../utils/widget_util.dart';
import '../bill_logic.dart';
import '../bill_state.dart';

class BillItemRangeWidget extends StatefulWidget {
  final int index;
  final int total;
  final BillList model;

  const BillItemRangeWidget(
      {super.key, required this.index, required this.model, required this.total});

  @override
  State<BillItemRangeWidget> createState() => _BillItemRangeWidgetState();
}

class _BillItemRangeWidgetState extends State<BillItemRangeWidget> {



  final BillLogic logic = Get.find<BillLogic>();
  final BillState state = Get.find<BillLogic>().state;

  String jieYu() {
    double _jy = state.incomeTotalRange - state.expensesTotalRange;
    if (_jy < 0) {
      return "- ¥${_jy.bankBalance.replaceAll('-', '')}";
    }
    return _jy.bankBalance;
  }

  String type(type){
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
    return widget.index == 0
        ? Stack(
            children: [
              SizedBox(
                width: 1.sw,
                height: 253.w,
              ),
              Image(
                image: 'range_bill'.png3x,
              ),
              Positioned(
                top: 8.w,
                left: 12.w,
                child: BaseText(
                  text: '共${widget.total}笔交易',
                ),
              ),
              Positioned(
                  top: 50.w,
                  left: 17.w,
                  child: GetBuilder(builder: (BillLogic c){
                    return Row(
                      children: [
                        _tagWidget(jieYu(), '结余', type: 'left')
                            .expanded(),
                        const BaseText(text: '=').withPadding(
                          right: 10.w,
                          left: 6.w,
                          bottom: 24.w,
                        ),
                        _tagWidget(
                            '¥${state.incomeTotalRange.bankBalance}', '收入')
                            .expanded(),
                        const BaseText(text: '-').withPadding(
                          left: 10.w,
                          right: 6.w,
                          bottom: 24.w,
                        ),
                        _tagWidget('¥${state.expensesTotalRange.bankBalance}',
                            '支出',
                            type: 'right')
                            .expanded(),
                      ],
                    ).withSizedBox(
                      width: 1.sw - 24.w - 34.w,
                    );
                  },id: 'updateTopStatistics',)),
              Positioned(
                bottom: 0,
                child: _container(),
              )
            ],
          )
        : _container();
  }

  Widget _container() {
    return Container(
        padding: EdgeInsets.only(top: 8.w, bottom: 8.w, right: 13.w),
        color: Colors.white,
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
                      text: widget.model.day,
                      fontSize: 12,
                      color: Color(0xff8E8E91),
                    ),
                  ).withPadding(left: 20.w, bottom: 18.w, top: 8.w),
                  _itemContent(),
                ],
              ));
  }

  Widget _itemContent() {
    double amount = (widget.model.amount == ''?0:double.parse(widget.model.amount));
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
                  text: '${type(widget.model.type)}￥${amount.bankBalance.replaceAll('-', '')}',
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

  String _balance(String b) {
    if (b == '') return 0.0.bankBalance;
    return double.parse(b).bankBalance;
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
