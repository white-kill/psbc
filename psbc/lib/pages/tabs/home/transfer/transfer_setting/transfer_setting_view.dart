import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import './skrmc/view.dart';
import './bdsjsk/view.dart';
import './dhyhzzsz/view.dart';
import './fgmzfxe/view.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';

import '../../../../component/right_widget.dart';
import 'transfer_setting_logic.dart';
import 'transfer_setting_state.dart';

class TransferSettingPage extends BaseStateless {
  TransferSettingPage({Key? key}) : super(key: key, title: '转账设置');

  final TransferSettingLogic logic = Get.put(TransferSettingLogic());
  final TransferSettingState state = Get.find<TransferSettingLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Widget initBody(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            width: 1.sw,
            height: 50.w,
            color: Colors.white,
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                index == 7
                    ? Row(
                        children: [
                          BaseText(text: state.titles[index]),
                          SizedBox(
                            width: 5.w,
                          ),
                          Image(
                            image: 'shuoming'.png,
                            width: 15.w,
                            height: 15.w,
                          ),
                        ],
                      )
                    : BaseText(text: state.titles[index]),
                _rightWidget(index),
              ],
            ).withOnTap(onTap: () {
              if (index == 0) {
                Get.to(() => SkrmcPage());
              } else if (index == 1) {
                Get.to(() => BdsjskPage());
              } else if (index == 2) {
                Get.to(() => FixedNavPage(), arguments: {
                  'image': 'zwzz_1',
                  'title': '指纹转账',
                });
              }else if (index == 4) {
                Get.to(() => FgmzfxePage());
              } else if (index == 5) {
                Get.to(() => FixedNavPage(), arguments: {
                  'image': 'hnzzmsr_1',
                  'title': '行内转账免输入',
                });
              } else if (index == 8) {
                Get.to(() => DhyhzzszPage());
              } else if (index == 10) {
                Get.to(() => FixedNavPage(), arguments: {
                  'image': 'qqzhgl_1',
                  'title': '我的账户',
                });
              }
            }),
          );
        },
        separatorBuilder: (context, index) {
          bool line = (index == 2 || index == 4);
          return Container(
            width: 1.sw,
            height: line ? 10.w : 0.5.w,
            color: Color(0xFFF5F5F5),
          );
        },
        itemCount: state.titles.length);
  }

  Widget _rightWidget(int index) {
    if (index == 6 || index == 7 || index == 9) {
      return CupertinoSwitch(
              value: index == 7 ? false : true,
              // activeTrackColor: Color.fromARGB(255, 3, 134, 91),
              activeColor: const Color.fromARGB(255, 3, 134, 91),
              onChanged: (bool value) {})
          .sw();
    }
    return Image(
      image: 'ic_jt_right'.png3x,
      width: 25.w,
      height: 25.w,
    );
  }
}
