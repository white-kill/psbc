import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/bill/bill_analyze/bill_analyze_view.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../bill_logic.dart';
import '../bill_state.dart';

class TopStatisticsWidget extends StatefulWidget {
  const TopStatisticsWidget({super.key});

  @override
  State<TopStatisticsWidget> createState() => _TopStatisticsWidgetState();
}

class _TopStatisticsWidgetState extends State<TopStatisticsWidget> {
  final BillLogic logic = Get.find<BillLogic>();
  final BillState state = Get.find<BillLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (BillLogic c) {
        return Container(
          width: 1.sw,
          height: 38.w,
          padding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                // 阴影颜色（带透明度）
                offset: const Offset(0, 1),
                // 偏移：x=0（水平无偏移），y=4（向下偏移）
                blurRadius: 2,
                // 模糊半径（值越大阴影越模糊）
                spreadRadius: 0,
                // 扩散半径（可选，控制阴影大小）
                blurStyle: BlurStyle.normal, // 模糊样式（默认即可）
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BaseText(
                    text: '收入:¥${state.isMonth?state.incomeTotalMonth.bankBalance:state.incomeTotalRange.bankBalance}',
                    color: Color(0xff888888),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  BaseText(
                    text: '支出：¥${state.isMonth?state.expensesTotalMonth.bankBalance:state.expensesTotalRange.bankBalance}',
                    color: Color(0xff888888),
                  ),
                ],
              ),
              logic.showRange ?const SizedBox.shrink():Image(
                image: 'szfx_tag'.png3x,
                width: 50.w,
                height: 20.w,
              ).withOnTap( onTap: () {
                Get.to(() => BillAnalyzePage(),arguments: {
                  'time':state.dateTime,
                });
              }),
            ],
          ),
        );
      },
      id: 'updateTopStatistics',
    );
  }
}
