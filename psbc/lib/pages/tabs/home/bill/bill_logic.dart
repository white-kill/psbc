import 'package:get/get.dart';
import 'package:psbc/config/model/bill_model.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../config/dio/network.dart';
import '../../../../config/net_config/apis.dart';
import '../../../../utils/time_tool.dart';
import 'bill_state.dart';

class BillLogic extends GetxController {
  final BillState state = BillState();
  var tabIndex = 1.obs;

  bool showRange = false;

  bool d1 = true;
  bool d2 = true;

  @override
  void onInit() async{
    super.onInit();
    await billData();

    state.scController.addListener(_scrollListener);
    state.rangeScController.addListener(_rangeScrollListener);
  }

  void _scrollListener() async{

    final bool isAtTop = state.scController.position.pixels< 60;
    if(state.isAtTop != isAtTop){
      if(state.list.isNotEmpty){
        BillList model = state.list.first;
        state.expensesTotalMonth = model.expensesTotal;
        state.incomeTotalMonth = model.incomeTotal;
      }
      state.isAtTop = isAtTop;
      update(['updateTopStatistics']);
    }

    if (state.scController.position.pixels >
        state.scController.position.maxScrollExtent - 300) {
      if(d1){
        d1 = false;
        state.reqData.pageNum++;
        await billData().then((v){
          d1 = true;
        });
      }
    }
  }

  void _rangeScrollListener() async{
    final bool isAtTop = state.rangeScController.position.pixels < 60;
    if (state.isAtTop != isAtTop) {
      state.isAtTop = isAtTop;
      update(['updateTopStatistics']);
    }
    if (state.rangeScController.position.pixels >
        state.rangeScController.position.maxScrollExtent - 300) {
      if(d2){
        d2 = false;
        state.reqData.pageNum++;
        await billPageRangePayment().then((v){
          d2 = true;
        });
      }
    }
  }


  // ListView 滚动监听回调
  void onListViewObserve(ListViewObserveModel observeModel) {
    // 获取当前可见的 item 列表
    final displayingChildModelList = observeModel.displayingChildModelList;
    
    if (displayingChildModelList.isEmpty) return;
    
    // 只获取屏幕顶部第一个可见的 item
    final firstVisibleModel = displayingChildModelList.first;
    final firstIndex = firstVisibleModel.index;
    
    if (firstIndex < 0 || firstIndex >= state.list.length) return;
    
    // 从第一个可见的 item 向前查找最近的月份标题
    for (int i = firstIndex; i >= 0; i--) {
      final billItem = state.list[i];
      // 如果是月份标题项（billDetail 为空）
      if (billItem.billDetail?.id == null || billItem.billDetail?.id == 0) {
        // 更新当前可见的月份
        state.currentVisibleMonthIndex.value = i;
        state.expensesTotalMonth = billItem.expensesTotal;
        state.incomeTotalMonth = billItem.incomeTotal;
        // 确保月份是两位数格式
        String month = billItem.month.toString().padLeft(2, '0');
        state.dateTime = '${billItem.year}-$month';
        update(['updateTopStatistics', 'updateTime']);
        break;
      }
    }
  }

  @override
  void onClose() {
    state.scController.removeListener(_scrollListener);
    state.scController.dispose();

    state.rangeScController.removeListener(_scrollListener);
    state.rangeScController.dispose();
    super.onClose();
  }

  Future billData() async{
    print( state.reqData.toJson());
   await Http.get(
        Apis.detailsQuery,
        queryParameters: state.reqData.toJson(),
        isLoading: state.reqData.pageNum == 1
    ).then((v){
      state.model = BillModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.model.list.isNotEmpty) {
        state.refreshController.loadNoData();
      }else {
        state.reqData.endPageTime = state.model.list.last.transactionTime;
      }
      if (state.reqData.pageNum == 1) {
        state.list = state.model.list;
      } else {
        state.list = state.list + state.model.list;
      }
      update(['updateUI']);
    });
  }

  Future billPageRangePayment() async{
    print( state.reqData.toJson());
    await Http.get(
        Apis.billRangePayment,
        queryParameters: state.reqData.toJson(),
        isLoading: state.reqData.pageNum == 1
    ).then((v){
      state.rangeModel = BillModel.fromJson(v);
      state.rangeRefreshController.loadComplete();
      if (!state.rangeModel.list.isNotEmpty) {
        state.rangeRefreshController.loadNoData();
      }else {
        state.reqData.endPageTime = state.rangeModel.list.last.endPageTime;
      }
      if (state.reqData.pageNum == 1) {
        state.incomeTotalRange = state.rangeModel.incomeTotal;
        state.expensesTotalRange = state.rangeModel.expensesTotal;
        state.rangeList = state.rangeModel.list;
      } else {
        state.rangeList = state.rangeList + state.rangeModel.list;
      }
      update(['updateUI','updateTopStatistics']);
    });
  }


  void sureTimeButton(){
    state.isAtTop = true;
    update(['updateTime','updateTopStatistics']);
    state.reqData.pageNum = 1;
    state.reqData.endPageTime = '';
    state.list.clear();
    state.rangeList.clear();
    if(state.isMonth){
      showRange = false;
      state.reqData.queryTime = state.mothTime;
      state.reqData.beginTime = '';
      state.reqData.endTime = '';
      billData().then((v){
        Future.delayed(const Duration(milliseconds: 300),(){
          state.scController.jumpTo(0);
        });
      });
    }else {
      showRange = true;
      state.reqData.queryTime = '';
      state.reqData.beginTime = state.beginTime;
      state.reqData.endTime = state.endTime;
      billPageRangePayment().then((v){
        Future.delayed(const Duration(milliseconds: 300),(){
          state.rangeScController.jumpTo(0);
        });
      });
    }
  }

  void sureFilterButton(){
    state.isAtTop = true;
    update(['updateTime','updateTopStatistics']);
    state.category.clear();
    state.category.addAll(state.temCategory);
    state.temCategory.clear();
    state.reqData.pageNum = 1;
    state.reqData.categorys = state.category.join(',');
    state.reqData.endPageTime = '';
    state.reqData.minAmount = state.amountController1.text;
    state.reqData.maxAmount = state.amountController2.text;
    state.list.clear();
    state.rangeList.clear();
    Get.back();
    if(state.isMonth){
      showRange = false;
      billData().then((v){
        Future.delayed(const Duration(milliseconds: 300),(){
          state.scController.jumpTo(0);
        });
      });
    }else {
      showRange = true;
      billPageRangePayment().then((v){
        Future.delayed(const Duration(milliseconds: 300),(){
          state.rangeScController.jumpTo(0);
        });
      });
    }
  }
}
