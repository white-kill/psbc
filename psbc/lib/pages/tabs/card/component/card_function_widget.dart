import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/tips_page/tips_page_view.dart';
import 'package:psbc/pages/tabs/card/component/xykhh/xykhh_view.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';

class CardFunctionWidget extends StatefulWidget {
  const CardFunctionWidget({super.key});

  @override
  State<CardFunctionWidget> createState() => _CardFunctionWidgetState();
}

class _CardFunctionWidgetState extends State<CardFunctionWidget> {

  void jumpPage(int idx) {
    print(idx);
    switch (idx) {
      case 0:
        return;
      case 1:
        Get.to(() => XykhhPage());
        return;
      case 2:
      case 3:
        Get.to(() => TipsPagePage(),arguments: {
          'title':'账单分期',
          'content':'对不起，您还没有绑定信用卡账户，如需操作请先进入信用卡页面，添加所需要的信用卡账户。',
          'sure':'立即绑定',
        })?.then((v){
          if(v){
            Get.to(() => ChangeNavPage(),arguments: {
              'image':'xyksq',
              'title':'信用卡申请'
            });
          }
        });
        return;
      case 4:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'xykth',
          'title':'线上发卡'
        });
        return;
      case 5:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'yxfq',
          'title':'悦享分期'
        });
        return;
      case 6:
        Get.to(() => TipsPagePage(),arguments: {
          'title':'账单分期',
          'content':'您名下无可提现本行卡',
          'showCancel':false,
        });
        return;
      case 7:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'sy',
          'title':'积分专区'
        });
        return;
      case 8:
        //
        Get.to(() => ChangeNavPage(),arguments: {
          'image':'ymztts_8',
          'navColor':const Color(0xffEBF3EF),
          'background':Colors.white,
          'title':'页面跳转提示'
        });
        return;
      case 9:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'xykgd',
          'background':Colors.white,
          'title':'更多'
        });
        return;
      default:
        return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'card_f'.png3x),
        VerticalGridView(
          padding: EdgeInsets.only(left: 16.w,right: 16.w),
          widgetBuilder: (_, index) {
            return SizedBox(
              width: 45.w,
              height: 45.w,
            ).withOnTap(onTap: () => jumpPage(index));
          },
          itemCount: 10,
          crossCount: 5,
          mainHeight: 65.w,
          spacing: 12.w,
        )
      ],
    );
  }
}
