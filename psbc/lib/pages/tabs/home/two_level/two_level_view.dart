import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/bill/bill_view.dart';
import 'package:psbc/utils/common_right_button.dart';
import 'package:psbc/utils/stack_position.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/customer_service/customer_service_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../other/image_view_page.dart';
import '../../mine/info/info_view.dart';
import '../../mine/mine_all/mine_all_view.dart';
import '../account/account_view.dart';
import '../home_logic.dart';
import '../means/means_view.dart';
import '../scan_widget/scan_widget_view.dart';
import '../transfer/transfer_view.dart';
import 'two_level_logic.dart';
import 'two_level_state.dart';

class TwoLevelPage extends StatelessWidget {
  const TwoLevelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TwoLevelLogic logic = Get.put(TwoLevelLogic());
    final TwoLevelState state = Get.find<TwoLevelLogic>().state;

    return Stack(
      children: [
        Container(
          width: 1.sw,
          height: 1.sh,
          child: PageView(
            controller: state.pageController,
            onPageChanged: (index) {
              logic.changePage(index);
            },
            children: [
              _buildPage1(context, logic, state),
              _buildPage2(context, logic, state),
            ],
          ),
        ),
        Positioned(
            top: 30.w,
            left: 0.w,
            child: SizedBox(
          width: 50.w,
          height: 50.w,
        ).withOnTap(onTap: () {
              Get.find<HomeLogic>().state.refreshController.twoLevelComplete();
            })),

        GetBuilder<TwoLevelLogic>(
          id: 'fullImage',
          builder: (_) {
            if (!state.showFullImage) return const SizedBox.shrink();
            return GestureDetector(
              onTap: () {
                logic.hideFullImage();
              },
              child: Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black.withOpacity(0.9),
                child: Center(
                  child: Image(
                    image: state.fullImageName.png,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPage1(
      BuildContext context, TwoLevelLogic logic, TwoLevelState state) {
    return Container(
      child: Stack(
        children: [
          Image(
            image: 'home_two_transation_1'.png,
            fit: BoxFit.fitWidth,
            width: 1.sw,
          ),


          Positioned(
            left: 95.w,
            top: 433.w,
            child: GetBuilder<TwoLevelLogic>(
              id: 'balanceDisplay',
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    logic.toggleBalance();
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Image(
                      image: state.showBalance ? 'home_two_on'.png : 'home_two_close'.png,
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 60.w,
            top: 488.w,
            child: GetBuilder<TwoLevelLogic>(
              id: 'balanceDisplay',
              builder: (_) {
                return Row(
                  children: [
                    BaseText(
                      text: state.showBalance 
                          ? '￥${state.expenditure.bankBalance}'
                          : '***',
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10.w),
                  ],
                );
              },
            ),
          ),
          Positioned(
            left: 60.w,
            top: 515.w,
            child: GetBuilder<TwoLevelLogic>(
              id: 'balanceDisplay',
              builder: (_) {
                return Row(
                  children: [
                    BaseText(
                      text: state.showBalance 
                          ? '￥${state.income.bankBalance}'
                          : '***',
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10.w),
                  ],
                );
              },
            ),
          ),

          /// 邮享分
          Positioned(
            bottom: 270.w,
            right: 0.w,
            child: Container(
              width: 200.w,
              height: 130.w,
            ).withOnTap(onTap: () {
              Get.to(() => ChangeNavPage(), arguments: {
                'image': 'yxf',
                'title': '邮享分',
                'rightWidget': CommonRightButton.build([
                  RightButtonConfig(type: RightButtonType.customerService),
                  RightButtonConfig(type: RightButtonType.home),
                ]),
              });
            }),
          ),

          /// 元宇宙小家（图片页，点击退出）
          Positioned(
            bottom: 100.w,
            right: 0.w,
            child: Container(
              width: 200.w,
              height: 160.w,
            ).withOnTap(onTap: () {
              Get.to(() => ImageViewPage(), arguments: {'image': 'wdxj'});
            }),
          ),
          /// 元宇宙营业厅（图片页，点击退出）
          Positioned(
            bottom: 100.w,
            left: 0.w,
            child: Container(
              width: 200.w,
              height: 160.w,
            ).withOnTap(onTap: () {
              Get.to(() => ImageViewPage(), arguments: {'image': 'qmzl'});
            }),
          ),

          /// 我的金融画像
          Positioned(
            top: 200.w,
            right: 0.w,
            child: Container(
              width: 200.w,
              height: 130.w,
            ).withOnTap(onTap: () {
              Get.to(() => ChangeNavPage(), arguments: {
                'image': 'jrhx',
                'title': '我的金融画像',
                'defTitleColor': Colors.white,
                'rightWidget': CommonRightButton.build([
                  RightButtonConfig(type: RightButtonType.customerService),
                  RightButtonConfig(
                      type: RightButtonType.home, iconColor: Colors.white),
                ]),
              });
            }),
          ),

          Positioned(
            bottom: 30.w,
            left: 160.w,
            child: Container(
              width: 50.w,
              height: 50.w,
            ).withOnTap(onTap: () {
              Get.find<HomeLogic>().state.refreshController.twoLevelComplete();
            }),
          ),

          Positioned(
              top: 30.w,
              right: 0.w,
              child: SizedBox(
                width: 50.w,
                height: 50.w,
              ).withOnTap(onTap: () {
                logic.toggleMoreImage();
              })),
          GetBuilder<TwoLevelLogic>(
            id: 'moreImage',
            builder: (_) {
              if (!state.showMoreImage) return const SizedBox.shrink();
              return Stack(
                children: [
                  // 全屏透明遮罩，点击时隐藏图片
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        logic.toggleMoreImage();
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  // 更多菜单（背景图 + 6个按钮）
                  Positioned(
                    top: 90.w,
                    right: 10.w,
                    child: _buildMoreMenuContent(logic),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPage2(
      BuildContext context, TwoLevelLogic logic, TwoLevelState state) {
    StackPosition position = StackPosition(designWidth: 1080, designHeight: 2376, deviceWidth: 1.sw);
    return Container(
      color: const Color(0xFF5A9BFF),
      child: Stack(
        children: [
          Image(
            image: 'home_two_transation_2'.png,
            fit: BoxFit.fitWidth,
            width: 1.sw,
          ),

          Positioned(
            top: 30.w,
            right: 0.w,
            child: SizedBox(
              width: 50.w,
              height: 50.w,
            ).withOnTap(onTap: () {
              logic.toggleMoreImage();
            }),
          ),
          GetBuilder<TwoLevelLogic>(
            id: 'moreImage',
            builder: (_) {
              if (!state.showMoreImage) return const SizedBox.shrink();
              return Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        logic.toggleMoreImage();
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90.w,
                    right: 10.w,
                    child: _buildMoreMenuContent(logic),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 380.w,
            child: _buildCalendar(),
          ),
          
          StackPositionGridWidget(stackPosition: position, designX: 0, designY: 1640, bottomMargin: 315, crossCount: 4, itemCount: 8,
          onItemTap: (int index) {
            switch (index) {
              case 0: // 我的账户
                Get.to(() => AccountPage());
                break;
              case 1: // 转账汇款
                Get.to(() => TransferPage());
                break;
              case 2: // 我的资产
                Get.to(() => MeansPage());
                break;
              case 3: // 明细查询
                Get.to(() => BillPage());
                break;
              case 4: // 贷款
                Get.to(() => ChangeNavPage(), arguments: {
                  'image': 'dk',
                  'title': '贷款'
                });
                break;
              case 5: // 理财
                Get.to(() => ChangeNavPage(), arguments: {
                  'image': 'bg_hoem_lc',
                  'title': '理财'
                });
                break;
              case 6: // 一键绑卡
                Get.to(() => FixedNavPage(), arguments: {
                  'image': 'yjbk',
                  'title': '一键绑卡'
                });
                break;
              case 7: // 全部
                Get.to(() => MineAllPage());
                break;
            }
          }
          ).build(),
          Positioned(
            bottom: 30.w,
            left: 160.w,
            child: Container(
              width: 50.w,
              height: 50.w,
            ).withOnTap(onTap: () {
              Get.find<HomeLogic>().state.refreshController.twoLevelComplete();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreMenuContent(TwoLevelLogic logic) {
    const List<Map<String, dynamic>> menuItems = [
      {'title': '个人资料', 'page': 'info'},
      {'title': '客服', 'page': 'customer'},
      {'title': '消息', 'page': 'message'},
      {'title': '公告', 'page': 'announce'},
      {'title': '设置', 'page': 'setting'},
      {'title': '扫一扫', 'page': 'scan'},
    ];
    return Container(
      width: 100.w,
      height: 240.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: 'home_two_more'.png,
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: menuItems.map((item) {
          return GestureDetector(
            onTap: () {
              logic.toggleMoreImage();
              switch (item['page']) {
                case 'info':
                  Get.to(() => InfoPage());
                  break;
                case 'customer':
                  Get.to(() => CustomerServicePage());
                  break;
                case 'message':
                  Get.to(() => ChangeNavPage(),
                      arguments: {'image': 'bg_msg', 'title': '消息'});
                  break;
                case 'announce':
                  Get.to(() => FixedNavPage(), arguments: {
                    'image': 'gg',
                    'title': '小邮公告',
                    'rightWidget': CommonRightButton.build([
                      RightButtonConfig(type: RightButtonType.customerService),
                      RightButtonConfig(type: RightButtonType.home),
                    ]),
                  });
                  break;
                case 'setting':
                  Get.to(() => ChangeNavPage(),
                      arguments: {'image': 'mine_sz', 'title': '设置'});
                  break;
                case 'scan':
                  Get.to(() => ScanWidgetPage());
                  break;
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 36.w,
              alignment: Alignment.center,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendar() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    final today = now.day;
    
    // 获取本月天数
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;
    
    // 计算显示哪一周（包含今天的那一周）
    final todayWeekday = now.weekday % 7;
    final weekStartDay = today - todayWeekday;
    
    List<String> weekdays = ['日', '一', '二', '三', '四', '五', '六'];
    
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.w),
          // 年月标题
          Container(
            margin: EdgeInsets.only(left: 15.w),
            child: BaseText(
              text: '${year}年${month}月',
              fontSize: 15.sp,
              color: Color(0xFF00CEDA),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5.w),
          // 星期标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              return Container(
                width: (1.sw - 60.w) / 7,
                alignment: Alignment.center,
                child: BaseText(
                  text: day,
                  fontSize: 13.sp,
                  color: Color(0xFF00CEDA),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 0.w),
          // 日期行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              final day = weekStartDay + index;
              final isValidDay = day > 0 && day <= lastDayOfMonth;
              final isToday = day == today;
              
              if (!isValidDay) {
                return Container(
                  width: (1.sw - 60.w) / 7,
                  height: 35.w,
                );
              }
              
              return Container(
                width: (1.sw - 60.w) / 7,
                height: 35.w,
                alignment: Alignment.center,
                child: isToday
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(
                            image: 'home_two_today'.png,
                            width: 35.w,
                            height: 35.w,
                            fit: BoxFit.contain,
                          ),
                        ],
                      )
                    : BaseText(
                        text: '$day',
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
              );
            }),
          ),
          SizedBox(height: 12.w),
        ],
      ),
    );
  }
}
