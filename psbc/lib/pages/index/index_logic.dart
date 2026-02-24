import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../utils/local_notifications.dart';
import '../../config/app_config.dart';
import 'index_state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();

  /// 默认选择第一个页面
  var taBarIdx = 0.obs;

 bool showTabBar = true;

  @override
  void onClose() {
    super.onClose();
    NotificationHelper.getInstance().closeSubject();
  }

  @override
  void onInit() {
    super.onInit();
    NotificationHelper.getInstance().initPermission();
    AppConfig.config.abcLogic.memberInfoData();
    state.item = state.appBarList.map((data) {
      return BottomNavigationBarItem(
        icon: Obx(() => Image(
              image: '${data["icon"]}${imagePath(data)}'.png3x,
              width: 22.w,
              height: 22.w,
            )),
        label: data["title"],
      );
    }).toList();
  }


  String imagePath(data){
    return taBarIdx.value == data["index"]
        ? '_select${taBarIdx.value}'
        : '_normal${data["index"]}';
  }

  /// navigationBar设置
  Widget navigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      onTap: selectIndex,
      currentIndex: taBarIdx.value,
      selectedFontSize: 13.sp,
      unselectedFontSize: 13.sp,
      unselectedItemColor: const Color(0xff333333),
      selectedItemColor: Color(state.appBarList[taBarIdx.value]['selectColor']),
      type: BottomNavigationBarType.fixed,
      items: state.item,
    );
  }

  void selectIndex(int index) {
    if (taBarIdx.value == index) return;
    taBarIdx.value = index;
    update(['updateTabBar']);
  }
}
