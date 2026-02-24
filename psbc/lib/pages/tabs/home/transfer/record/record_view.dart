import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/component/right_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/record/component/record_item_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/record/component/top_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import 'detail/detail_view.dart';
import 'record_logic.dart';
import 'record_state.dart';

class RecordPage extends BaseStateless {
  RecordPage({Key? key}) : super(key: key, title: '往来转账记录');

  final RecordLogic logic = Get.put(RecordLogic());
  final RecordState state = Get.find<RecordLogic>().state;

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
        const TopWidget(),
        GetBuilder(builder: (RecordLogic c){
          return Expanded(
              child: refreshWidget(
                  controller: state.refreshController,
                  child: ListView.builder(
                    controller: state.scController,
                    padding: EdgeInsets.only(top: 10.w),
                    itemBuilder: (context, index) {
                      return RecordItemWidget(model: state.list[index],).withOnTap(onTap: (){
                        Get.to(() => TransferDetailPage(),
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
