import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/bill/bill_detail/bill_detail_view.dart';
import 'package:psbc/pages/tabs/home/bill/component/bill_item_moths_widget.dart';
import 'package:psbc/pages/tabs/home/bill/component/bill_item_widget.dart';
import 'package:psbc/pages/tabs/home/bill/component/right_point_widget.dart';
import 'package:psbc/pages/tabs/home/bill/component/top_statistics_widget.dart';
import 'package:psbc/pages/tabs/home/bill/component/top_widget.dart';
import 'package:psbc/pages/tabs/home/bill/search_history/search_history_view.dart';
import 'package:psbc/pages/tabs/home/bill/year_bill/year_bill_view.dart';
import 'package:psbc/utils/visibility_duration.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../config/model/bill_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../other/customer_service/customer_service_view.dart';
import '../../mine/mine_all/month_bill/month_bill_view.dart';
import '../print/print_view.dart';
import './bill_analyze/analyze_month/analyze_month_view.dart';
import 'bill_logic.dart';
import 'bill_state.dart';
import 'component/bill_item_range_widget.dart';

class BillPage extends BaseStateless {
  BillPage({super.key}) : super(title: '明细查询');

  final BillLogic logic = Get.put(BillLogic());
  final BillState state = Get.find<BillLogic>().state;

  @override
  bool get enablePullDown => false;


  @override
  List<Widget>? get rightAction => [
    Image(image: 'bill_serach'.png3x,width: 24.w,height: 24.w,).withOnTap(onTap: (){
      Get.to(() => SearchHistoryPage());
    }),
    SizedBox(width: 12.w,),
    // Image(image: 'bill_more'.png3x,width: 24.w,height: 24.w,),
    RightPointWidget(
      dx: 50.w,
      dy: 10,
      left: 120.w,
      width: 138.w,
      callBack: (name){
        print(name + '#############');
        if(name == '在线客服') Get.to(() => CustomerServicePage());
        if(name == '返回首页') Get.offAllNamed(Routes.tabs);
        if(name == '账户明细打印')  Get.to(() => PrintPage());
        if(name == '月账单') Get.to(() => MonthBillPage());
        if(name == '月度结余') Get.to(() => AnalyzeMonthPage());
        if(name == '年账单') Get.to(() => YearBillPage());
      },
    ),
    SizedBox(width: 15.w,),
  ];

  @override
  Widget initBody(BuildContext context) {
    return Stack(
      children: [

        Obx(() => logic.tabIndex.value == 1
            ? Column(
                children: [
                  const BillTopWidget(),
                  GetBuilder(
                    builder: (BillLogic c) {
                      return Expanded(
                        child: logic.showRange ? _rangeBillList() : _billList(),
                      );
                    },
                    id: 'updateUI',
                  ),
                ],
              )
            : ListView(
                padding: EdgeInsets.only(
                    bottom: ScreenUtil().bottomBarHeight + 47.w),
                children: [Image(image: 'bg_bill_content2'.png3x)],
              )),
        Positioned(
          left: 0,
          top: 87.w,
          child: GetBuilder(builder: (BillLogic c){
            if(logic.tabIndex.value == 2) return const SizedBox.shrink();
            return c.state.isAtTop ?const SizedBox.shrink():const TopStatisticsWidget();
          },id: 'updateTopStatistics',),
        ),
        Positioned(
            left: 0,
            bottom: 0,
            child: Obx(() => Column(
                  children: [
                    Stack(
                      children: [
                        Image(
                          image: 'bill_tabar${logic.tabIndex.value}'.png3x,
                          width: 1.sw,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          width: 1.sw,
                          height: 56.w,
                          child: Row(
                            children: [
                              Container().expanded(onTap: () {
                                logic.tabIndex.value = 1;
                                logic.update(['updateTopStatistics']);
                              }),
                              Container().expanded(onTap: () {
                                logic.tabIndex.value = 2;
                                logic.update(['updateTopStatistics']);
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 1.sw,
                      height: ScreenUtil().bottomBarHeight,
                      color: Colors.white,
                    )
                  ],
                )))
      ],
    ); 
  }

  Widget _billList() {
    return refreshWidget(
        controller: state.refreshController,
        child: ListViewObserver(
          controller: state.observerController,
          onObserve: logic.onListViewObserve,
          child: ListView.builder(
            controller: state.scController,
            padding: EdgeInsets.only(
                bottom: ScreenUtil().bottomBarHeight + 70.w,
                left: 12.w,
                right: 12.w,
                top: 10.w),
            itemBuilder: (context, index) {
              BillList model = state.list[index];
              if (model.billDetail.isNullOrEmpty) {
                return BillItemMothsWidget(
                  index: index,
                  model: model,
                );
              }
              return BillItemWidget(
                showRadius: index == state.list.length - 1,
                model: model,
              ).withOnTap(onTap: () {
                Get.to(() => BillDetailPage(),
                    arguments: {'model': model.billDetail});
              });
            },
            itemCount: state.list.length,
          ),
        )).withContainer(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFFFFFF),
            Color(0xffF6F6F8),
            Color(0xffF6F6F8),
            Color(0xffF6F6F8),
          ],
        ),
      ),
    );
  }

  Widget _rangeBillList() {
    return refreshWidget(
        controller: state.rangeRefreshController,
        child: ListView.builder(
          controller: state.rangeScController,
          padding: EdgeInsets.only(
              bottom: ScreenUtil().bottomBarHeight + 70.w,
              left: 12.w,
              right: 12.w,
              top: 10.w),
          itemBuilder: (context, index) {
            BillList model = state.rangeList[index];
            return BillItemRangeWidget(
              index: index,
              model: model,
              total: state.rangeModel.total,
            ).withOnTap(onTap: () {
              Get.to(() => BillDetailPage(),
                  arguments: {'model': model.billDetail});
            });
          },
          itemCount: state.rangeList.length,
        )).withContainer(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFFFFFF),
            Color(0xffF6F6F8),
            Color(0xffF6F6F8),
            Color(0xffF6F6F8),
          ],
        ),
      ),
    );
  }
}
