import 'package:get/get.dart';

import 'card_state.dart';

class CardLogic extends GetxController {
  final CardState state = CardState();
  
  // 根据滚动进度更新 Column 的偏移量
  // scrollProgress: 0.0 表示第一页，1.0 表示第二页
  void updateColumnOffset(double scrollProgress) {
    // columnOffset 直接存储滚动进度 0.0 ~ 1.0
    state.columnOffset = scrollProgress;
    update(['updateColumnPosition']);
  }
}
