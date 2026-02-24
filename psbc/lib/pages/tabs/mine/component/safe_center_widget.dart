import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../other/fixed_nav/fixed_nav_view.dart';

class SafeCenterWidget extends StatefulWidget {
  const SafeCenterWidget({super.key});

  @override
  State<SafeCenterWidget> createState() => _SafeCenterWidgetState();
}

class _SafeCenterWidgetState extends State<SafeCenterWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'mine_aqzx'.png3x).withContainer(
            padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          bottom: 10.w,
        )),
        Positioned(
            left: 15.w,
            child: SizedBox(
              width: 1.sw - 30.w,
              height: 45.w,
            ).withOnTap(onTap: () {
              Get.to(() => FixedNavPage(), arguments: {
                'image': 'main_aqzx',
                'title': '安全中心',
              });
            })),
        Positioned(
            left: 15.w,
            top: 130.w,
            child: Container(
              width: 1.sw - 30.w,
              height: 65.w,
              child: Row(
                children: [
                  Container().expanded(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'dlgl',
                      'title': '登录管理',
                    });
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'mine_zfgl',
                      'title': '支付管理',
                      'background': Colors.white,
                    });
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'mine_zzjxegl',
                      'title': '转账及限额管理',
                      'background': Colors.white,
                    });
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'mine_grxxxg',
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
