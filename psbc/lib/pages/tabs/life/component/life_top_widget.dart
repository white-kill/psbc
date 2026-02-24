import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/life/component/hdzq/hdzq_view.dart';
import 'package:psbc/utils/common_right_button.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../../config/app_config.dart';
import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';

class LifeTopWidget extends StatefulWidget {
  const LifeTopWidget({super.key});

  @override
  State<LifeTopWidget> createState() => _LifeTopWidgetState();
}

class _LifeTopWidgetState extends State<LifeTopWidget> {


  void jumpPage2(int idx) {
    print('jumpPage2: $idx');
    switch (idx) {
      case 0:
        // 智慧食堂
        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'zhst',
          'title': '智慧食堂',
        });
        return;
      case 1:
        // 邮政文创
        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'yzwc',
          'title': '邮政文创',
        });
        return;
      case 2:
        // 报刊订阅
        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'bkd',
          'title': '报刊订阅',
        });
        return;
      case 3:
        // 邮乐直播
        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'ylzb',
          'title': '邮乐直播',
        });
        return;
      case 4:
        // 车主生活
        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'czsh',
          'title': '车主生活',
        });
        return;
      case 5:
        // 旅游出行
        Get.to(() => ChangeNavPage(), arguments: {
          'image': 'lycx',
          'title': '旅游出行',
        });
        return;
      case 6:
        return;
      case 7:
        return;
      case 8:
        return;
      case 9:
        return;
      default:
        return;
    }
  }

  void jumpPage(int idx) {
    print(idx);
    switch (idx) {
      case 0:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'life_czth',
          'navColor':const Color(0xffEBF3EF),
          'background':Colors.white,
          'title':'页面跳转提示'
        });
        return;
      case 1:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'life_shjf',
          'navColor':const Color(0xffEBF3EF),
          'background':Colors.white,
          'title':'页面跳转提示'
        });
        return;
      case 2:
        Get.to(() => ChangeNavPage(),arguments: {
          'image':'life_bdfw',
          'background':Colors.white,
          'title': AppConfig.config.abcLogic.memberInfo.city,
        });
        return;
      case 3:
        Get.to(() => ChangeNavPage(),arguments: {
          'image':'life_bmfw',
          'defTitleColor':Colors.white,
          'background':Colors.white,
          'title':''
        });
        return;
      case 4:
        Get.to(() => LifeHdzqPage());
        return;
      case 5:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'life_zgyj',
          'navColor':const Color(0xffEBF3EF),
          'background':Colors.white,
          'title':'页面跳转提示'
        });
        return;
      case 6:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'life_dyp',
          'navColor':const Color(0xffEBF3EF),
          'background':Colors.white,
          'title':'页面跳转提示'
        });
        return;
      case 7:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'life_ylsc',
          'navColor':const Color(0xffEBF3EF),
          'background':Colors.white,
          'title':'页面跳转提示'
        });
        return;
      case 8:
        return;
      case 9:
        Get.to(() => FixedNavPage(),arguments: {
          'image':'shgd',
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
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return Stack(
      children: [
        SizedBox(
          height: 991/1080 *1.sw,
          width: 1.sw,
           child: Swiper(
             itemBuilder: (BuildContext context, int index) {
               return Image(
                 image: 'life_top${index + 1}'.png,
                 fit: BoxFit.fitWidth,
               ).withOnTap(onTap: () {
                 if (index == 0) {
                   // 第1个 - 跳转到 ChangeNavPage
                   Get.to(() => ChangeNavPage(), arguments: {
                     'image': 'life_top1',
                     'title': '页面跳转提示',
                     'rightWidget': CommonRightButton.build([
                       RightButtonConfig(type: RightButtonType.customerService),
                       RightButtonConfig(type: RightButtonType.home),
                     ]),
                   });
                 } else if (index == 1) {
                   // 第2个 - 跳转到 ChangeNavPage
                   Get.to(() => ChangeNavPage(), arguments: {
                     'image': 'life_top2',
                     'title': '页面跳转提示',
                     'rightWidget': CommonRightButton.build([
                       RightButtonConfig(type: RightButtonType.customerService),
                       RightButtonConfig(type: RightButtonType.home),
                     ]),
                   });
                 } else if (index == 2) {
                   // 第3个 - 跳转到 ChangeNavPage
                   Get.to(() => ChangeNavPage(), arguments: {
                     'image': 'life_top3',
                     'title': '页面跳转提示',
                     'rightWidget': CommonRightButton.build([
                       RightButtonConfig(type: RightButtonType.customerService),
                       RightButtonConfig(type: RightButtonType.home),
                     ]),
                   });
                 } else if (index == 3) {
                   // 第4个 - 跳转到 FixedNavPage，没有标题，右边是Home图标
                   Get.to(() => FixedNavPage(), arguments: {
                     'image': 'life_top4',
                     'title': '',
                     'rightWidget': CommonRightButton.build([
                       RightButtonConfig(type: RightButtonType.home),
                     ]),
                   });
                 }
               });
             },
             itemCount: 4,
             autoplay: true,
           ),
        ),
        Positioned(
            top: 120.w + navHeight,
            left: 16.w,
            child: SizedBox(
              width: 345.w,
              height: 167.w,
              child: Swiper(
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Image(
                        image: 'tag_widget${index + 1}'.png3x,
                        width: 345.w,
                        fit: BoxFit.fitWidth,
                      ),
                      // 第一张图使用 VerticalGridView
                      if (index == 0)
                        VerticalGridView(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 6.w),
                          widgetBuilder: (_, gridIndex) {
                            return SizedBox(
                              width: 45.w,
                              height: 45.w,
                            ).withOnTap(onTap: () => jumpPage(gridIndex));
                          },
                          itemCount: 10,
                          crossCount: 5,
                          mainHeight: 66.w,
                          spacing: 8.w,
                          crossSpacing: 8.w,
                        ).withContainer(
                          width: 342.w,
                          height: 167.w,
                        ),
                      // 第二张图使用 VerticalGridView
                      if (index == 1)
                        VerticalGridView(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 6.w),
                          widgetBuilder: (_, gridIndex) {
                            return SizedBox(
                              width: 45.w,
                              height: 45.w,
                            ).withOnTap(onTap: () => jumpPage2(gridIndex));
                          },
                          itemCount: 10,
                          crossCount: 5,
                          mainHeight: 66.w,
                          spacing: 8.w,
                          crossSpacing: 8.w,
                        ).withContainer(
                          width: 342.w,
                          height: 167.w,
                        ),
                    ],
                  );
                },
                itemCount: 2,
                autoplay: false,
              ),
            )),
      ],
    );
  }
}
