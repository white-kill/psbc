import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psbc/pages/tabs/home/component/top_banner_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:psbc/utils/common_right_button.dart';

import '../../../../utils/widget_util.dart';

class HomeTopWidget extends StatefulWidget {
  const HomeTopWidget({super.key});

  @override
  State<HomeTopWidget> createState() => _HomeTopWidgetState();
}

class _HomeTopWidgetState extends State<HomeTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 320.w,
      decoration: decorationImage('home_top_bg'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(width: 1.sw, height: 140.w).withOnTap(onTap: () {
            Get.to(() => FixedNavPage(), arguments: {
              'image': 'home_study',
              'title': '视频广场',
              'rightWidget': CommonRightButton.build([
                RightButtonConfig(type: RightButtonType.share),
              ]),
            });
          }),
          const TopBannerWidget(),
          SizedBox(
            height: 12.w,
          ),
        ],
      ),
    );
  }
}
