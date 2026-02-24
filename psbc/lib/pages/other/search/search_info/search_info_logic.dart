import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/search/account_print/account_print_view.dart';

import '../../../tabs/home/bill/bill_view.dart';
import 'search_info_state.dart';

class SearchInfoLogic extends GetxController {
  final SearchInfoState state = SearchInfoState();

  var selectTitle = 0.obs;
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_){
      state.searchController.text = Get.arguments['title']??'';
    });
  }

  void jumpPage(String name){

    if(name.contains('账户明细打印')){
      Get.to(() => AccountPrintPage());
    }
    if(name.contains('明细查询')){
      Get.to(() => BillPage());
    }
  }
}
