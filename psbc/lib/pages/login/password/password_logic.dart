import 'package:get/get.dart';
import 'package:psbc/utils/sp_util.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'dart:core';

import '../../../config/app_config.dart';
import '../../../config/dio/network.dart';
import '../../../config/net_config/apis.dart';
import '../../../routes/app_pages.dart';
import 'password_state.dart';

class PasswordLogic extends GetxController {
  final PasswordState state = PasswordState();

  String phone = '';
  var passwordText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    phone = Get.arguments['phone'];
  }

  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      return '上午好';
    } else if (hour == 12) {
      return '中午好';
    } else if (hour > 12 && hour < 18) {
      return '下午好';
    } else {
      return '晚上好';
    }
  }

  void goLogin() {
    if (Get.arguments['phone'] == '') {
      '请输入账号'.showToast;
      return;
    }

    if (state.psdTextController.text == '') {
      '请输入密码'.showToast;
      return;
    }
    Http.post(Apis.login, data: {
      "username": Get.arguments?['phone'],
      "password": state.psdTextController.text
    }).then((value) {
      if (value != null && value['access_token'] != '') {
        'Bearer ${value['access_token']}'.saveToken;
        Http.setHeaders({'Authorization': token});
        AppConfig.config.abcLogic
            .memberInfoData()
            .then((v) => Get.offAllNamed(Routes.tabs));
      }
    });
  }
}
