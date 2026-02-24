import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/account/detail/component/detail_widget1.dart';
import 'package:psbc/pages/tabs/home/account/detail/component/detail_widget2.dart';
import 'package:psbc/pages/tabs/home/account/detail/component/detail_widget3.dart';
import 'package:psbc/pages/tabs/home/account/detail/component/detail_widget4.dart';
import 'package:psbc/pages/tabs/home/account/detail/component/detail_widget5.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../component/right_widget.dart';
import 'detail_logic.dart';
import 'detail_state.dart';

class DetailPage extends BaseStateless {
  DetailPage({Key? key}) : super(key: key,title: '账户详情');

  final DetailLogic logic = Get.put(DetailLogic());
  final DetailState state = Get.find<DetailLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  bool get isChangeNav => true;

  @override
  Color? get titleColor => Colors.black;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom: ScreenUtil().bottomBarHeight + 12.w),
      children: [
        Container(
          width: 1.sw,
          height: ScreenUtil().statusBarHeight,
          color: Colors.white,
        ),
        const DetailWidget1(),
        SizedBox(height: 10.w,),
        const DetailWidget2(),
        SizedBox(height: 10.w,),
        const DetailWidget3(),
        SizedBox(height: 10.w,),
        const DetailWidget4(),
        const DetailWidget5(),
      ],
    );
  }
}
