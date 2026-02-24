import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../config/model/bill_model.dart';
import '../../../component/sheet_widget/picker_widget.dart';
import 'Req_data.dart';

class BillState {

  TextEditingController searchController = TextEditingController();

  bool isMonth = true;
  DateTimePickerNotifier mPickerNotifier = DateTimePickerNotifier();
  DateTimePickerNotifier pickerNotifier = DateTimePickerNotifier();

  //月份时间
  String mothTime = '';
  String temMothTime= '';


  String timeTitle = '';
  String temTimeTitle = '';
  //  开始时间
  String beginTime = '';
  String temBeginTime = '';
  //结束时间
  String endTime = '';
  String temEndTime = '';

  ReqBillData reqData = ReqBillData();

  RefreshController refreshController = RefreshController();
  ScrollController scController = ScrollController();
  
  // ListViewObserver 控制器
  late ListObserverController observerController;
  
  // 当前可见的月份索引
  var currentVisibleMonthIndex = 0.obs;

  ///时间范围
  RefreshController rangeRefreshController = RefreshController();
  ScrollController rangeScController = ScrollController();

  List<BillList> list = [];
  BillModel model = BillModel();


  List<BillList> rangeList = [];
  BillModel rangeModel = BillModel();



  List temCategory = [];
  List category = [];

  TextEditingController amountController1 = TextEditingController();
  TextEditingController amountController2 = TextEditingController();

  bool isAtTop = true;
  double incomeTotalMonth = 0;
  double expensesTotalMonth = 0;
  double incomeTotalRange = 0;
  double expensesTotalRange = 0;


  String dateTime = '';
  BillState() {
    ///Initialize variables
    DateTime now = DateTime.now();
    mothTime = DateFormat('yyyy-MM').format(now);
    reqData.queryTime = mothTime;
    
    // 初始化 observerController
    observerController = ListObserverController(controller: scController);
  }
}
