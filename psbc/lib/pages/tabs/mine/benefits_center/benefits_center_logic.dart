import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'benefits_center_state.dart';

class BenefitsCenterLogic extends GetxController {
  final BenefitsCenterState state = BenefitsCenterState();

  @override
  void onInit() {
    super.onInit();
    // 获取传入的等级，默认6级
    int initialLevel = Get.arguments?['level'] ?? 6;
    state.currentLevel.value = initialLevel;
    // 初始化PageController到对应页面
    state.pageController = PageController(initialPage: initialLevel - 1);
  }

  // 页面切换时更新等级
  void onPageChanged(int index) {
    state.currentLevel.value = index + 1;
  }

  @override
  void onClose() {
    state.pageController.dispose();
    super.onClose();
  }
}
