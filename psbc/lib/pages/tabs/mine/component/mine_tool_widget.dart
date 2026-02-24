import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../other/fixed_nav/fixed_nav_view.dart';

class MineToolWidget extends StatefulWidget {
  const MineToolWidget({super.key});

  @override
  State<MineToolWidget> createState() => _MineToolWidgetState();
}

class _MineToolWidgetState extends State<MineToolWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'mine_gjtj'.png3x).withContainer(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: 40.w,
            )),

        Positioned(
            left: 15.w,
            top: 50.w,
            child: Container(
              width: 1.sw - 30.w,
              height: 65.w,
              child: Row(
                children: [
                  Container().expanded(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'mine_fxpg',
                      'title': '风险评估',
                    });
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'mine_dzybk',
                      'title': '医保电子凭证',
                      'background': Colors.white,
                    });
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'mine_grxybgcx',
                      'title': '转账及限额管理',
                      'background': Colors.white,
                    });
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'mine_kjdzfp',
                      'title': '个人信息修改',
                      'background': Colors.white,
                    });
                  }),
                ],
              ),
            ))
      ],
    );
  }
}
