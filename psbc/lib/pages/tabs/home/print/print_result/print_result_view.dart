import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../utils/abc_button.dart';
import '../../../../../utils/color_util.dart';
import '../apply_record/apply_record_view.dart';
import 'print_result_logic.dart';
import 'print_result_state.dart';

class PrintResultPage extends BaseStateless {
  PrintResultPage({Key? key}) : super(key: key, title: '历史明细查询打印');

  final PrintResultLogic logic = Get.put(PrintResultLogic());
  final PrintResultState state = Get.find<PrintResultLogic>().state;

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 60.w,
        ),
        Image(
          image: 'dycg'.png3x,
          width: 120.w,
          height: 120.w,
        ),
        SizedBox(
          height: 30.w,
        ),
        BaseText(
          text: '申请成功',
          fontSize: 16,
        ).withContainer(width: 1.sw, alignment: Alignment.center),
        SizedBox(
          height: 20.w,
        ),
        (state.reqPrint.email == ''
                ? BaseText(
                    text: ''
                        '我行将尽快处理您的申请，'
                        '将于24小时内生成账户交易明细文件。'
                        '您可通过“历史明细查询打印——申请进度查询”查看处理状态和文件。',
                    maxLines: 10,
                    style: TextStyle(
                        fontSize: 14, color: Color(0xFF666666), height: 1.5),
                  )
                : buildDynamicRedText(logic.content))
            .withPadding(
          left: 12.w,
          right: 12.w,
        ),
        SizedBox(
          height: 30.w,
        ),
        AbcButton(
          title: '申请进度查询',
          margin: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
          ),
          width: 345.w,
          height: 45.w,
          radius: 4.w,
          onTap: () {
            Get.to(() => ApplyRecordPage());
          },
        ),
        SizedBox(
          height: 20.w,
        ),
        BaseText(
          text: '返回首页',
          color: Color(0xff333333),
        ).withContainer(
            width: 1.sw,
            alignment: Alignment.center,
            onTap: () {
              Get.offAllNamed(Routes.tabs);
            })
      ],
    );
  }

  Widget buildDynamicRedText(String fullText) {
    const baseStyle =
        TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5);
    const redStyle =
        TextStyle(fontSize: 14, color: BColors.mainColor, height: 1.5);

    // 提取目标文本（需根据实际规则匹配，示例仅演示）
    String email = state.reqPrint.email;
    String buttonName = "申请进度查询";

    // 拆分第一段
    String part1_1 = fullText.split(email)[0];
    String part1_2 = fullText.split(email)[1].split("2、")[0];
    // 拆分第二段
    String part2_1 = "2、" + fullText.split("2、")[1].split(buttonName)[0];
    String part2_2 = fullText.split(buttonName)[1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: part1_1, style: baseStyle),
              TextSpan(text: email, style: redStyle),
              TextSpan(text: part1_2, style: baseStyle),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: part2_1, style: baseStyle),
              TextSpan(text: buttonName, style: redStyle),
              TextSpan(text: part2_2, style: baseStyle),
            ],
          ),
        ),
      ],
    );
  }
}
