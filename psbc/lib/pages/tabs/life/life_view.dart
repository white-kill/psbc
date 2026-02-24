import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/tabs/life/component/content_widget.dart';
import 'package:psbc/pages/tabs/life/component/life_top_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../config/abc_config/psbc_logic.dart';
import '../../component/placeholder_search_widget.dart';
import 'life_logic.dart';
import 'life_state.dart';

class LifePage extends BaseStateless {
  LifePage({Key? key}) : super(key: key);

  final LifeLogic logic = Get.put(LifeLogic());
  final LifeState state = Get.find<LifeLogic>().state;


  @override
  bool get isChangeNav => true;

  @override
  Widget? get titleWidget => Container(
    width: 1.sw,
    height: 32.w,
    child: Row(
      children: [
        SizedBox(
          width: 10.w,
        ),
        GetBuilder(builder: (PsbcLogic c){
          return Row(
            children: [
              Image(
                image: 'nav_left_loc'.png3x,
                width: 24.w,
                height: 24.w,
                color: Colors.black,
              ),
              BaseText(
                text: AppConfig.config.abcLogic.memberInfo.city,
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ],
          );
        },id: 'updateUI',),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: PlaceholderSearchWidget(
            width: 267.w,
            contentList: const ['账单', '优惠活动', '明细查询'],
            border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
            textColor: Colors.black,
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
      ],
    ),
  );

  @override
  Widget? get leftItem => Container();
  @override
  double? get lefItemWidth => 0;

  @override
  List<Widget>? get rightAction => [
    SizedBox(
      width: 10.w,
    ),
    Image(
      width: 38.w,
      height: 38.w,
      image: 'home_right_khfw'.png3x,
    ),
    SizedBox(
      width: 16.w,
    ),
  ];


  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        LifeTopWidget(),
        ContentWidget()
      ],
    );
  }
}
