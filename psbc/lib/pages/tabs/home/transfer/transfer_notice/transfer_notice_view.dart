import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../component/right_widget.dart';
import 'transfer_notice_logic.dart';
import 'transfer_notice_state.dart';

class TransferNoticePage extends BaseStateless {
  TransferNoticePage({Key? key}) : super(key: key, title: '通知收款人');

  final TransferNoticeLogic logic = Get.put(TransferNoticeLogic());
  final TransferNoticeState state = Get.find<TransferNoticeLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'bg_tzskr'.png),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.w,
                ),
                Row(
                  children: [
                    Image(
                      image: 'a_check'.png3x,
                      width: 18.w,
                      height: 18.w,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    BaseText(text: '交易已受理，请查询余额和交易明细'),
                  ],
                ),
                SizedBox(
                  height: 18.w,
                ),
                BaseText(
                  text: '${state.data.oppositeName}向您转账',
                  color: Color(0xff333333),
                ),
                SizedBox(
                  height: 6.w,
                ),
                BaseText(
                  text: '-￥${state.data.amount.bankBalance}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Column(
                  spacing: 12.w,
                  children: state.titles.map((e) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: e,
                            style: TextStyle(
                                fontSize: 12.w,
                                color: Color(0xff666666),
                                fontWeight: FontWeight.w500),
                          ),
                          BaseText(
                              text: logic.valueStr(e),
                              style: TextStyle(
                                  fontSize: 12.w,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    );
                  }).toList(),
                )
              ],
            ).withContainer(
              margin: EdgeInsets.only(left: 28.w, right: 28.w),
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
            )
          ],
        ),
        Image(image: 'buttom_tzskr'.png)
      ],
    );
  }
}
