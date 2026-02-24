import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/print/component/bottom_widget.dart';
import 'package:psbc/pages/tabs/home/print/component/card_widget.dart';
import 'package:psbc/pages/tabs/home/print/component/more_widget.dart';
import 'package:psbc/pages/tabs/home/print/component/show_info_widget.dart';
import 'package:psbc/pages/tabs/home/print/component/time_widget.dart';
import 'package:psbc/pages/tabs/home/print/component/type_widget.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import 'print_logic.dart';
import 'print_state.dart';

class PrintPage extends BaseStateless {
  PrintPage({Key? key}) : super(key: key,title: '历史明细查询打印');

  final PrintLogic logic = Get.put(PrintLogic());
  final PrintState state = Get.find<PrintLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight + 20.w),
      children: [
        const CardWidget(),
        SizedBox(height: 14.w,),
        const TimeWidget(),
        SizedBox(height: 14.w,),
        const TypeWidget(),
        SizedBox(height: 14.w,),
        const ShowInfoWidget(),
        const MoreWidget(),
        const BottomWidget(),
      ],
    );
  }
}
