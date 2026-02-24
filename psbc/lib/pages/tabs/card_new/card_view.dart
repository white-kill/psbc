import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/tabs/card_new/component/card_top_banner_widget.dart';
import 'package:psbc/pages/tabs/card_new/component/card_fuc_widget.dart';
import 'package:psbc/config/abc_config/psbc_logic.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/pages/other/change_nav/change_nav_view.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:psbc/pages/other/image_view_page.dart';

import '../../component/placeholder_search_widget.dart';
import './component/djzt/view.dart';
import './component/jxkp/view.dart';
import 'card_logic.dart';
import 'card_state.dart';

class CardPage extends BaseStateless {
  CardPage({Key? key}) : super(key: key);

  final CardLogic logic = Get.put(CardLogic());
  final CardState state = Get.find<CardLogic>().state;

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
            GetBuilder(
              builder: (PsbcLogic c) {
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
              },
              id: 'updateUI',
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: PlaceholderSearchWidget(
                width: 267.w,
                contentList: const ['账单', '优惠活动', '明细查询'],
                border:
                    Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
                textColor: Colors.black,
              ),
            ),
            SizedBox(
              width: 10.w,
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
          width: 10.w,
        ),
        Image(
            width: 22.w,
            height: 22.w,
            image: 'ic_card_sys'.png3x,
            color: Colors.black),
        SizedBox(width: 16.w),
      ];

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const CardTopBannerWidget(),
          const CardFucWidget(),
          GetBuilder<CardLogic>(
            id: 'updateColumnPosition',
            builder: (logic) {
              // CardFucWidget 的高度
              double fucWidgetHeight = 417.0 / 1080.0 * 1.sw;
              // 基础偏移量（初始位置往上移动 1/2 高度）
              double baseOffset = -fucWidgetHeight / 2 + 10.w;
              // 根据滚动进度计算额外偏移量（最多移动 1/2 高度）
              double scrollOffset = logic.state.columnOffset * (fucWidgetHeight / 2 - 10.w);
              // 最终偏移量 = 基础偏移 + 滚动偏移
              double offset = baseOffset + scrollOffset;
              print('progress: ${logic.state.columnOffset}, offset: $offset');
              return Transform.translate(
                offset: Offset(0, offset),
                child: Column(
                  children: [
                  Image(
                    image: 'card_page_3'.png3x,
                    width: 1.sw,
                    fit: BoxFit.fitWidth,
                  ).withOnTap(onTap: () {
                    Get.to(() => ChangeNavPage(), arguments: {
                      'image': 'card_page_3_1',
                      'title': '页面跳转提示',
                    });
                  }),
                  Image(
                    image: 'card_page_4'.png3x,
                    width: 1.sw,
                    fit: BoxFit.fitWidth,
                  ).withOnTap(onTap: () {
                    Get.to(() => ImageViewPage(), arguments: {
                      'image': 'card_page_4_1',
                    });
                  }),
                  Image(
                    image: 'card_page_5'.png3x,
                    width: 1.sw,
                    fit: BoxFit.fitWidth,
                  ).withOnTap(onTap: () {
                    Get.to(() => DjztPage());
                  }),
                  Image(
                    image: 'card_page_6'.png3x,
                    width: 1.sw,
                    fit: BoxFit.fitWidth,
                  ).withOnTap(onTap: () {
                    Get.to(() => ImageViewPage(), arguments: {
                      'image': 'card_page_6_1',
                    });
                  }),
                  Image(
                    image: 'card_page_7'.png3x,
                    width: 1.sw,
                    fit: BoxFit.fitWidth,
                  ).withOnTap(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'card_page_7_1',
                      'title': '咖啡茶饮',
                    });
                  }),
                  Image(
                    image: 'card_page_8'.png3x,
                    width: 1.sw,
                    fit: BoxFit.fitWidth,
                  ).withOnTap(onTap: () {
                    Get.to(() => JskpPage());
                  }),
                ],
              ),
            );
            },
          )
        ],
      ),
    );
  }
}
