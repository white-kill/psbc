import 'package:get/get.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/net_config/apis.dart';

import '../../../../../../config/model/year_bill_info_model.dart';
import 'year_bill_info_state.dart';

class Year_bill_infoLogic extends GetxController {
  final Year_bill_infoState state = Year_bill_infoState();

  var title = '年度回顾'.obs;

  YearBillInfoModel model = YearBillInfoModel();

  String getTitle(int index){
    if(index == 0) return '年度回顾';
    if(index == 1) return '年度回顾';
    if(index == 2) return '年度结余全景';
    if(index == 3) return '年度总收入航线';
    if(index == 4) return '总支出日志';
    if(index == 5) return '我的总资产';
    if(index == 6) return '养老专区';
    if(index == 7) return '信用卡专区';
    if(index == 8) return '贷款专区';
    if(index == 9) return '2025年度账单';
    return '';
  }
  
  @override
  void onInit() {
    super.onInit();
    Http.get(Apis.yearSurplus,queryParameters: {
      'dateTime':'2025'
    }).then((v){
      print(v.toString());
      model = YearBillInfoModel.fromJson(v);
      update(['updateUI']);
    });
  }
}
