import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:psbc/utils/stack_position.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/common_right_button.dart';

class CardTopBannerWidget extends StatefulWidget {
  const CardTopBannerWidget({super.key});

  @override
  State<CardTopBannerWidget> createState() => _CardTopBannerWidgetState();
}

class _CardTopBannerWidgetState extends State<CardTopBannerWidget> {
  @override
  Widget build(BuildContext context) {
    StackPosition stackPosition =
        StackPosition(designWidth: 1080, designHeight: 1188, deviceWidth: 1.sw);
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Image(
              image: 'card_top_00${index + 1}'.png3x,
              width: 1.sw,
              height: stackPosition.getHeight(1188),
            ),
            Positioned(
                top: stackPosition.getY(200),
                left: 0,
                child: Container(
                  width: 1.sw,
                  height: stackPosition.getHeight(380),
                ).withOnTap(onTap: () {
                  print(index);
                  if(index == 0) {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'card_banner_001',
                      'title': '邮储车主卡权益升级',
                    });
                  }else if(index == 1) {

                  }else if(index == 2) {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'card_banner_003',
                      'title': '',
                      'rightWidget': CommonRightButton.build([
                        RightButtonConfig(type: RightButtonType.home),
                      ]),
                    });
                  }else {
                    Get.to(() => FixedNavPage(), arguments: {
                      'image': 'card_banner_004',
                      'title': '',
                      'rightWidget': CommonRightButton.build([
                        RightButtonConfig(type: RightButtonType.home),
                      ]),
                    });
                  }
                })),
            Positioned(
                top: stackPosition.getY(580),
                left: 0,
                child: Container(
                  width: 1.sw,
                  height: stackPosition.getHeight(380),
                ).withOnTap(onTap: () {
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'card_top_lmxyk',
                    'title': '2025年瑞幸卡5-12月...',
                  });
                })),
            Positioned(
                top: stackPosition.getY(960),
                left: 0,
                child: Container(
                  width: 1.sw,
                  height: stackPosition.getHeight(228),
                ).withOnTap(onTap: () {
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'card_top_lmxyk',
                    'title': '邮储信用卡新户见面礼',
                  });
                }))
          ],
        );
      },
      itemCount: 4,
      autoplay: true,
    ).withContainer(width: 1.sw, height: stackPosition.getHeight(1188));
  }
}
