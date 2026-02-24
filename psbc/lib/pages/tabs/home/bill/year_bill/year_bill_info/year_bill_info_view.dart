import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/bill/year_bill/ylj/ylj_view.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../component/right_widget.dart';
import '../../../../mine/mine_all/month_bill/month_bill_view.dart';
import '../../../account/account_view.dart';
import '../../bill_logic.dart';
import '../../bill_view.dart';
import '../year_end/year_end_view.dart';
import 'year_bill_info_logic.dart';
import 'year_bill_info_state.dart';

class YearBillInfoPage extends BaseStateless {
  YearBillInfoPage({Key? key}) : super(key: key);

  final Year_bill_infoLogic logic = Get.put(Year_bill_infoLogic());
  final Year_bill_infoState state = Get.find<Year_bill_infoLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  bool get noBackGround1 => false;

  @override
  Color? get navColor => Colors.transparent;

  @override
  Color? get backColor => Colors.white;

  @override
  List<Widget>? get rightAction => RightWidget.widget1(color: Colors.white);

  @override
  Widget? get titleWidget => Obx(() => BaseText(
        text: logic.title.value,
        style: TextStyle(
            fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w600),
      ));

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder<Year_bill_infoLogic>(builder: (_){
      return PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (int index) {
          logic.title.value = logic.getTitle(index);
        },
        children: [
          _childrenWidget(children: [
            Positioned(
                left: 180.w,
                top: 151.w,
                child: BaseText(
                  text: logic.model.daysDeparture,
                  fontSize: 18,
                  color: Colors.white,
                )),
            Positioned(
                left: 34.w,
                top: 194.w,
                child:  Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: '启程，你已与手机银行共赴',
                          style: TextStyle(color: Colors.white)),
                      TextSpan(
                        text: logic.model.year.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white), // 加粗并可调大字号
                      ),
                      TextSpan(text: '年', style: TextStyle(color: Colors.white)),
                      TextSpan(
                        text: logic.model.days.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      TextSpan(
                          text: '天旅程\n\n',
                          style: TextStyle(color: Colors.white)), // \n 换行
                      TextSpan(
                          text: '2025年，', style: TextStyle(color: Colors.white)),
                      TextSpan(
                        text: logic.model.count.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      TextSpan(
                          text: '次登录探索', style: TextStyle(color: Colors.white)),
                    ],
                    style:
                    TextStyle(color: Colors.black87, fontSize: 16), // 默认基础样式
                  ),
                )),
            Positioned(
                left: 176.w,
                top: 281.w,
                child: BaseText(
                  text: logic.model.timePeriod,
                  fontSize: 22,
                  color: Colors.white,
                )),
            Positioned(
                left: 120.w,
                top: 328.w,
                child: BaseText(
                  text: logic.model.nightTime,
                  fontSize: 18,
                  color: Colors.white,
                ))
          ], index: 0),
          _childrenWidget(children: [], index: 1),
          _childrenWidget(children: [
            Positioned(
                left: 25.w,
                top: 192.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BaseText(
                          text: '¥',
                          fontSize: 16,
                          color: Colors.white,
                        ).withPadding(bottom: 3.w),
                        BaseText(
                          text: logic.model.yearSurplus.bankBalance,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(height: 6.w),
                    BaseText(
                      text: '有${logic.model.monthCount}个月结余为正',
                      color: Colors.white,
                    )
                  ],
                )),
            Positioned(
                top: 312.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16.w,
                      children: logic.model.categoryList.map((e){
                        return Row(
                          spacing: 12.w,
                          children: [
                            BaseText(text: e.category,color: Colors.white,),
                            Row(
                              children: [
                                BaseText(text: '¥',color: Colors.white,),
                                BaseText(text: e.amount.bankBalance,style: TextStyle(
                                color: Colors.white,fontSize: 15,
                                  fontWeight: FontWeight.w600
                                ),),
                              ],
                            )
                          ],
                        );
                      }).toList(),
                    ).withPadding(
                      left: 25.w
                    ),
                    SizedBox(height: 25.w,),
                    BaseText(text: '想查询明细记录，去查看>',color: Colors.white,).withContainer(
                      padding: EdgeInsets.only(left: 25.w),
                      onTap: (){
                        Get.delete<BillLogic>();
                        Get.to(() => BillPage());
                      }
                    ),
                    SizedBox(height: 25.w,),
                    Image(image: 'bg_year_2_1'.png3x,width: 1.sw )
                  ],
                )),
          ], index: 2),
          _childrenWidget(children: [
            Positioned(
              left: 15.w,
              top: 192.w,
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BaseText(
                    text: '¥',
                    fontSize: 16,
                    color: Colors.white,
                  ).withPadding(bottom: 3.w),
                  BaseText(
                    text: logic.model.totalIncome.bankBalance,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Positioned(
              left: 53.w,
              top: 278.w,
              child: Row(
                children: [
                  BaseText(
                    text: logic.model.incomeCount.toString(),
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 45.w,),
                  Row(
                    children: [
                      BaseText(text: '相比2024年减少¥',color: Colors.white.withOpacity(0.9),),
                      BaseText(text: 3123.0.bankBalance,color: Colors.white,fontSize: 20,),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
                left: 22.w,
                top: 375.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    BaseText(text: '${logic.model.incomeMaxDateTime}，您支出了全年最大的一笔',color: Colors.white.withOpacity(0.9),),
                    SizedBox(height: 10.w,),
                    Row(
                      children: [
                        BaseText(text: '¥',color: Colors.white.withOpacity(0.9),),
                        BaseText(text: logic.model.incomeMaxAmount.bankBalance,color: Colors.white,fontSize: 20,),
                      ],
                    ),
                  ],
                )),
          ], index: 3),
          _childrenWidget(children: [
            Positioned(
                left: 25.w,
                top: 192.w,
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BaseText(
                      text: '¥',
                      fontSize: 16,
                      color: Colors.white,
                    ).withPadding(bottom: 3.w),
                    BaseText(
                      text: logic.model.totalExpenses.bankBalance,
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8.w,),
                    BaseText(text: '探索世界',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.w,
                        color: Colors.white
                    ),)
                  ],
                ),),
            Positioned(
                left: 22.w,
                top: 275.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text: '共计2笔',
                      fontSize: 16,
                      color: Colors.white,
                    ).withPadding(bottom: 3.w),
                    SizedBox(height: 10.w,),
                    Row(
                      children: [
                        BaseText(text: '相比2024年减少¥',color: Colors.white.withOpacity(0.9),),
                        BaseText(text: 123123.0.bankBalance,color: Colors.white,fontSize: 20,),
                      ],
                    ),
                    SizedBox(height: 10.w,),
                    BaseText(text: '其中「现金支出」和2024年相比减少最多',color: Colors.white.withOpacity(0.9),),
                    SizedBox(height: 10.w,),
                    Row(
                      children: [
                        BaseText(text: '¥',color: Colors.white.withOpacity(0.9),),
                        BaseText(text: 223223.0.bankBalance,color: Colors.white,fontSize: 20,),
                      ],
                    ),
                  ],
                )),

            Positioned(
                left: 22.w,
                top: 465.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    BaseText(text: '${logic.model.expensesMaxDateTime}，您支出了全年最大的一笔',color: Colors.white.withOpacity(0.9),),
                    SizedBox(height: 10.w,),
                    Row(
                      children: [
                        BaseText(text: '¥',color: Colors.white.withOpacity(0.9),),
                        BaseText(text: logic.model.expensesMaxAmount.bankBalance,color: Colors.white,fontSize: 20,),
                      ],
                    ),
                  ],
                )),
            Positioned(
                top: 530.w,child: Container(
              width: 1.sw,
              height: 45.w,
            ).withOnTap(onTap: (){
              Get.to(() => MonthBillPage());
            }))
          ], index: 4),
          _childrenWidget(children: [
            Positioned(
                left: 25.w,
                top: 245.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BaseText(
                          text: '¥',
                          fontSize: 16,
                          color: Colors.white,
                        ).withPadding(bottom: 3.w),
                        BaseText(
                          text: logic.model.yearEndbalance.bankBalance,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(height: 25.w),
                    Row(
                      children: [
                        BaseText(text: '相比2024年增长',fontSize: 17,color: Colors.white.withOpacity(0.8),),
                        BaseText(text: '¥',fontSize: 17,color: Colors.white.withOpacity(0.8),),
                        BaseText(text: (logic.model.yearEndbalance-logic.model.oldYearEndbalance).bankBalance,fontSize: 17,color: Colors.white.withOpacity(0.8),),
                      ],
                    )
                  ],
                )),
            Positioned(
                  top: 330.w,child: Container(
              width: 1.sw,
              height: 45.w,
            ).withOnTap(onTap: (){
              Get.to(() => AccountPage());
            }))
          ], index: 5),
          _childrenWidget(children: [

            Positioned(
                top: 325.w,
                child: Container(
              width: 1.sw,
              height: 55.w,
            ).withOnTap(onTap: (){
              Get.to(() => YljPage());
                }))
          ], index: 6),
          _childrenWidget(children: [], index: 7),
          _childrenWidget(children: [
            Positioned(
                left: 25.w,
                top: 198.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BaseText(
                          text: '¥',
                          fontSize: 16,
                          color: Colors.white,
                        ).withPadding(bottom: 3.w),
                        BaseText(
                          text: 0.0.bankBalance,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                )),
          ], index: 8),
          _childrenWidget(children: [
            Positioned(
                bottom:  40.w,
                child: Container(
                  width: 1.sw,
                  height: 100.w,
                ).withOnTap(onTap: () {
                  Get.to(() => YearEndPage());
                }))
          ], index: 9),
        ],
      );
    },id: 'updateUI',);
  }

  Widget _childrenWidget({
    required List<Widget> children,
    int index = 0,
  }) {
    return Stack(
      children: [
        Image(
          image: 'bg_year_$index'.png3x,
          height: 1.sh,
          fit: BoxFit.fitHeight,
        ),
        ...children,
      ],
    );
  }
}
