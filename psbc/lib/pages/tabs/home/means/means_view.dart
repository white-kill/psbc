import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/means/component/means_top_widget2.dart';
import 'package:psbc/pages/tabs/home/means/component/means_widget1.dart';
import 'package:psbc/pages/tabs/home/means/component/means_widget2.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../component/right_widget.dart';
import 'component/means_top_widget1.dart';
import 'means_logic.dart';
import 'means_state.dart';

class MeansPage extends BaseStateless {
  MeansPage({super.key}) : super(title: '我的资产');

  final MeansLogic logic = Get.put(MeansLogic());
  final MeansState state = Get.find<MeansLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get navColor => const Color(0xFFF5F5F5);

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight + 20.w),
      children: [
        Obx(() =>
        logic.showOne.value
            ? const MeansTopWidget1()
            : const MeansTopWidget2()
        ),
        Obx(() =>
        logic.showOne.value
            ? const MeansWidget1()
            : const MeansWidget2())
      ],
    );
  }
}
