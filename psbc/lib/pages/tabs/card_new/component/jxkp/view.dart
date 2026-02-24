import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/config/abc_config/psbc_logic.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/pages/component/right_widget.dart';
import 'package:psbc/utils/stack_position.dart';

import 'logic.dart';
import 'state.dart';

class JskpPage extends BaseStateless {
  JskpPage({Key? key}) : super(title: '线上发卡新列表页');

  final JskpLogic logic = Get.put(JskpLogic());
  final JskpState state = Get.find<JskpLogic>().state;

  @override
  bool get isChangeNav => false;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    StackPosition stackPosition =
        StackPosition(designWidth: 634, designHeight: 3962, deviceWidth: 1.sw);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(children: [
          Image(
            image: 'card_page_8_1'.png3x,
            width: 1.sw,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            top: stackPosition.getY(7),
            left: stackPosition.getX(63),
            child: GetBuilder(
              builder: (PsbcLogic c) {
                return BaseText(
                  text: AppConfig.config.abcLogic.memberInfo.city,
                  color: Colors.black,
                  fontSize: 13.sp,
                );
              },
              id: 'updateUI',
            ),
          )
        ])
      ],
    );
  }
}
