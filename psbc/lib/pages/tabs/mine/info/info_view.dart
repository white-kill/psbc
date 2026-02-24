import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/change_nav/change_nav_view.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:psbc/pages/tabs/mine/info/customer_level/customer_level_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../component/right_widget.dart';
import 'info_logic.dart';
import 'info_state.dart';

class InfoPage extends BaseStateless {
  InfoPage({Key? key}) : super(key: key, title: '个人资料');

  final InfoLogic logic = Get.put(InfoLogic());
  final InfoState state = Get.find<InfoLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Widget initBody(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 10.w),
      itemBuilder: (context, index) {
        String title = state.titleNames[index];
        if (state.titleNames[index] == '') {
          return SizedBox(
            width: 1.sw,
            height: 12.w,
          );
        }
        return Container(
          width: 1.sw,
          height: 45.w,
          padding: EdgeInsets.only(left: 12.w, right: 8.w),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(text: title),
              Row(
                children: [
                  title == '头像'
                      ? Image(
                          image: 'mine_head_img'.png3x,
                          width: 40.w,
                          height: 40.w,
                        )
                      : title == '我的推荐码'
                          ? Icon(
                              Icons.qr_code,
                              color: Color(0xff666666),
                              size: 18.w,
                            )
                          : BaseText(text: logic.valueStr(title),color: Color(0xff666666),),
                  title == '姓名'
                      ? const SizedBox.shrink()
                      : Image(
                          image: 'ic_jt_right'.png3x,
                          width: 25.w,
                          height: 25.w,
                          color: Color(0xff999999),
                        ),
                ],
              )
            ],
          ),
        ).withOnTap(onTap: () {
          _onItemTap(title);
        });
      },
      itemCount: state.titleNames.length,
      separatorBuilder: (BuildContext context, int index) {
        return state.titleNames[index] == ''
            ? const SizedBox.shrink()
            : Container(
                width: 1.sw,
                height: 0.5.w,
                color: const Color(0xffEFEFEF),
              );
      },
    );
  }
  
  void _onItemTap(String title) {
    if (title == '头像') {
      Get.to(() => FixedNavPage(), arguments: {
        'title': '头像管理',
        'image': 'tx',
      });
    } else if (title == '勋章') {
      // TODO: 跳转到勋章页面
    } else if (title == '姓名') {
      // 姓名不可点击，无操作
      return;
    } else if (title == '手机用户签约手机号') {
      Get.to(() => FixedNavPage(), arguments: {
        'title': '签约手机号码修改',
        'image': 'sjyhqysjh',
      });
    } else if (title == '客户等级') {
      Get.to(() => CustomerLevelPage());
    } else if (title == '预留信息设置') {
      Get.to(() => FixedNavPage(), arguments: {
        'title': '预留信息设置',
        'image': 'ylxxsz',
      });
    } else if (title == '手机银行主题') {
      Get.to(() => ChangeNavPage(), arguments: {
        'title': '主题中心',
        'image': 'sjyhzt',
        'rightWidget': [
          GestureDetector(
            onTap: () {
              // TODO: 处理不使用主题的逻辑
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              child: BaseText(
                text: '不使用主题',
                fontSize: 14.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
        ],
      });
    } else if (title == '我的推荐码') {
      Get.to(() => FixedNavPage(), arguments: {
        'title': '我的二维码',
        'image': 'wdtjm',
      });
    } else if (title == '我的风险等级') {
      Get.to(() => ChangeNavPage(), arguments: {
        'title': '我的风险等级',
        'image': 'wdfxdj',
      });
    } else if (title == '个人信息修改') {
      Get.to(() => FixedNavPage(), arguments: {
        'title': '',
        'image': 'grxxxg',
        'titleWidget': SizedBox.shrink(),
      });
    } else if (title == '更多设置') {
      Get.to(() => FixedNavPage(), arguments: {
        'title': '设置',
        'image': 'gdsz',
      });
    }
  }
}
