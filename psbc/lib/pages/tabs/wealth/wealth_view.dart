import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/tabs/wealth/component/wealth_function_widget.dart';
import 'package:psbc/pages/tabs/wealth/component/wealth_top_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../component/placeholder_search_widget.dart';
import '../../other/change_nav/change_nav_view.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import '../../other/tips_page/tips_page_view.dart';
import '../home/means/means_view.dart';
import 'wealth_logic.dart';
import 'wealth_state.dart';

class WealthPage extends BaseStateless {
  WealthPage({Key? key}) : super(key: key);

  final WealthLogic logic = Get.put(WealthLogic());
  final WealthState state = Get.find<WealthLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
        width: 225.w,
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
            image: 'home_left_msg'.png3x,
            color: Colors.black,
          ),
          SizedBox(width: 12.w),
        ],
      );

  @override
  List<Widget>? get rightAction => [
        SizedBox(
          width: 10.w,
        ),
        Image(
          width: 20.w,
          height: 20.w,
          image: 'home_right_add'.png3x,
        ),
        SizedBox(
          width: 12.w,
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
  Color? get background => const Color(0xffF9F9FC);

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const WealthTopWidget(),
        const WealthFunctionWidget(),
        Image(image: 'cf_b1'.png3x).withOnTap(onTap: () {
          Get.to(() => ChangeNavPage(),
              arguments: {'image': 'lcxkzx', 'title': '理财新客专享'});
        }),
        Image(image: 'cf_b2'.png3x).withOnTap(onTap: () {
          Get.to(() => ChangeNavPage(),
              arguments: {'image': 'rrh', 'title': '日日红'});
        }),
        Image(image: 'cf_b3'.png3x).withOnTap(onTap: () {
          Get.to(() => ChangeNavPage(),
              arguments: {'image': 'tty', 'title': '天天盈'});
        }),
        Stack(
          children: [
            Image(image: 'cf_b4'.png3x),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15.w),
                  width: 1.sw / 2 - 15.w,
                  height: 220.w,
                ).withOnTap(onTap: (){
                  String content = '尊敏的客户，您尚未进行风险测评'
                      '。根据监管要求，请您在投资交易前进行风险评估问卷。'
                      '完成风险测评后，可正常办理基金、理财、资管等投资交易'
                      '。是否现在评估?';
                  Get.to(() => TipsPagePage(),arguments: {
                    'title':'U航资配',
                    'content':content,
                    'cancel':'暂不评估',
                    'sure':'立即评估',
                    'sureColor':const Color(0xff9F7E50),
                  })?.then((v){
                    if(v){
                      Get.to(() => ChangeNavPage(),arguments: {
                        'image':'xyksq',
                        'title':'信用卡申请'
                      });
                    }
                  });
                }),
                Container(
                  margin: EdgeInsets.only(right: 15.w),
                  width: 1.sw / 2 - 15.w,
                  height: 220.w,
                ).withOnTap(onTap: (){
                  Get.to(() => ChangeNavPage(),arguments: {
                    'image':'xwlylzq',
                    'title':'U享未来养老专区'
                  });
                }),
              ],
            )
          ],
        ),
        Image(image: 'cf_b5'.png3x),
        Image(image: 'cf_b6'.png3x).withOnTap(onTap: () {
          Get.to(() => FixedNavPage(),
              arguments: {'image': 'ylzs', 'title': '邮料在售'});
        }),
      ],
    );
  }
}
