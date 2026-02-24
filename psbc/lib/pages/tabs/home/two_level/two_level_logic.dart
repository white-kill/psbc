import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';

import '../transfer/record/query_record/query_record_view.dart';
import '../transfer/transfer_view.dart';
import 'two_level_state.dart';

class TwoLevelLogic extends GetxController {
  final TwoLevelState state = TwoLevelState();

  @override
  void onInit() {
    super.onInit();
    _loadBalanceData();
  }

  @override
  void onClose() {
    super.onClose();
    state.dispose();
  }

  void _loadBalanceData() {
    // 从 AppConfig 获取收入和支出数据
    state.expenditure = AppConfig.config.abcLogic.memberInfo.expensesTotal;
    state.income = AppConfig.config.abcLogic.memberInfo.incomeTotal;
  }

  void changePage(int index) {
    state.currentPage = index;
    update(['pageIndicator']);
  }

  void jumpToPage(int index) {
    state.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void handleImageClick(int index) {
    final imageNames = [
      'home_two_caifu',
      'home_two_card',
      'home_two_life',
      'home_two_mine',
    ];

    if (index < imageNames.length) {
      state.showFullImage = true;
      state.fullImageName = imageNames[index];
      update(['fullImage']);
    }
  }

  void hideFullImage() {
    state.showFullImage = false;
    update(['fullImage']);
  }

  void toggleBalance() {
    state.showBalance = !state.showBalance;
    update(['balanceDisplay']);
  }

  void toggleMoreImage() {
    state.showMoreImage = !state.showMoreImage;
    update(['moreImage']);
  }

  void handlePageNavigation(int index) {
    switch (index) {
      case 4:
        Get.to(() => QueryRecordPage());
        break;
      case 5:
        Get.to(() => QueryRecordPage());
        break;
      case 6:
        Get.to(() => TransferPage());
        break;
      case 7:
        Get.to(() => TransferPage());
        break;
    }
  }

  void onItemTap(int index) {
    if (index < 4) {
      handleImageClick(index);
    } else {
      handlePageNavigation(index);
    }
  }
}
