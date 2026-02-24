import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/mine/coupon/coupon_view.dart';
import 'package:psbc/pages/tabs/mine/mine_all/component/mine_all_top_widget.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';
import '../mine_all/mine_all_view.dart';

class MineFunctionWidget extends StatefulWidget {
  const MineFunctionWidget({super.key});

  @override
  State<MineFunctionWidget> createState() => _MineFunctionWidgetState();
}

class _MineFunctionWidgetState extends State<MineFunctionWidget> {
  void jumpPage(int tag) {
    switch (tag) {
      case 0:
        Get.to(() => ChangeNavPage(),
            arguments: {'image': 'mine_yfx', 'title': '邮享分'});
        return;
      case 1:
        Get.to(() => ChangeNavPage(),
            arguments: {'image': 'mine_tjpy', 'title': '推荐给朋友'});
        return;
      case 2:

        Get.to(() => ChangeNavPage(),
            arguments: {'image': 'mine_sz', 'title': '设置'});
        return;
      case 3:
        Get.to(() =>  MineAllPage());
        return;
      case 4:
        Get.to(() => ChangeNavPage(),
            arguments: {'image': 'mine_qyzq', 'title': '权益专区'});
        return;
      case 5:
        Get.to(() => CouponPage());
        return;
      case 6:
        Get.to(() => FixedNavPage(),
            arguments: {'image': 'mine_hdzq', 'title': '活动专区'});
        return;
      case 7:
        return;
      default:
        return;
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'bg_mine_f'.png3x).withContainer(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: 10.w,
            )),

        VerticalGridView(
          padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 10.w),
          widgetBuilder: (_, index) {
            return SizedBox(
              width: 45.w,
              height: 65.w,
            ).withOnTap(onTap: () => jumpPage(index));
          },
          itemCount: 8,
          crossCount: 4,
          mainHeight: 70.w,
          spacing: 5.w,
          crossSpacing: 5,
        )
      ],
    );
  }
}
