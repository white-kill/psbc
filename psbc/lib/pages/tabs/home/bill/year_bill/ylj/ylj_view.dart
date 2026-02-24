import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../../component/right_widget.dart';
import 'ylj_logic.dart';
import 'ylj_state.dart';

class YljPage extends BaseStateless {
  YljPage({Key? key}) : super(key: key,title: '养老金营销活动');

  final YljLogic logic = Get.put(YljLogic());
  final YljState state = Get.find<YljLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  
  @override
  Color? get navColor => Color(0xffFDF6E6 );
  
  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Image(image: 'bg_ylj'.png3x)
      ],
    );
  }
}
