import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/transfer/dzhd/dzhd_list/dzhd_info/dzhd_info_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../../component/right_widget.dart';
import 'component/hd_item_widget.dart';
import 'component/top_widget.dart';
import 'dzhd_list_logic.dart';
import 'dzhd_list_state.dart';

class Dzhd_listPage extends BaseStateless {
  Dzhd_listPage({Key? key}) : super(key: key,title: '电子回单查询');

  final Dzhd_listLogic logic = Get.put(Dzhd_listLogic());
  final Dzhd_listState state = Get.find<Dzhd_listLogic>().state;



  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  bool get enablePullDown => false;

  @override
  bool get showBackgroundColor => false;
  @override
  void onLoading() {
    super.onLoading();
    state.hdData.pageNum++;
    logic.transferPage();
  }

  @override
  bool get isChangeNav => true;



  @override
  Color? get titleColor => Color(0xff111111);


  @override
  Widget initBody(BuildContext context) {
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return Column(
      children: [

        Container(
          width: 1.sw,
          height: navHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFEAF2F2),
                Color(0xFFEAF2F2),
                Color(0xFFEAF2F2),
                Color(0xFFF5F5F5),
              ],
            ),
          ),
        ),

        const TopWidget1(),
        GetBuilder(builder: (Dzhd_listLogic c){
          return Expanded(
              child: refreshWidget(
                  controller: state.refreshController,
                  child: ListView.builder(
                    controller: state.scController,
                    padding: EdgeInsets.only(top: 10.w),
                    itemBuilder: (context, index) {
                      return HdItemWidget1(model: state.list[index],).withOnTap(onTap: (){
                        Get.to(() => DzhdInfoPage(),arguments: {
                           'model':state.list[index].detail
                        });
                      });
                    },
                    itemCount: state.list.length,
                  )));
        },id: 'updateUI',)
      ],
    );
  }
}
