import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/net_config/apis.dart';

import '../../../../../config/model/bill_serach_model.dart';
import 'bill_search_state.dart';

class BillSearchLogic extends GetxController {
  final BillSearchState state = BillSearchState();
  bool showRange = false;

  bool d1 = true;
  @override
  void onInit() async{
    super.onInit();
    state.keyword = Get.arguments['name']??'';
    WidgetsBinding.instance.addPostFrameCallback((_){
      state.textController.text = Get.arguments['name']??'';
    });

    await billData();
    state.scController.addListener(_scrollListener);
  }
  void _scrollListener() async{
    if (state.scController.position.pixels >
        state.scController.position.maxScrollExtent - 300) {
      if(d1){
        d1 = false;
        state.pageNum++;
        await billData().then((v){
          d1 = true;
        });
      }

    }
  }


  String type(type){
    if(type == '1'){
      return '+';
    }
    if(type == '2'){
      return '-';
    }
    return '+';
  }

  Future billData() async{
    await Http.get(Apis.billKeywordPayment,queryParameters: {
      'pageSize':20,
      'pageNum':state.pageNum,
      'beginTime':state.beginTime,
      'endTime':state.endTime,
      'keyword':state.keyword
    },isLoading: state.pageNum == 1).then((v){
      state.serachModel = BillSerachModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.serachModel.list.isNotEmpty) {
        state.refreshController.loadNoData();
      }
      if (state.pageNum == 1) {
        state.list = state.serachModel.list;
      } else {
        state.list = state.list + state.serachModel.list;
      }
      update(['updateUI']);
    });
  }


  void sureTimeButton(){
    update(['updateTime']);
    if(state.isMonth){
      showRange = false;
      billData().then((v){
        state.scController.jumpTo(0);
      });
    }else {
      showRange = true;
      billData().then((v){
        state.scController.jumpTo(0);
      });
    }
  }

}
