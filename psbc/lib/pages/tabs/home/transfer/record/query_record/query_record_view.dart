import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../../../routes/app_pages.dart';
import '../../../../../component/right_widget.dart';
import 'component/record_item_widget.dart';
import 'component/top_widget.dart';
import 'query_record_logic.dart';
import 'query_record_state.dart';

class QueryRecordPage extends BaseStateless {
  QueryRecordPage({Key? key}) : super(key: key, title: '往来转账记录');

  final Query_recordLogic logic = Get.put(Query_recordLogic());
  final Query_recordState state = Get.find<Query_recordLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  bool get enablePullDown => false;

  @override
  void onLoading() {
    super.onLoading();
    state.recordData.pageNum++;
    logic.transferPage();
  }

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        const TopWidget1(),
        GetBuilder(builder: (Query_recordLogic c){
          return Expanded(
              child: refreshWidget(
                  controller: state.refreshController,
                  child: ListView.builder(
                    controller: state.scController,
                    padding: EdgeInsets.only(top: 10.w),
                    itemBuilder: (context, index) {
                      return RecordItemWidget1(model: state.list[index],).withOnTap(onTap: (){
                        Get.offAndToNamed(Routes.transferDetailPage,
                            arguments: {'model': state.list[index].detail});
                      });
                    },
                    itemCount: state.list.length,
                  )));
        },id: 'updateUI',)
      ],
    );
  }
}
