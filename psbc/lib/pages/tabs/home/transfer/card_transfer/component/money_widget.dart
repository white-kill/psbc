import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/app_config.dart';
import '../../../../../../utils/color_util.dart';
import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';
import 'account_transfer_widget.dart';

class MoneyWidget extends StatefulWidget {
  const MoneyWidget({super.key});

  @override
  State<MoneyWidget> createState() => _MoneyWidgetState();
}

class _MoneyWidgetState extends State<MoneyWidget> with WidgetsBindingObserver {
  final CardTransferLogic logic = Get.put(CardTransferLogic());
  final CardTransferState state = Get.find<CardTransferLogic>().state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0 && state.moneyFocusNode.hasFocus) {
      state.moneyTextController.text = state.moneyStr;
    }
    if (bottomInset == 0) {
      if (state.moneyStr != '') {
        String money = NumberFormat("#,##0.00", "zh_CN")
            .format(double.parse(state.moneyStr));
        state.moneyTextController.text = money;
      }
      logic.update(['updateCardTransfer']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      height: 110.w,
      color: Colors.white,
      margin: EdgeInsets.only(top: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                text: "转账金额",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff2E2E30),
                    fontWeight: FontWeight.w500),
              ).withContainer(
                  width: 1.sw - 100.w,
                  padding: EdgeInsets.only(top: 12.w, left: 15.w, bottom: 12.w)),
              Container(
                  margin: EdgeInsets.only(right: 20.w),
                  child: Image(image: "trans_limit".png3x, width: 80.w, fit: BoxFit.fitWidth,))
            ],
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transfer.itemCellWidget(
                  title: "¥",
                  hintText: '免手续费 请输入转账金额',
                  controller: state.moneyTextController,
                  focusNode: state.moneyFocusNode,
                  style: TextStyle(
                    fontSize: 27.sp,
                  ),
                  hintColor: Color(0xff9B9B9B),
                  textColor: const Color(0xff333333),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                    _DecimalTextInputFormatter(),
                    _MaxValueInputFormatter(1000000000), // 自定义的最大值限制
                  ],
                  onSubmitted: (v) {
                    logic.update(['updateBottom']);
                  },
                  onChanged: (value) {
                    state.moneyStr = value;
                    state.cardReq.amount = state.moneyStr;
                    logic.update(['updateBottom']);
                  }),
            ],
          )),
        ],
      ),
    );
  }
}

class _DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 如果新值包含多个小数点，则返回旧值
    if (newValue.text.split('.').length > 2) {
      return oldValue;
    }
    return newValue;
  }
}

// 自定义 TextInputFormatter 限制最大值
class _MaxValueInputFormatter extends TextInputFormatter {
  final double maxValue;

  _MaxValueInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    try {
      final number = double.parse(newValue.text);
      if (number > maxValue) {
        return oldValue; // 如果超过最大值，返回旧值
      }
      return newValue;
    } catch (e) {
      return oldValue;
    }
  }
}
