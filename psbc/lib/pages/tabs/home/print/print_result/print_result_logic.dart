import 'package:get/get.dart';

import 'print_result_state.dart';

class PrintResultLogic extends GetxController {
  final PrintResultState state = PrintResultState();

  String content = '';
  @override
  void onInit() {
    super.onInit();
    state.reqPrint = Get.arguments['req'];
    content = '1、请您到邮箱${state.reqPrint.email}中查看历史明细文档，并自行打印。2、请点击申请进度查询按钮，了解邮件发送情况和获取文件密码。';
  }
}
