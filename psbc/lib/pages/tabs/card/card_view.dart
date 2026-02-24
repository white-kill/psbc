import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/card/component/ad_widget.dart';
import 'package:psbc/pages/tabs/card/component/card_function_widget.dart';
import 'package:psbc/pages/tabs/card/component/card_top_banner_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../component/placeholder_search_widget.dart';
import '../../other/tips_page/tips_page_view.dart';
import 'card_logic.dart';
import 'card_state.dart';

class CardPage extends BaseStateless {
  CardPage({Key? key}) : super(key: key);

  final CardLogic logic = Get.put(CardLogic());
  final CardState state = Get.find<CardLogic>().state;



  @override
  bool get isChangeNav => true;

  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
    width: 267.w,
    contentList: const ['账单', '优惠活动', '明细查询'],
    border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
    textColor: Colors.black,
  );

  @override
  Widget? get leftItem => Row(
    children: [
      SizedBox(width: 16.w),
      Image(
          width: 22.w,
          height: 22.w,
          image: 'ic_card_sys'.png3x,
          color: Colors.black),
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
    ),
    SizedBox(
      width: 16.w,
    ),
  ];

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // SizedBox(height: navHeight,),
        Image(image: 'card_nav'.png3x),
        const CardTopBannerWidget(),
        const CardFunctionWidget(),
        const AdWidget(),
        Image(image: 'bg_fqfw'.png3x).withOnTap(onTap: (){
          Get.to(() => TipsPagePage(),arguments: {
            'title':'账单分期',
            'content':'您名下无可提现本行卡',
            'showCancel':false,
          });
        }),
      ],
    );
  }
}
