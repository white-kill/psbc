import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/component/ad_banner_widget.dart';
import 'package:psbc/pages/tabs/home/component/function_banner_widget.dart';
import 'package:psbc/pages/tabs/home/component/home_tab_widget.dart';
import 'package:psbc/pages/tabs/home/component/home_top_widget.dart';
import 'package:psbc/pages/tabs/home/two_level/two_level_view.dart';
import 'package:psbc/utils/scale_point_widget.dart';
import 'package:psbc/utils/widget_util.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/app_bar_widget.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../component/placeholder_search_widget.dart';
import '../../index/index_logic.dart';
import '../../other/change_nav/change_nav_view.dart';
import '../../other/customer_service/customer_service_view.dart';
import '../../other/fixed_nav/fixed_nav_view.dart';
import '../../other/tips_page/tips_page_view.dart';
import 'home_logic.dart';
import 'home_state.dart';

class HomePage extends BaseStateless {
  HomePage({Key? key}) : super(key: key);

  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
        width: 225.w,
        contentList: const ['账单', '优惠活动', '明细查询'],
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
        textColor: Colors.black,
      );

  @override
  Widget? get leftItem => Row(
        children: [
          SizedBox(width: 16.w),
          Obx(() {
            return Image(
                    width: 22.w,
                    height: 22.w,
                    image: 'home_left_msg'.png3x,
                    color: logic.navActionColor.value)
                .withOnTap(onTap: () {
              Get.to(() => ChangeNavPage(),
                  arguments: {'image': 'bg_msg', 'title': '消息'});
            });
          }),
          SizedBox(width: 12.w),
        ],
      );
  @override
  List<Widget>? get rightAction => [
        SizedBox(
          width: 10.w,
        ),
        Image(
          width: 38.w,
          height: 38.w,
          image: 'home_right_khfw'.png3x,
        ).withOnTap(onTap: () => Get.to(() => CustomerServicePage())),
        SizedBox(
          width: 12.w,
        ),
        Obx(() => ScalePointWidget(
              icColor: logic.navActionColor.value,
              left: 120.w,
              dx: 50.w,
              dy: 0.w,
              width: 140.w,
            )),
        SizedBox(
          width: 16.w,
        ),
      ];

  @override
  Function(bool change)? get onNotificationNavChange => (v) {
        logic.navActionColor.value = v ? Colors.black : Colors.white;
      };

  @override
  Color? get background => const Color(0xffF9F9FC);

  @override
  AppBarController? get appBarController => state.appBarController;

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder<HomeLogic>(builder: (logic) {
      return RefreshConfiguration.copyAncestor(
        context: context,
        enableScrollWhenTwoLevel: true,
        maxOverScrollExtent: 120,
        child: LayoutBuilder(builder: (_, __) {
          return SmartRefresher(
            header: TwoLevelHeader(
              textStyle: TextStyle(color: Colors.transparent),
              idleIcon: SizedBox.shrink(),
              displayAlignment: TwoLevelDisplayAlignment.fromBottom,
              decoration: BoxDecoration(
                color: Color(0xFF378BFF),
                image: DecorationImage(
                    image: 'home_two_transation'.png,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.bottomCenter),
              ),
              twoLevelWidget: TwoLevelPage(),
            ),
            controller: state.refreshController,
            enableTwoLevel: true,
            enablePullDown: false,
            enablePullUp: false,
            onTwoLevel: (bool isOpen) {
              final IndexLogic indexLogic = Get.find<IndexLogic>();
              indexLogic.showTabBar = !isOpen;
              indexLogic.update(['updateTabBar']);
              Future.delayed(
                  Duration(milliseconds: indexLogic.showTabBar ? 600 : 0),
                  () {
                    state.appBarController
                        .changeTabTitle(indexLogic.showTabBar);
                  });
            },
            child:  ListView(
              padding: EdgeInsets.zero,
              children: [
                const HomeTopWidget(),
                const FunctionBannerWidget(),
                Container(
                  width: 1.sw,
                  height: 55.w,
                  decoration: decorationImage('home_not_msg'),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 90.w),
                  child: BaseText(
                    text: '关于停止电子令牌发放，更换和使...',
                    fontSize: 13.sp,
                    color: Color(0xff4B4C4D),
                  ),
                ).withOnTap(onTap: () {
                  Get.to(() => ChangeNavPage(),
                      arguments: {'image': 'bg_msg', 'title': '消息'});
                }),
                const AdBannerWidget(),
                Stack(
                  children: [
                    Image(image: 'home_cfjx'.png3x),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w, top: 50.w),
                          width: 1.sw / 2 - 15.w,
                          height: 140.w,
                        ).withOnTap(onTap: () {
                          String content = '尊敏的客户，您尚未进行风险测评'
                              '。根据监管要求，请您在投资交易前进行风险评估问卷。'
                              '完成风险测评后，可正常办理基金、理财、资管等投资交易'
                              '。是否现在评估?';
                          Get.to(() => TipsPagePage(), arguments: {
                            'title': 'U航资配',
                            'content': content,
                            'cancel': '暂不评估',
                            'sure': '立即评估',
                            'sureColor': const Color(0xff9F7E50),
                          })?.then((v) {
                            if (v) {
                              Get.to(() => ChangeNavPage(),
                                  arguments: {'image': 'xyksq', 'title': '信用卡申请'});
                            }
                          });
                        }),
                        Container(
                          margin: EdgeInsets.only(left: 15.w, top: 50.w),
                          width: 1.sw / 2 - 15.w,
                          height: 140.w,
                        ).withOnTap(onTap: () {
                          Get.to(() => ChangeNavPage(),
                              arguments: {'image': 'xwlylzq', 'title': 'U享未来养老专区'});
                        }),
                      ],
                    )
                  ],
                ),
                const HomeTabWidget(),
                Stack(
                  children: [
                    Image(image: 'home_bottom_content'.png3x),

                    Positioned(top: 100.w,child: Container(
                      width: 1.sw,
                      height: 80.w,
                    ).withOnTap(onTap:  (){
                      Get.to(() => FixedNavPage(),arguments: {
                        'image':'yxd',
                        'title':'邮享贷'
                      });
                    })),

                    Positioned(top: 100.w + 130.w,child: Container(
                      width: 1.sw,
                      height: 80.w,
                    ).withOnTap(onTap:  (){
                      Get.to(() => ChangeNavPage(),arguments: {
                        'image':'jsd',
                        'title':'极速贷'
                      });
                    })),

                    Positioned(top: 100.w + 130.w + 120.w,child: Container(
                      width: 1.sw,
                      height: 80.w,
                    ).withOnTap(onTap:  (){
                      Get.to(() => ChangeNavPage(),arguments: {
                        'image':'ymztts_9',
                        'title':'邮你贷'
                      });
                    }))
                  ],
                )
              ],
            )
          );
        }),
      );
    });
  }
}
