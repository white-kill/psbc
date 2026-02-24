import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:psbc/utils/common_right_button.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image(
            image: 'home_ad_$index'.png3x,
            width: 1.sw,
            height: 120.w,
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        autoplay: true,
        onTap: (index) {
          if (index == 1) {
            Get.to(() => FixedNavPage(), arguments: {
              'image': 'home_ad_page_1',
              'title': '集蛇“邮”礼',
              'rightWidget': CommonRightButton.build([
                RightButtonConfig(type: RightButtonType.share),
              ]),
            });
          } else if (index == 2) {
            Get.to(() => FixedNavPage(), arguments: {
              'image': 'home_ad_page_2',
              'title': '邮享分 测分有礼',
              'rightWidget': [
                Image(
                  image: ('nav_mini_program').png,
                  width: 50.w,
                  height: 20.w,
                ).withPadding(right: 20.w, left: 0),
              ],
            });
          }
        }).withContainer(width: 1.sw, height: 120.w, color: Color(0xffF9F9FC));
  }
}
