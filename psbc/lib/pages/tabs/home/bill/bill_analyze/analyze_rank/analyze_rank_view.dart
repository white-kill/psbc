import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/app_config.dart';
import '../../../../../../config/model/rank_model.dart';
import '../../../../../component/right_widget.dart';
import 'analyze_rank_logic.dart';
import 'analyze_rank_state.dart';

class AnalyzeRankPage extends BaseStateless {
  AnalyzeRankPage({Key? key}) : super(key: key, title: '收支排行');

  final AnalyzeRankLogic logic = Get.put(AnalyzeRankLogic());
  final AnalyzeRankState state = Get.find<AnalyzeRankLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Color? get titleColor => Color(0xff333333);

  @override
  Color? get navColor => Color(0xffF5F9F8);

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  bool get enablePullDown => false;

  @override
  void onLoading() {
    super.onLoading();
    state.pageNum++;
    logic.incomeAnalysisRank();
  }

  @override
  Widget initBody(BuildContext context) {
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: 'phb_bg'.png,
              fit: BoxFit.fitWidth)),
      child: Column(
        children: [
          GetBuilder(
            builder: (AnalyzeRankLogic c) {
              return Stack(
                children: [
                  Image(
                          image: state.type == '1'
                              ? 'phb_spend'.png
                              : 'phb_income'.png)
                      .withContainer(
                    padding: EdgeInsets.only(top: navHeight + 70.w),
                  ),
                  Positioned(
                    left: 25.w,
                    bottom: 60.w,
                    child: logic.formatDate(),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Row(
                        children: [
                          Container().expanded(onTap: () {
                            state.type = '1';
                            logic.update(['updateImage']);
                            logic.incomeAnalysisRank();
                          }),
                          Container().expanded(onTap: () {
                            state.type = '2';
                            logic.update(['updateImage']);
                            logic.incomeAnalysisRank();
                          })
                        ],
                      ).withContainer(width: 1.sw, height: 50.w))
                ],
              );
            },
            id: 'updateImage',
          ),
          GetBuilder(
            builder: (AnalyzeRankLogic c) {
              return Container(
                width: 1.sw - 30.w,
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                color: Colors.white,
                child: state.list.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 100.w,
                          ),
                          Image(
                            image: 'phb_empty'.png,
                            height: 250.w,
                          )
                        ],
                      )
                    : refreshWidget(
                        controller: state.refreshController,
                        child: ListView.builder(
                          controller: state.scController,
                          itemBuilder: (context, index) {
                            RankList model = state.list[index];
                            return Container(
                              padding: EdgeInsets.all(12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      index > 4
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  right: 6.w, left: 6.w),
                                              width: 14.w,
                                              height: 14.w,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0x8BB3B3B6),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              4.w))),
                                              child: BaseText(
                                                text: '${index + 1}',
                                                fontSize: 11,
                                                textAlign: TextAlign.center,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Image(
                                              image: "grade_${index + 1}".png,
                                              width: 20.w,
                                              height: 20.w,
                                            ).withPadding(right: 6.w),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          BaseText(
                                            text:
                                                '${model.amount < 0 ? '-' : '+'}¥${model.amount.abs().bankBalance}',
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
                            );
                          },
                          itemCount: state.list.length,
                        )),
              ).expanded();
            },
            id: 'updateUI',
          )
        ],
      ),
    );
  }
}
