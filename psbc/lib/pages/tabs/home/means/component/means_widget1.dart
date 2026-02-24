import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:psbc/pages/other/change_nav/change_nav_view.dart';
import 'package:psbc/pages/tabs/home/transfer/thzayc/thzayc_view.dart';
import 'package:psbc/pages/tabs/home/transfer/transfer_view.dart';
import 'package:psbc/pages/tabs/home/bill/bill_view.dart';
import 'package:psbc/pages/tabs/home/account/detail/detail_view.dart';
import 'package:psbc/utils/stack_position.dart';
import 'package:psbc/utils/common_right_button.dart';

import '../../../../other/image_view_page.dart';
import '../../../../../config/app_config.dart';

class MeansWidget1 extends StatefulWidget {
  const MeansWidget1({super.key});

  @override
  State<MeansWidget1> createState() => _MeansWidget1State();
}

class _MeansWidget1State extends State<MeansWidget1> {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    StackPosition stackPosition =
        StackPosition(designWidth: 1040, designHeight: 3660, deviceWidth: 1.sw);
    return Column(
      children: [
        Stack(
          children: [
            showAll ?
            Image(image: 'ic_bottom_zc1_1'.png3x):Image(image: 'ic_bottom_zc1'.png3x),
            Positioned(
                top: 120.w,
                right: 35.w,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 12.w),
                      child: BaseText(
                        fontSize: 14.w,
                        text: '¥' + AppConfig.config.abcLogic.balance(),
                      ),
                    )
                  ],
                )
            ),
            Positioned(
                top: 110.w,
                right: 20.w,
                child: Container(
                  width: 1.sw - 40.w,
                  height: stackPosition.getHeight(100),
                ).withOnTap(onTap: () {
                  setState(() {
                    showAll = !showAll;
                  });
                })
            ),
            showAll ? Positioned(
                top: 160.w,
                right: 20.w,
                child: Container(
                  width: 1.sw - 40.w,
                  height: stackPosition.getHeight(100),
                ).withOnTap(onTap: () {
                  Get.to(() => DetailPage());
                })
            ): SizedBox.shrink(),
            showAll ?
            Positioned(
                top: 172.w,
                right: 35.w,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 12.w),
                      child: BaseText(
                        fontSize: 12.w,
                        text: '¥' + AppConfig.config.abcLogic.balance(),
                      ),
                    )
                  ],
                )
            ): SizedBox.shrink(),
            showAll ?
            Positioned(
                top: 172.w,
                left: 118.w,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 12.w),
                      child: BaseText(
                        fontSize: 12.w,
                        text: AppConfig.config.abcLogic.cardFour(),
                      ),
                    )
                  ],
                )
            ): SizedBox.shrink(),

            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100.w,
                  width: 1.sw,
                ).withOnTap(onTap: () {
                  Get.to(() => ChangeNavPage(),arguments: {
                    'image':'szrmb',
                    'title':'数字人民币'
                  });
                }))
          ],
        ),
        Stack(
          children: [
            Image(image: 'ic_bottom_zc2'.png3x),
            StackPositionGridWidget.custom(
              stackPosition: stackPosition,
              x: 18,
              rightMargin: 18,
              y: 288,
              bottomMargin: 2105,
              crossCount: 1,
              itemCount: 9,
              onItemTap: (index) {
                // 根据序号处理每一行的点击事件
                if (index == 0) {
                  // 第 1 行的点击事件 - 跳转到邮储快赎最快"次日达"
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'jjcp',
                    'title': '邮储快赎最快"次日达"',
                    'rightWidget': CommonRightButton.build([
                      RightButtonConfig(type: RightButtonType.customerService),
                      RightButtonConfig(type: RightButtonType.home),
                    ]),
                  });
                } else if (index == 1) {
                  // 第 2 行的点击事件 - 跳转到图片页面 (yyb@3x.png) 
                  Get.to(() => ImageViewPage(), arguments: {
                    'image': 'yyb',
                  });
                } else if (index == 2) {
                  // 第 3 行的点击事件 - 跳转到邮金GO
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'gjs',
                    'title': '邮金GO',
                    'rightWidget': CommonRightButton.build([
                      RightButtonConfig(type: RightButtonType.customerService),
                      RightButtonConfig(type: RightButtonType.home),
                    ]),
                  });
                } else if (index == 3) {
                  // 第 4 行的点击事件 - 跳转到理财产品
                  Get.to(() => ChangeNavPage(), arguments: {
                    'image': 'lccp',
                    'title': '理财产品',
                    'rightWidget': CommonRightButton.build([
                      RightButtonConfig(type: RightButtonType.customerService),
                      RightButtonConfig(type: RightButtonType.share),
                    ]),
                  });
                } else if (index == 4) {
                  // 第 5 行的点击事件 - 跳转到图片页面 (smcp@3x.png)
                  Get.to(() => ImageViewPage(), arguments: {
                    'image': 'smcp',
                  });
                } else if (index == 5) {
                  // 第 6 行的点击事件 - 跳转到图片页面 (gzcp@3x.png)
                  Get.to(() => ImageViewPage(), arguments: {
                    'image': 'gzcp',
                  });
                } else if (index == 6) {
                  // 第 7 行的点击事件 - 跳转到保险
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'bxcp',
                    'title': '保险',
                    'rightWidget': CommonRightButton.build([
                      RightButtonConfig(type: RightButtonType.customerService),
                      RightButtonConfig(type: RightButtonType.search),
                    ]),
                  });
                } else if (index == 7) {
                  // 第 8 行的点击事件 - 跳转到U享未来养老专区
                  Get.to(() => ChangeNavPage(), arguments: {
                    'image': 'grylj',
                    'title': 'U享未来养老专区',
                    'rightWidget': CommonRightButton.build([
                      RightButtonConfig(type: RightButtonType.customerService),
                      RightButtonConfig(type: RightButtonType.share),
                    ]),
                  });
                } else if (index == 8) {
                  // 第 9 行的点击事件 - 跳转到家族财富管理
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'jzxt',
                    'title': '家族财富管理',
                    'rightWidget': CommonRightButton.build([
                      RightButtonConfig(type: RightButtonType.customerService),
                      RightButtonConfig(type: RightButtonType.home),
                    ]),
                  });
                }
              },
            ).build(),
            Positioned(
                bottom: stackPosition.getX(1850),
                child: Container(
              height: 50.w,
              width: 1.sw,
            ).withOnTap(onTap: () {
                  // 外币 理财产品
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'lccs',
                    'title': '理财超市',
                    'rightWidget': CommonRightButton.build([
                      RightButtonConfig(type: RightButtonType.customerService),
                      RightButtonConfig(type: RightButtonType.home),
                    ]),
                  });

                })),
            StackPositionGridWidget.custom(
              stackPosition: stackPosition,
              x: 35,
              rightMargin: 35,
              y: 1964,
              bottomMargin: 1433,
              crossCount: 4,
              itemCount: 4,
              onItemTap: (index) {
                if (index == 0) {
                  // 他行转邮储
                  Get.to(() => ThzaycPage());
                } else if (index == 1) {
                  // 生活缴费
                  Get.to(() => ChangeNavPage(), arguments: {
                    'image': 'shjf',
                    'title': '生活缴费',
                  });
                } else if (index == 2) {
                  // 转账汇款
                  Get.to(() => TransferPage());
                } else if (index == 3) {
                  // 明细查询
                  Get.to(() => BillPage());
                }
              },
            ).build(),
          ],
        )
      ],
    );
  }
}
