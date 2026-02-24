import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'life_state.dart';

class LifeLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final LifeState state = LifeState();

  @override
  void onInit() {
    super.onInit();
    state.tabController =
        TabController(length: state.titleName.length, vsync: this);
  }
}
