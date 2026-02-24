import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../component/right_widget.dart';
import 'bind_phone_logic.dart';
import 'bind_phone_state.dart';

class BindPhonePage extends BaseStateless {
  BindPhonePage({Key? key}) : super(key: key,title: '绑手机号收款');

  final BindPhoneLogic logic = Get.put(BindPhoneLogic());
  final BindPhoneState state = Get.find<BindPhoneLogic>().state;


  @override
  bool get isChangeNav => true;

  @override
  Color? get titleColor => Colors.black;

  @override
  List<Widget>? get rightAction => RightWidget.widget1(color: logic.navActionColor.value);

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'bdsjh'.png3x)
          ],
        )
      ],
    );
  }
}
