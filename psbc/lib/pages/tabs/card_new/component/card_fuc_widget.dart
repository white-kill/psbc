import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:psbc/utils/stack_position.dart';
import 'package:psbc/pages/other/change_nav/change_nav_view.dart';
import 'package:psbc/pages/other/image_view_page.dart';
import 'package:get/get.dart';
import '../card_logic.dart';

class CardFucWidget extends StatefulWidget {
  const CardFucWidget({super.key});

  @override
  State<CardFucWidget> createState() => _CardFucWidgetState();
}

class _CardFucWidgetState extends State<CardFucWidget> {
  late PageController _pageController;
  final CardLogic logic = Get.find<CardLogic>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // 初始化时设置为第一页的位置
    logic.updateColumnOffset(0.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    if (!_pageController.hasClients) return;
    // 获取当前页面索引和滚动进度
    double page = _pageController.page ?? 0.0;
    // page 值：0.0 表示第一页，1.0 表示第二页
    logic.updateColumnOffset(page);
  }

  @override
  Widget build(BuildContext context) {
    StackPosition stackPosition =
        StackPosition(designWidth: 1080, designHeight: 227, deviceWidth: 1.sw);
    return Container(
      color: Color(0XffFCFCFC),
      height: 417/1080 * 1.sw,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            _onScroll();
          }
          return false;
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (!mounted) return;
            // 页面切换完成时确保更新到正确位置
            logic.updateColumnOffset(index.toDouble());
          },
          children: [
            // 第一页
            Stack(
              children: [
                Image(
                  image: 'card_fuc_1'.png3x,
                  width: 1.sw,
                  fit: BoxFit.fitWidth,
                ),
                StackPositionGridWidget.custom(
                  stackPosition: stackPosition,
                  x: 0,
                  rightMargin: 0,
                  y: 0,
                  bottomMargin: 0,
                  crossCount: 5,
                  itemCount: 5,
                  onItemTap: (index) {
                    print(index);
                    // 根据序号处理每一行的点击事件
                    if (index == 0) {
                      Get.to(() => ImageViewPage(), arguments: {
                        'image': 'card_zdfq',
                      });
                    } else if (index == 1) {
                      Get.to(() => ChangeNavPage(), arguments: {
                        'image': 'card_zqh',
                        'title': '找钱花',
                      });
                    } else if (index == 2) {
                      Get.to(() => ChangeNavPage(), arguments: {
                        'image': 'card_xyksq',
                        'title': '信用卡申请',
                      });

                    } else if (index == 3) {
                      Get.to(() => ImageViewPage(), arguments: {
                        'image': 'card_jfzq',
                      });
                    } else {
                      Get.to(() => ChangeNavPage(), arguments: {
                        'image': 'card_wdxyk',
                        'title': '我的信用卡',
                      });
                    }
                  },
                ).build()
              ],
            ),
            // 第二页
            Image(
              image: 'card_fuc_2'.png3x,
              width: 1.sw,
              fit: BoxFit.fitWidth,
            ),
          ],
        ).withContainer(width: 1.sw, height: stackPosition.getHeight(227)),
      ),
    );
  }
}
