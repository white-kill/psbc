import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import 'info_state.dart';

class InfoLogic extends GetxController {
  final InfoState state = InfoState();

  String maskName(String? name) {
    // 处理空值/空字符串
    if (name == null || name.trim().isEmpty) {
      return "";
    }
    String realName = name.trim();
    int length = realName.length;

    // 单字名：直接返回（无脱敏必要）
    if (length == 1) {
      return realName;
    }
    // 两字名：第二个字替换为*
    else if (length == 2) {
      return "${realName.substring(0, 1)}*";
    }
    // 超两字名：首尾保留，中间全替换为*
    else {
      String firstChar = realName.substring(0, 1);
      String lastChar = realName.substring(length - 1);
      // 计算中间需要替换的*数量
      String middleStars = "*" * (length - 2);
      return "$firstChar$middleStars$lastChar";
    }
  }
  String valueStr(String name){
    if(name == '勋章') {return '已获得5枚';}
    if(name == '姓名') {return maskName(AppConfig.config.abcLogic.memberInfo.realName);}
    if(name == '手机用户签约手机号') {
      return AppConfig.config.abcLogic.memberInfo.phone.desensitize();
    }
    if(name == '客户等级') {return '普通客户';}
    if(name == '预留信息设置') {return '未设置';}
    if(name == '手机银行主题') {return '未设置';}
    if(name == '我的推荐码') {return '';}
    if(name == '我的风险等级') {return '未评估';}
    if(name == '个人信息修改') {return '';}
    if(name == '更多设置') {return '';}
    return '';
  }
}
