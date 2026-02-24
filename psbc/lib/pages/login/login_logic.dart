import 'package:get/get.dart';
import 'package:psbc/utils/sp_util.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import '../../config/app_config.dart';
import '../../config/dio/network.dart';
import '../../config/net_config/apis.dart';
import '../../routes/app_pages.dart';
import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  var tag1 = false.obs;
  var phoneText = ''.obs;

}
