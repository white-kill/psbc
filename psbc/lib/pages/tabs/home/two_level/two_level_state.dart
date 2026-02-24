import 'package:flutter/material.dart';

class TwoLevelState {
  late PageController pageController;
  int currentPage = 0;

  bool showFullImage = false;
  String fullImageName = '';

  bool showBalance = false;
  bool showMoreImage = false; // 控制 home_two_more 图片显示
  
  // 支出和收入金额
  double expenditure = 0.00; // 支出
  double income = 0.00; // 收入

  TwoLevelState() {
    pageController = PageController(initialPage: 0);
  }

  void dispose() {
    pageController.dispose();
  }
}
