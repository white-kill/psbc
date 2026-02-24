import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../component/right_widget.dart';
import 'transfer_myself_logic.dart';
import 'transfer_myself_state.dart';

class TransferMyselfPage extends BaseStateless {
  TransferMyselfPage({super.key}) : super(title: '向我转账');

  final TransferMyselfLogic logic = Get.put(TransferMyselfLogic());
  final Transfer_myselfState state = Get.find<TransferMyselfLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Color? get titleColor => Colors.black;

  @override
  List<Widget>? get rightAction =>
      RightWidget.widget1(color: logic.navActionColor.value);

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'xwzz'.png3x),

            Positioned(
              top: 170.w,
              left: 1.sw/2 - 90.w,
              child: Image(image: 'xwzz_code'.png3x),width: 180.w,height: 180.w,),
            Positioned(
              right: 48.w,
              top: 1.sh / 2 + 24.w,
              child: BaseText(
                text: '邮政银行借记卡(${AppConfig.config.abcLogic.cardFour()})',
                fontSize: 15,
                color: Color(0xff333333),
              ),
            )
          ],
        )
      ],
    );
  }
}
