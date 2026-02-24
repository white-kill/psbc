import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/mine/mine_all/month_bill/month_info/month_info_view.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/month_bill_model.dart';
import 'month_bill_logic.dart';
import 'month_bill_state.dart';

class MonthBillPage extends BaseStateless {
  MonthBillPage({Key? key}) : super(key: key, title: '月账单');

  final MonthBillLogic logic = Get.put(MonthBillLogic());
  final MonthBillState state = Get.find<MonthBillLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder(
      builder: (MonthBillLogic c) {
        return ListView.builder(
          padding: EdgeInsets.only(top: 15.w, bottom: 15.w),
          itemBuilder: (context, index) {
            MonthBillModel model = logic.list[index];
            return Container(
              width: 1.sw,
              margin: EdgeInsets.only(left: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(index == 0?8.w:0),
                  topLeft: Radius.circular(index == 0?8.w:0),
                  bottomRight: Radius.circular(index == (logic.list.length-1)?8.w:0),
                  bottomLeft: Radius.circular(index == (logic.list.length-1)?8.w:0),
                )
              ),
              child: Column(
                children: [
                  model.year == ''?const SizedBox.shrink():Row(
                    children: [
                      Container(
                        width: 3.w,
                        height: 16.w,
                        color: BColors.mainColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      BaseText(
                        text: '${model.year}年',
                        color: Color(0xff66666F),
                      ),
                    ],
                  ).withPadding(
                    top: 21.w,
                    bottom: 15.w,
                  ),
                  Container(
                    width: 325.w,
                    height: 0.5.w,
                    color: Color(0xffF2F2F4),
                  ),
                  Stack(
                    children: [
                      Image(
                        image: model.month.png,
                        width: 328.w,
                        height: 140.w,
                      ),
                      Positioned(
                          left: 28.w,
                          top: 12.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BaseText(
                                text: model.month,
                                fontSize: 30,
                                color: Color(0xff2E2E30),
                              ),
                              BaseText(
                                text: '月账单',
                                fontSize: 13,
                                color: Color(0xff2E2E30),
                              ).withPadding(
                                bottom: 8.w,
                                left: 2.w,
                              ),
                            ],
                          )),
                      Positioned(
                          left: 30.w,
                          top: 75.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      child: BaseText(
                                    text: '收入 ¥${model.income.bankBalance}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600
                                        ),
                                  )).expanded(),
                                  Container(
                                      child: BaseText(
                                    text: '支出 ¥${model.expenses.bankBalance.replaceAll('-', '')}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600
                                        ),
                                  )).expanded()
                                ],
                              ),
                              Row(
                                children: [
                                  Container(child: Row(
                                    children: [
                                      BaseText(text: '较上月',color: Color(0xff666666),fontSize: 12,),
                                      Image(image: '13'.png,width: 12.w,height: 12.w,),
                                      BaseText(text: model.upIncome.bankBalance,color: Color(0xff666666),fontSize: 12,),
                                    ],
                                  ))
                                      .expanded(),
                                  Container(child: Row(
                                    children: [
                                      BaseText(text: '较上月',color: Color(0xff666666),fontSize: 12,),
                                      Image(image: '14'.png,width: 12.w,height: 12.w,),
                                      BaseText(text: model.upExpenses.bankBalance,color: Color(0xff666666),fontSize: 12,),
                                    ],
                                  ))
                                      .expanded()
                                ],
                              ),
                            ],
                          ).withContainer(
                            width: 260.w,
                            height: 50.w,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15.w,
                  ),
                ],
              ),
            ).withOnTap(onTap: (){
              // 收集同一年份的所有月份数据
              final String year = model.year;
              final List<MonthBillModel> yearData = logic.list
                  .where((item) => item.dateTime.contains(year))
                  .toList();
              
              // 转换为趋势数据格式
              final List<Map<String, dynamic>> trendData = yearData.map((item) {
                return {
                  'dateTime': item.dateTime,
                  'income': item.income,
                  'expenses': item.expenses,
                };
              }).toList();
              print(trendData);
              Get.to(() => MonthInfoPage(),arguments: {
                'dateTime':model.dateTime,
                'month':model.month,
                'trendData': trendData, // 传递一年的趋势数据
              });
            });
          },
          itemCount: logic.list.length,
        );
      },
      id: 'updateUI',
    );
  }
}
