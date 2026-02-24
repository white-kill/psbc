import 'package:flutter/material.dart';

class Mine_allState {
  ScrollController outerScrollController = ScrollController(); // 外层滚动控制器
  ScrollController leftScrollController = ScrollController(); // 左侧A滚动控制器
  ScrollController rightScrollController = ScrollController(); // 右侧B滚动控制器
  List<GlobalKey> imageKeys = []; // 右侧图片的 GlobalKey 列表
  int selectedIndex = 0; // 当前选中的索引
  bool isScrollingToAnchor = false; // 是否正在执行锚点滚动，用于防止滚动过程中更新选中状态
  
  // 左侧A列表的文案
  final List<String> leftListTexts = [
    '特色功能',
    '账户',
    '转账汇款',
    '金融助手',
    '跨境金融',
    '网点服务',
    '贷款',
    '财富',
    '信用卡',
    '缴费充值',
    '支付服务',
    '邮政服务',
    '政务服务',
    '美食娱乐',
    '便利出行',
    '数字生活',
    '设置',
    '其他服务',
  ];
  
  Mine_allState() {
    ///Initialize variables
    // 初始化图片的 GlobalKey（根据实际图片数量，18张图片）
    imageKeys = List.generate(leftListTexts.length, (index) => GlobalKey());
  }
  
  void dispose() {
    outerScrollController.dispose();
    leftScrollController.dispose();
    rightScrollController.dispose();
  }
}
