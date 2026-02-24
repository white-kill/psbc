import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import 'zcxt_logic.dart';
import 'zcxt_state.dart';

class ZcxtPage extends BaseStateless {
  ZcxtPage({Key? key}) : super(key: key);

  final ZcxtLogic logic = Get.put(ZcxtLogic());
  final ZcxtState state = Get.find<ZcxtLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Color? get background => Colors.black;
  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 40.w),
      children: [
          Image(
            image: 'zgtx'.png3x,
            fit: BoxFit.fitWidth,
            width: 1.sw,
          ).withOnTap(onTap: () => Get.back())

      ],
    );
  }
}
