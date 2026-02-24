import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../component/right_widget.dart';
import 'delay_transfer_logic.dart';
import 'delay_transfer_state.dart';

class DelayTransferPage extends BaseStateless {
  DelayTransferPage({super.key}) : super(title: '延时转账明细');

  final Delay_transferLogic logic = Get.put(Delay_transferLogic());
  final Delay_transferState state = Get.find<Delay_transferLogic>().state;

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
            Image(image: 'yszzmx'.png3x)
          ],
        )
      ],
    );
  }
}
