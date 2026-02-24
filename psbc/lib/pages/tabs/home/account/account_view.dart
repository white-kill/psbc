import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/account/component/account_bottom_widget.dart';
import 'package:psbc/pages/tabs/home/account/component/account_money.dart';
import 'package:psbc/pages/tabs/home/account/component/card_info.dart';
import 'package:psbc/routes/app_pages.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/pages/component/right_widget.dart';
import 'package:psbc/utils/stack_position.dart';
import 'package:psbc/pages/other/change_nav/change_nav_view.dart';

import 'account_logic.dart';
import 'account_state.dart';

class AccountPage extends BaseStateless {
  AccountPage({Key? key}) : super(key: key, title: '我的账户');

  final AccountLogic logic = Get.put(AccountLogic());
  final AccountState state = Get.find<AccountLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get navColor => Color(0xffF7FBFA);

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
          children: [
            _listViewTopWidget(),
            Obx(() => logic.imgTag.value == 1
                ? _accountWidget()
                : Image(image: 'account_tag${logic.imgTag.value}_1'.png3x))
          ],
        )),
        _bottomWidget()
      ],
    );
  }

  Widget _accountWidget() {
    StackPosition stackPosition =
        StackPosition(designWidth: 1080, designHeight: 848, deviceWidth: 1.sw);
    return Column(
      children: [
        AccountMoney(),
        CardInfo(),
        Image(
          image: 'account_ylj'.png3x,
          width: 1.sw,
          fit: BoxFit.fitWidth,
        ).withOnTap(onTap: () {
          Get.to(() => ChangeNavPage(),
              arguments: {'image': 'xwlylzq', 'title': 'U享未来养老专区'});
        }),
        AccountBottomWidget()
        // Image(image: 'account_tag1_3'.png3x),
      ],
    );
  }

  Widget _listViewTopWidget() {
    return Stack(
      children: [
        Obx(
          () => Image(image: 'account_tag${logic.imgTag.value}'.png3x),
        ),
        Row(
          children: [
            Container().expanded(onTap: () => logic.imgTag.value = 1),
            Container().expanded(onTap: () => logic.imgTag.value = 2),
            Container().expanded(onTap: () => logic.imgTag.value = 3),
          ],
        ).withContainer(width: 1.sw, height: 45.w)
      ],
    );
  }

  Widget _bottomWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 54.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: 'add_icon'.png3x,
                  width: 22.w,
                  height: 22.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(text: '添加本行账户'),
                    BaseText(
                      text: '已有1个本行账户',
                      color: Color(0xff999999),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 1.sw,
            height: ScreenUtil().bottomBarHeight,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
