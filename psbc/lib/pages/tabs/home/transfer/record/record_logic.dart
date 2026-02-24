import 'package:get/get.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/net_config/apis.dart';

import '../../../../../config/model/record_list_model.dart';
import 'record_state.dart';

class RecordLogic extends GetxController {
  final RecordState state = RecordState();

  @override
  void onInit() {
    super.onInit();
    transferPage();
  }

  void transferPage() {
    print(Apis.transferPage);
    Http.get(Apis.transferPage,
        queryParameters: state.recordData.toJson(),
    ).then((v) {
      state.recordModel = RecordListModel.fromJson(v);
      state.refreshController.loadComplete();
      if(!state.recordModel.list.isNotEmpty){
        state.refreshController.loadNoData();
      }
      if(state.recordData.pageNum == 1){
        state.list = state.recordModel.list;
      }else{
        state.list = state.list + state.recordModel.list;
      }
      update(['updateUI']);
    });
  }

  void sureTimeButton(){
    update(['updateTime']);
    state.recordData.pageNum = 1;
    state.recordData.beginTime = state.beginTime;
    state.recordData.endTime = state.endTime;
    transferPage();
  }

  String sx(String name){
    if(name == '全部') return '';
    return name;
  }

  void sureFilterButton(){
    Get.back();
    state.type1 = state.temType1;
    state.type2 = state.temType2;
    state.type3 = state.temType3;
    state.temType1 = '';
    state.temType2 = '';
    state.temType3 = '';
    state.recordData.pageNum = 1;
    state.recordData.minAmount = state.amountController1.text;
    state.recordData.maxAmount = state.amountController2.text;
    state.recordData.transactionChannel =sx(state.type1);
    state.recordData.accountType = sx(state.type2);
    state.recordData.type = sx(state.type3);
    transferPage();
  }

  void search(String v){
    state.recordData.pageNum = 1;
    state.recordData.keyword = v;
    transferPage();
  }

}
