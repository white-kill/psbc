import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/tabs/home/bill/bill_analyze/bill_analyze_view.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../mine_logic.dart';
import '../mine_state.dart';

class MineSzWidget extends StatefulWidget {
  const MineSzWidget({super.key});

  @override
  State<MineSzWidget> createState() => _MineSzWidgetState();
}

class _MineSzWidgetState extends State<MineSzWidget> {
  final double totalWidth = 296;
  double _width1 = 0;
  double _width2 = 0;

  void _calculateWidths() {
    double value1 = 1213.4;

    ///AppConfig.config.abcLogic.memberInfo.expensesTotal;
    double value2 = 1213.3;

    ///AppConfig.config.abcLogic.memberInfo.incomeTotal;
    double sum = value1 + value2;

    if (sum == 0) {
      setState(() {
        _width1 = totalWidth / 2;
        _width2 = totalWidth / 2;
      });
      return;
    }

    setState(() {
      _width1 = ((value1 / sum) * totalWidth).w;
      _width2 = ((value2 / sum) * totalWidth).w;
    });
  }

  Widget replaceAsterisksWithImages(String text) {
    final parts = text.split('*');
    final spans = <InlineSpan>[];

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(
        text: parts[i],
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ));
      if (i != parts.length - 1) {
        spans.add(WidgetSpan(
          child: Image(
            image: 'ic_mine_xin'.png3x,
            width: 10.w,
            height: 10.w,
          ).withPadding(left: 2.w, bottom: 4.w),
          alignment: PlaceholderAlignment.middle,
        ));
      }
    }

    return Text.rich(
      maxLines: 10,
      textAlign: TextAlign.right,
      TextSpan(children: spans),
    );
  }

  final MineLogic logic = Get.find<MineLogic>();
  final MineState state = Get.find<MineLogic>().state;

  @override
  void initState() {
    super.initState();
    _calculateWidths();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'mine_bysz'.png3x).withContainer(
            padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          bottom: 10.w,
        )).withOnTap(onTap: () {
          Get.to(() => BillAnalyzePage());
        }),
        Positioned(
            left: 20.w + 10.w,
            top: 86.w,
            child: Row(
              children: [
                Expanded(
                    child: Obx(() => logic.eyeImg.value == 'ic_key_open'
                        ? BaseText(
                            text:
                                "¥${AppConfig.config.abcLogic.memberInfo.expensesTotal.bankBalance}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ).withContainer(alignment: Alignment.centerLeft)
                        : replaceAsterisksWithImages('******')
                            .withContainer(alignment: Alignment.centerLeft))),
                Expanded(
                    child: Obx(() => logic.eyeImg.value == 'ic_key_open'
                        ? BaseText(
                            text:
                                "¥${AppConfig.config.abcLogic.memberInfo.incomeTotal.bankBalance}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ).withContainer(alignment: Alignment.centerRight)
                        : replaceAsterisksWithImages('******'))),
              ],
            ).withContainer(
              width: 315.w,
            )),
        Positioned(
          top: 121.w,
          left: 20.w + 15.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _width1,
                height: 4.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3.w),
                    bottomLeft: Radius.circular(3.w),
                    topRight: Radius.circular(_width2 > 0 ? 0 : 3.w),
                    bottomRight: Radius.circular(_width2 > 0 ? 0 : 3.w),
                  ),
                  color: Color(0xff376447),
                ),
              ),
              (_width1 == 0 || _width2 == 0)
                  ? SizedBox.shrink()
                  : Image(
                      image: 'ic_mine_pors'.png3x, width: 12.w, height: 4.w),
              Container(
                width: _width2,
                height: 4.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3.w),
                    bottomRight: Radius.circular(3.w),
                    topLeft: Radius.circular(_width1 > 0 ? 0 : 3.w),
                    bottomLeft: Radius.circular(_width1 > 0 ? 0 : 3.w),
                  ),
                  color: Color(0xffF78B67),
                ),
              ),
            ],
          ).withContainer(width: 308.w),
        )
      ],
    );
  }
}
