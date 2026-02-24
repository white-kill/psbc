import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/bill/bill_analyze/analyze_detail/analyze_detail_logic.dart';
import 'package:psbc/pages/tabs/home/bill/bill_analyze/analyze_rank/analyze_rank_view.dart';
import 'package:psbc/pages/tabs/home/bill/bill_analyze/component/chart_widget.dart';
import 'package:psbc/pages/tabs/home/bill/bill_analyze/component/pick_view.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/app_config.dart';
import '../../../../../config/model/analyze_all_model.dart';
import '../../../../../utils/widget_util.dart';
import '../../../../component/alter_card_bottom.dart';
import '../../../../component/right_widget.dart';
import '../../../../component/sheet_widget/sheet_bottom.dart';
import 'analyze_detail/analyze_detail_view.dart';
import 'bill_analyze_logic.dart';
import 'bill_analyze_state.dart';
import 'component/pick_time_view.dart';

class BillAnalyzePage extends BaseStateless {
  BillAnalyzePage({Key? key}) : super(key: key, title: '收支分析');

  final BillAnalyzeLogic logic = Get.put(BillAnalyzeLogic());
  final BillAnalyzeState state = Get.find<BillAnalyzeLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get titleColor => const Color(0xff333333);

  @override
  Widget initBody(BuildContext context) {
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            GetBuilder(
              builder: (BillAnalyzeLogic c) {
                return Image(image: logic.isZc ? 'fx_zc'.png3x : 'fx_sr'.png3x)
                    .withSizedBox(width: 1.sw, height: navHeight + 130.w);
              },
              id: 'updateUI',
            ),
            Positioned(
                top: navHeight + 25.w,
                child: Container(
                  width: 1.sw,
                  height: 45.w,
                  child: Row(
                    children: [
                      Container().expanded(onTap: () {
                        logic.isZc = true;
                        state.touchedIndex = 0;
                        state.spots = logic
                            .generateRandomData(state.analyzeModel.trendList);
                        logic.update(['updateUI','updateChat']);
                        logic.jumpAt();
                      }),
                      Container().expanded(onTap: () {
                        logic.isZc = false;
                        state.touchedIndex = 0;
                        state.spots = logic
                            .generateRandomData(state.analyzeModel.trendList);
                        logic.update(['updateUI','updateChat']);
                        logic.jumpAt();
                      }),
                    ],
                  ),
                )),
            Positioned(
                left: 19.w,
                right: 19.w,
                bottom: 18.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder(
                      builder: (BillAnalyzeLogic c) {
                        return Row(
                          children: [
                            _tagWidget(state.selectedTimeType, onTap: () {
                              SheetBottom.show(
                                title: '请选中',
                                rightWidget: Image(
                                  image: 'close'.png3x,
                                  width: 16.w,
                                  height: 16.w,
                                ).withOnTap(onTap: () => Get.back()),
                                child: CupertinoTypePicker(),
                              );
                            }),
                            SizedBox(
                              width: 25.w,
                            ),
                            _tagWidget(state.dateTime.replaceAll('-', '.'),
                                onTap: () {
                              SheetBottom.show(
                                title: '${state.selectedTimeType}选择',
                                rightWidget: Image(
                                  image: 'close'.png3x,
                                  width: 16.w,
                                  height: 16.w,
                                ).withOnTap(onTap: () => Get.back()),
                                child: PickTimeView(),
                              );
                            }),
                          ],
                        );
                      },
                      id: 'updateTop',
                    ),
                    _tagWidget('绿卡通${AppConfig.config.abcLogic.cardFour()}',
                        onTap: () {
                      SheetBottom.show(
                        title: '请选择',
                        rightWidget: Image(
                          image: 'close'.png3x,
                          width: 16.w,
                          height: 16.w,
                        ).withOnTap(onTap: () => Get.back()),
                        child: const AlterCardBottom(),
                      );
                    }),
                  ],
                ))
          ],
        ),
        SizedBox(
          height: 12.w,
        ),
        Container(
          width: 1.sw,
          height: 297.w,
          color: Colors.white,
          alignment: Alignment.center,
          child: ChartWidget(),
        ),
        GetBuilder(
          builder: (BillAnalyzeLogic c) {
            return Container(
              margin: EdgeInsets.all(12.w),
              padding: EdgeInsets.only(bottom: 12.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.w))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(text: '分类列表'),
                      Row(
                        children: [
                          BaseText(
                            text: '对比上月',
                            color: Color(0xff666666),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Obx(() => CupertinoSwitch(
                              value: logic.switchValue.value,
                              activeColor:
                                  const Color.fromARGB(255, 3, 134, 91),
                              onChanged: (v) {
                                logic.switchValue.value = v;
                              }).sw())
                        ],
                      )
                    ],
                  ).withPadding(
                    all: 12.w,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      AnalyzeAllCateogryList categoryModel =
                          logic.catList()[index];
                      return Container(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                netImage(
                                  url: categoryModel.categoryIcon,
                                  width: 20.w,
                                  height: 20.w,
                                ).withPadding(right: 6.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BaseText(
                                      text: categoryModel.name,
                                      fontSize: 13,
                                    ),
                                    SizedBox(height: 8.w),
                                    BaseText(
                                      text:
                                          '${categoryModel.rate}%     ${categoryModel.count}笔',
                                      fontSize: 12,
                                      color: Color(0xff888888),
                                    ),
                                    SizedBox(height: 8.w),
                                    Stack(
                                      children: [
                                        Container(
                                          width: 160.w,
                                          height: 3.w,
                                          decoration: BoxDecoration(
                                              color: Color(0xffdedede),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.w))),
                                        ),
                                        Container(
                                          width:
                                              (160 * (categoryModel.rate / 100))
                                                  .w,
                                          height: 3.w,
                                          decoration: BoxDecoration(
                                              color: BColors.mainColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.w))),
                                        ),
                                      ],
                                    )
                                    // BaseText(text: 'rankModel.transactionTime'),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BaseText(
                                      text:
                                          '${categoryModel.totalAmount< 0?'-':'+'}¥${categoryModel.totalAmount.abs().bankBalance}',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Obx(() => logic.switchValue.value
                                        ? SizedBox(
                                            height: 8.w,
                                          )
                                        : SizedBox.shrink()),
                                    Obx(
                                      () => logic.switchValue.value
                                          ? BaseText(
                                              text: categoryModel.upTotalAmount == 0
                                                  ? '--'
                                                  : '↑ ${categoryModel.upTotalAmount.bankBalance}',
                                              fontSize: 12.sp,
                                              color: Colors.red,
                                            )
                                          : SizedBox.shrink(),
                                    )
                                  ],
                                ),
                                Image(
                                  image: 'ic_jt_right'.png3x,
                                  width: 20.w,
                                  height: 20.w,
                                )
                              ],
                            )
                          ],
                        ),
                      ).withOnTap(onTap: () {
                        Get.to(() => AnalyzeDetailPage(),arguments: {
                          'name':categoryModel.name,
                          'type':state.selectedTimeType == '年度'?'1':'0',
                          'dateTime':state.dateTime,
                          'incomeExpenseType':logic.isZc?'2':'1'
                        });
                      });
                    },
                    itemCount: logic.catList().length,
                  ),
                ],
              ),
            );
          },
          id: 'updateUI',
        ),
       GetBuilder(
          builder: (BillAnalyzeLogic c) {
            return state.selectedTimeType == '年度'?const SizedBox.shrink():Container(
              margin: EdgeInsets.only(left: 12.w, bottom: 12.w, right: 12.w),
              padding: EdgeInsets.only(bottom: 12.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.w))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(text: logic.timeStr()).withPadding(
                    all: 12.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(text: '共${logic.rankList().length}笔',fontSize: 13,color: Color(0xff999999),),
                      BaseText(text: '合计¥' + logic.price().bankBalance,fontSize: 13,color: Color(0xff999999),),
                    ],
                  ).withPadding(
                    left: 12.w,right: 12.w,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      AnalyzeRankList model = logic.rankList()[index];
                      return Container(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: index > 5
                                      ? "grade_5".png
                                      : "grade_${index + 1}".png,
                                  width: 20.w,
                                  height: 20.w,
                                ).withPadding(right: 6.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BaseText(
                                      text: model.excerpt,
                                      fontSize: 13,
                                    ).withContainer(width: 200.w),
                                    SizedBox(height: 8.w),
                                    BaseText(
                                      text:
                                          '借记卡(${AppConfig.config.abcLogic.cardFour()})',
                                      fontSize: 12,
                                      color: Color(0xff888888),
                                    ),
                                    SizedBox(height: 8.w),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BaseText(
                                      text: '${model.amount< 0?'-':'+'}¥${model.amount.abs().bankBalance}',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    SizedBox(height: 8.w),
                                    BaseText(
                                      text: model.transactionTime,
                                      fontSize: 12.sp,
                                      color: Color(0xff999999),
                                    ),
                                    SizedBox(height: 8.w),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ).withOnTap(onTap: () {
                        Get.to(() => AnalyzeRankPage(),arguments: {
                          'time':state.dateTime
                        });
                      });
                    },
                    itemCount: logic.rankList().length,
                  ),
                ],
              ),
            );
          },
          id: 'updateUI',
        ),
      ],
    );
  }

  Widget _tagWidget(String content, {Function? onTap}) {
    return Row(
      children: [
        Row(
          children: [
            BaseText(
              text: content,
              fontSize: 14.sp,
              color: Color(0xff333333),
            ),
          ],
        ),
        SizedBox(
          width: 4.w,
        ),
        Image(
          image: 'arr_dow'.png3x,
          width: 6.w,
          height: 6.w,
          color: Colors.black,
        ),
      ],
    ).withOnTap(onTap: onTap);
  }
}
