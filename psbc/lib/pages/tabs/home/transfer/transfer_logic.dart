import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/transfer/bind_phone/bind_phone_view.dart';
import 'package:psbc/pages/tabs/home/transfer/thzayc/thzayc_view.dart';
import 'package:psbc/pages/tabs/home/transfer/transfer_myself/transfer_myself_view.dart';
import 'package:wb_base_widget/component/alter_widget.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';
import 'delay_transfer/delay_transfer_view.dart';
import 'dzhd/dzhd_view.dart';
import 'transfer_state.dart';

class TransferLogic extends GetxController {
  final TransferState state = TransferState();

  var showAll = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void jumpPage(index) {
    if (index == 0) {
      Get.to(() => ThzaycPage());
    }
    if (index == 1) {
      Get.to(() => ChangeNavPage(),
          arguments: {'image': 'yzhd', 'title': '邮政汇兑'});
    }
    if (index == 2) {
      Get.to(() => ChangeNavPage(),
          arguments: {'image': 'yyzh', 'title': '预约转账'});
    }
    if (index == 3) {
      Get.to(() => ChangeNavPage(),
          arguments: {'image': 'gjhk', 'title': '国际汇款'});
    }
    if (index == 4) {
      //电子账户充值
      AlterWidget.alterWidget(builder: (context) {
        return Image(image: 'dzzhcz'.png3x).withContainer(
            width: 1.sw  * 0.8,
            onTap: () {
              SmartDialog.dismiss();
            });
      });
    }
    if (index == 5) {
      Get.to(() => BindPhonePage());
    }
    if (index == 6) {
      Get.to(() => DelayTransferPage());

    }
    if (index == 7) {
      Get.to(() => ChangeNavPage(),
          arguments: {'image': 'tty', 'title': '天天盈'});
    }
    if (index == 8) {
      '您没有支持此业务功能的账户'.dialog(
        title: '温馨提示',
      );
    }
    if (index == 9) {
      //电子回单
      Get.to(() => DzhdPage());
    }
    if (index == 10) {
      Get.to(() => TransferMyselfPage());
    }
    if (index == 11) {
      '为了正常使用该功能，改功能需要获取录音权限，用于语言搜索等。'.dialog(
        title: '权限申请',
        sureText: '去设置',
      );
    }
    if (index == 12) {
      Get.to(() => FixedNavPage(), arguments: {
        'image': 'hytsjy',
        'background': Colors.white,
        'title': '行业特色交易'
      });
    }
    if (index == 13) {
      Get.to(() => FixedNavPage(), arguments: {
        'image': 'gyjk',
        'background': Colors.white,
        'title': '公益捐款'
      });
    }
  }
}
