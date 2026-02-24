import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/app_config.dart';
import '../card_transfer/component/account_transfer_widget.dart';

class MoneyWidget extends StatefulWidget {
  const MoneyWidget({super.key});

  @override
  State<MoneyWidget> createState() => _MoneyWidgetState();
}

class _MoneyWidgetState extends State<MoneyWidget> with WidgetsBindingObserver {


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

  TextEditingController moneyTextController = TextEditingController();
  FocusNode moneyFocusNode = FocusNode();
  String moneyStr = '';


  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0 && moneyFocusNode.hasFocus) {
      moneyTextController.text = moneyStr;
    }
    if (bottomInset == 0) {
      if (moneyStr != '') {
        String money = NumberFormat("#,##0.00", "zh_CN")
            .format(double.parse(moneyStr));
        moneyTextController.text = money;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      height: 165.w + 5.w ,
      color: Colors.white,
      margin: EdgeInsets.only(top: 15.w),
      child: Column(
        children: [
          BaseText(
            text: "转账金额",
            style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xff2E2E30),
                fontWeight: FontWeight.w500),
          ).withContainer(
              width: 1.sw,
              padding: EdgeInsets.only(top: 12.w, left: 15.w, bottom: 12.w)),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transfer.itemCellWidget(
                  title: "¥",
                  hintText: '免手续费 请输入转账金额',
                  controller: moneyTextController,
                  focusNode: moneyFocusNode,
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
                    setState(() {});
                  },
                 ),
              Container(
                margin: EdgeInsets.only(top: 10.w, left: 15.w),
                width: 1.sw,
                height: 1.w,
                color: const Color(0xffE7E9EB),
              ),
            ],
          )),
          Container(
            height: 60.w,
            padding: EdgeInsets.only(left: 15.w, right: 15.w,bottom: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BaseText(text: '付款卡号'),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Row(
                          children: [
                            Image(image: 'yz'.png3x,width: 17.w,height: 17.w,),
                            SizedBox(width: 6.w,),
                            BaseText(
                              text: '611798******1374',
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 4.w,),
                        Row(
                          children: [
                            BaseText(text: '可用余额 ',fontSize: 13.sp,color: Color(0xff8E8E92),),

                            BaseText(
                              text: '¥${AppConfig.config.abcLogic.balance()}元',
                              fontSize: 12.sp,
                              color: Color(0xffE1A14D),
                            )
                          ],
                        )

                      ],
                    ),
                  ],
                ),
                Image(
                  image: 'ic_jt_right'.png3x,
                  width: 25.w,
                  height: 25.w,
                ),
              ],
            ),
          )
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
