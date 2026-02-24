import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/wealth/component/zcxt/zcxt_view.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../other/tips_page/tips_page_view.dart';

class WealthFunctionWidget extends StatefulWidget {
  const WealthFunctionWidget({super.key});

  @override
  State<WealthFunctionWidget> createState() => _WealthFunctionWidgetState();
}

class _WealthFunctionWidgetState extends State<WealthFunctionWidget> {

  void jumpPage(int idx) {
    print(idx);
    switch (idx) {
      case 0:
        Get.to(() => ChangeNavPage(),arguments: {
          'image':'bg_hoem_lc',
          'title':'理财'
        });
        return;
      case 1:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'home_jijin',
          'title':'基金'
        });
        return;
      case 2:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'bx',
          'title':'保险'
        });
        return;
      case 3:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'ck',
          'title':'存款'
        });
        return;
      case 4:
        Get.to(() => ZcxtPage());
        return;
      case 5:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'gjs_1',
          'title':'贵金属'
        });
        return;
      case 6:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'zq',
          'title':'债券'
        });
        return;
      case 7:
        Get.to(() => ChangeNavPage(),arguments: {
          'image':'xwlylzq',
          'title':'U享未来养老专区'
        });
        return;
      case 8:
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
        return;
      case 9:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'cfgd',
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
        Image(image: 'bg_wealth_tag'.png3x),
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
          mainHeight: 55.w,
          spacing: 12.w,
        )
      ],
    );
  }
}
