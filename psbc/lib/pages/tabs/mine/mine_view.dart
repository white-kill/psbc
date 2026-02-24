import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/login/login_view.dart';
import 'package:psbc/pages/tabs/mine/component/mine_event_widget.dart';
import 'package:psbc/pages/tabs/mine/component/mine_function_widget.dart';
import 'package:psbc/pages/tabs/mine/component/mine_means_widget.dart';
import 'package:psbc/pages/tabs/mine/component/mine_tool_widget.dart';
import 'package:psbc/pages/tabs/mine/component/mine_top_widget.dart';
import 'package:psbc/pages/tabs/mine/component/safe_center_widget.dart';
import 'package:psbc/utils/sp_util.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:psbc/pages/other/customer_service/customer_service_view.dart';

import '../../component/placeholder_search_widget.dart';
import '../../other/change_nav/change_nav_view.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import 'component/mine_sz_widget.dart';
import 'mine_logic.dart';
import 'mine_state.dart';

class MinePage extends BaseStateless {
  MinePage({Key? key}) : super(key: key);

  final MineLogic logic = Get.put(MineLogic());
  final MineState state = Get.find<MineLogic>().state;

  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
        width: 225.w,
        contentList: const ['账单', '优惠活动', '明细查询'],
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
        textColor: Colors.black,
      );

  
  @override
  bool get isChangeNav => true;

  @override
  Widget? get leftItem => Row(
        children: [
          SizedBox(width: 16.w),
          Obx(() {
            return Image(
                width: 18.w,
                height: 18.w,
                image: 'exit'.png3x,
                color: logic.navActionColor.value);
          }).withOnTap(onTap: () {
            ''.saveToken;
            Get.offAll(() => LoginPage());
          }),
          SizedBox(width: 12.w),
        ],
      );

  @override
  List<Widget>? get rightAction => [
        SizedBox(
          width: 10.w,
        ),
        Image(
          width: 38.w,
          height: 38.w,
          image: 'home_right_khfw'.png3x,
        ).withOnTap(onTap:() => Get.to(() => CustomerServicePage())),
        SizedBox(
          width: 12.w,
        ),
        Obx(() {
          return Image(
                  width: 22.w,
                  height: 22.w,
                  image: 'home_left_msg'.png3x,
                  color: logic.navActionColor.value)
              .withOnTap(onTap: () {
            Get.to(() => ChangeNavPage(),
                arguments: {'image': 'bg_msg', 'title': '消息'});
          });
        }),
        SizedBox(
          width: 16.w,
        ),
      ];

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const MineTopWidget(),
        const MineEventWidget(),
        const MineFunctionWidget(),
        const MineMeansWidget(),
        const MineSzWidget(),
        Image(image: 'mine_wdxyk'.png3x)
            .withContainer(
                padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          bottom: 10.w,
        ))
            .withOnTap(onTap: () {
          Get.to(() => FixedNavPage(),
              arguments: {'image': 'xykth', 'title': '线上发卡'});
        }),
        Image(image: 'mine_wddk'.png3x)
            .withContainer(
                padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          bottom: 10.w,
        ))
            .withOnTap(onTap: () {
          Get.to(() => ChangeNavPage(),
              arguments: {'image': 'dk', 'title': '贷款'});
        }),

        // Image(image: 'mine_wdwd'.png3x).withContainer(
        //     padding: EdgeInsets.only(
        //   left: 15.w,
        //   right: 15.w,
        //   bottom: 15.w,
        // )),
        const SafeCenterWidget(),
        const MineToolWidget(),
      ],
    );
  }
}
