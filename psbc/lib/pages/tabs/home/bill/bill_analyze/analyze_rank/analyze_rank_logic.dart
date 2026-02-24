import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/net_config/apis.dart';
import 'package:psbc/pages/tabs/home/bill/bill_analyze/analyze_rank/pick_time_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/model/rank_model.dart';
import '../../../../../component/sheet_widget/sheet_bottom.dart';
import 'analyze_rank_state.dart';

class AnalyzeRankLogic extends GetxController {
  final AnalyzeRankState state = AnalyzeRankState();

  @override
  void onInit() {
    super.onInit();
    state.type = Get.arguments?['type']??'1';
    state.dateTime = Get.arguments?['time']??'2025-12';
    incomeAnalysisRank();
  }

  Widget formatDate() {
    return GetBuilder(builder: (AnalyzeRankLogic c){
      if (state.dateTime == '') return Container();
      DateTime dt = DateTime.parse("${state.dateTime}-01");
      String y = DateFormat('yyyy').format(dt);
      String m = DateFormat('MM').format(dt);
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BaseText(text: m,style: TextStyle(
            fontSize: 24,color: Color(0xff333333),
            fontWeight: FontWeight.bold,
          ),),
          BaseText(text: '月/$y',color: Color(0xff666666),).withPadding(
              bottom: 2.w
          ),
          SizedBox(width: 6.w,),
          Image(
            image: 'arr_dow'.png3x,
            width: 6.w,
            height: 6.w,
            color: Color(0xff666666),
          ).withPadding(
              bottom: 8.w
          ),
        ],
      ).withOnTap(onTap: (){
        SheetBottom.show(
          title: '月度选择',
          rightWidget: Image(
            image: 'close'.png3x,
            width: 16.w,
            height: 16.w,
          ).withOnTap(onTap: () => Get.back()),
          child: const PickRankTimeView(),
        );
      });
    },id: 'updateTop',);

  }

  void incomeAnalysisRank(){
    Http.get(Apis.incomeAnalysisRank,queryParameters: {
      'pageSize':20,
      'pageNum':state.pageNum,
      'dateTime':state.dateTime,
      'type':state.type
    }).then((v){
      state.rankModel = RankModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.rankModel.list.isNotEmpty) {
        state.refreshController.loadNoData();
      }
      if (state.pageNum == 1) {
        state.list = state.rankModel.list;
      } else {
        state.list = state.list + state.rankModel.list;
      }
      update(['updateUI']);
    });
  }
}
