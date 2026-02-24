import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/utils/common_right_button.dart';
import 'package:psbc/utils/stack_position.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../tabs/home/account/account_view.dart';
import '../../tabs/home/means/means_view.dart';
import '../../tabs/home/transfer/transfer_view.dart';
import '../change_nav/change_nav_view.dart';
import '../fixed_nav/fixed_nav_view.dart';
import '../image_view_page.dart';
import 'customer_service_logic.dart';
import 'customer_service_state.dart';

class CustomerServicePage extends BaseStateless {
  CustomerServicePage({Key? key}) : super(key: key, title: '客服服务');

  final Customer_serviceLogic logic = Get.put(Customer_serviceLogic());
  final Customer_serviceState state = Get.find<Customer_serviceLogic>().state;

  @override
  Color? get navColor => const Color(0xffF0F9F8);

  @override
  List<Widget>? get rightAction => [
        Image(
            width: 22.w,
            height: 22.w,
            image: 'nav-kefu-right'.png3x,
            color: Colors.black),
        SizedBox(width: 16.w),
      ];

  // 构建短信通知页面内容：图片 + 银行卡号叠加
  Widget _buildSmsNotifyContent() {
    final cardNumber = AppConfig.config.abcLogic.card1();
    String formattedCard = '';
    if (cardNumber.isNotEmpty && cardNumber.length >= 10) {
      final prefix = cardNumber.substring(0, 4);
      final middle = cardNumber.length > 6 ? cardNumber.substring(4, 6) : '';
      final suffix = cardNumber.substring(cardNumber.length - 4);
      formattedCard = '$prefix $middle ********* $suffix';
    }
    return Stack(
      children: [
        Image(
          image: 'dxtz'.png3x,
          fit: BoxFit.fitWidth,
          width: 1.sw,
        ),
        Positioned(
          top: 7.w,
          left: 20.w,
          child: Center(
            child: BaseText(
              text: formattedCard,
              fontSize: 16.sp,
              color: Colors.black,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget initBody(BuildContext context) {
    // DateTime now = DateTime.now();
    // String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    StackPosition position =
        StackPosition(designWidth: 1080, designHeight: 2409, deviceWidth: 1.sw);
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Image(
                  image: 'kefu_1'.png3x,
                  width: 1.sw,
                  fit: BoxFit.fitWidth,
                ),
                StackPositionGridWidget(
                    stackPosition: position,
                    designX: 0,
                    designY: 372,
                    bottomMargin: 1634,
                    crossCount: 5,
                    itemCount: 10,
                    onItemTap: (index) {
                      switch (index) {
                        case 0: // 我的资产
                          Get.to(() => MeansPage());
                          break;
                        case 1: // 转账汇款
                          Get.to(() => TransferPage());
                          break;
                        case 2: // 我的账户
                          Get.to(() => AccountPage());
                          break;
                        case 3: // 网点查询
                          // TODO: 待添加网点查询页面
                          break;
                        case 4: // 元宇宙营业厅
                          Get.to(() => ImageViewPage(),
                              arguments: {'image': 'qmzl'});
                          break;
                        case 5: // 理财业务
                          Get.to(() => FixedNavPage(), arguments: {
                            'image': 'lcyw',
                            'title': '理财超市',
                            'rightWidget': CommonRightButton.build([
                              RightButtonConfig(
                                  type: RightButtonType.customerService),
                              RightButtonConfig(type: RightButtonType.home),
                            ]),
                          });
                          break;
                        case 6: // 短信通知（内容：图片 + 银行卡号叠加）
                          Get.to(() => FixedNavPage(), arguments: {
                            'title': '账户变动通知开通详情',
                            'rightWidget': CommonRightButton.build([
                              RightButtonConfig(
                                  type: RightButtonType.customerService),
                              RightButtonConfig(type: RightButtonType.home),
                            ]),
                            'contentWidget': _buildSmsNotifyContent(),
                          });
                          break;
                        case 7: // 云办理
                          Get.to(() => FixedNavPage(), arguments: {
                            'image': 'ybl',
                            'title': '云办理',
                            'rightWidget': CommonRightButton.build([
                              RightButtonConfig(
                                  type: RightButtonType.customerService),
                              RightButtonConfig(type: RightButtonType.home),
                            ]),
                          });
                          break;
                        case 8: // 远程客户经理
                          Get.to(() => ChangeNavPage(), arguments: {
                            'image': 'yckhjl',
                            'title': '远程客户经理',
                            'rightWidget': CommonRightButton.build([
                              RightButtonConfig(
                                type: RightButtonType.custom,
                                customWidget: Icon(
                                  Icons.more_horiz,
                                  size: 24.w,
                                  color: Colors.black,
                                ).withOnTap(onTap: () {
                                  // TODO: 显示更多菜单
                                }),
                              ),
                              RightButtonConfig(
                                type: RightButtonType.custom,
                                customWidget: Image(
                                  image: 'nav-kefu-right'.png3x, // 电话图标
                                  width: 22.w,
                                  height: 22.w,
                                  color: Colors.black,
                                ).withOnTap(onTap: () {
                                  // TODO: 拨打电话功能
                                }),
                              ),
                            ]),
                          });
                          break;
                        case 9: // 邮储直播
                          Get.to(() => FixedNavPage(), arguments: {
                            'image': 'yczb',
                            'title': '邮储直播',
                            'rightWidget': CommonRightButton.build([
                              RightButtonConfig(
                                  type: RightButtonType.customerService),
                              RightButtonConfig(type: RightButtonType.share),
                            ]),
                            // TODO: 左侧需要返回+关闭按钮，FixedNavPage 暂不支持自定义 leftItem
                            // 如需实现，可能需要扩展 FixedNavPage 或使用自定义页面
                          });
                          break;
                      }
                    }).build(),
                Positioned(
                    right: 0,
                    top: 280.w,
                    child: Container(
                      width: 100.w,
                      height: 50.w,
                    ).withOnTap(onTap: () {
                      Get.to(() => FixedNavPage(), arguments: {
                        'image': 'cjwt_gd',
                        'title': '全部问题',
                      });
                    }))
              ],
            )
          ],
        ).expanded(),
      ],
    );
  }
}
