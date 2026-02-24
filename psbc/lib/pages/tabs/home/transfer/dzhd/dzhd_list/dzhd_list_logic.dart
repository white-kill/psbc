import 'package:get/get.dart';

import '../../../../../../config/dio/network.dart';
import '../../../../../../config/model/receipt_model.dart';
import '../../../../../../config/model/record_list_model.dart';
import '../../../../../../config/net_config/apis.dart';
import 'dzhd_list_state.dart';

class Dzhd_listLogic extends GetxController {
  final Dzhd_listState state = Dzhd_listState();

  @override
  void onInit() {
    super.onInit();
    String oppositeAccount = Get.arguments?['oppositeAccount']??'';
    state.hdData.oppositeAccount = oppositeAccount;
    transferPage();
  }

  void transferPage() {
    Http.get(Apis.receiptPage,
      queryParameters: state.hdData.toJson(),
    ).then((v) {
      print(v.toString());
      state.receiptModel = ReceiptModel.fromJson(v);
      state.refreshController.loadComplete();
      if(!state.receiptModel.list.isNotEmpty){
        state.refreshController.loadNoData();
      }
      if(state.hdData.pageNum == 1){
        state.list = state.receiptModel.list;
      }else{
        state.list = state.list + state.receiptModel.list;
      }
      update(['updateUI']);
    });
  }

  void sureTimeButton(){
    update(['updateTime']);
    state.hdData.pageNum = 1;
    state.hdData.beginTime = state.beginTime;
    state.hdData.endTime = state.endTime;
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
    state.hdData.pageNum = 1;
    state.hdData.minAmount = state.amountController1.text;
    state.hdData.maxAmount = state.amountController2.text;
    state.hdData.transactionChannel =sx(state.type1);
    state.hdData.accountType = sx(state.type2);
    state.hdData.type = sx(state.type3);
    transferPage();
  }

}
