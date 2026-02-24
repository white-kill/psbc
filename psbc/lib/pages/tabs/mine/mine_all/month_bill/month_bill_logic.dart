import 'package:get/get.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/net_config/apis.dart';

import '../../../../../config/model/month_bill_model.dart';
import 'month_bill_state.dart';

class MonthBillLogic extends GetxController {
  final MonthBillState state = MonthBillState();

  List<MonthBillModel> list = [];

  @override
  void onInit() {
    super.onInit();
    monthBillList();
  }

  void monthBillList(){
    Http.get(Apis.monthBillList).then((v){
      if(v is List){
        list = v.map((e) => MonthBillModel.fromJson(e)).toList().cast<MonthBillModel>();
        update(['updateUI']);
      }
    });
  }
}
