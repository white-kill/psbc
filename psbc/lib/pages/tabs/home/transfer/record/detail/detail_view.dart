import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/transfer/transfer_notice/transfer_notice_view.dart';
import 'package:psbc/utils/abc_button.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/model/notice_data_model.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../component/right_widget.dart';
import '../../card_transfer/card_transfer_view.dart';
import '../../../../../other/fixed_nav/fixed_nav_view.dart';
import '../../transfer_status/transfer_status_view.dart';
import 'detail_logic.dart';
import 'detail_state.dart';

class TransferDetailPage extends BaseStateless {
  TransferDetailPage({Key? key}) : super(key: key, title: '往来转账记录');

  final TransferDetailLogic logic = Get.put(TransferDetailLogic());
  final DetailState state = Get.find<TransferDetailLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Container(
                    width: 1.sw,
                    margin: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: Column(
                      children: [
                        SizedBox(height: 30.w),
                        BaseText(
                          text:
                              '${logic.type()}￥${state.billDetail.amount.bankBalance}',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff333333)),
                        ),
                        SizedBox(height: 2.w),
                        BaseText(
                          text: '交易金额',
                          style:
                              TextStyle(fontSize: 13, color: Color(0xff8D8D8D)),
                        ),
                        SizedBox(height: 15.w),
                        ..._titleWidgets(),
                        SizedBox(height: 12.w),
                      ],
                    ),
                  ),
                  state.billDetail.type == '1'
                      ? const SizedBox.shrink()
                      : Container(
                          width: 1.sw,
                          height: 55.w,
                          margin: EdgeInsets.only(
                              left: 12.w, right: 12.w, bottom: 12.w),
                          padding: EdgeInsets.only(
                            left: 12.w,
                            right: 12.w,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.w))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BaseText(
                                text: '状态',
                                color: Color(0xff8D8D8D),
                              ),
                              Row(
                                children: [
                                  BaseText(
                                    text: '已汇出',
                                    color: BColors.mainColor,
                                    fontSize: 13,
                                  ),
                                  Image(
                                    image: 'ic_jt_right'.png3x,
                                    width: 22.w,
                                    height: 22.w,
                                  )
                                ],
                              )
                            ],
                          ),
                        ).withOnTap(onTap: () {
                          Get.to(() => TransferStatusPage(), arguments: {
                            'postscriptno': state.billDetail.postscriptno,
                          });
                        }),
                  Container(
                    width: 1.sw,
                    height: 55.w,
                    margin:
                        EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.w),
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 12.w,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BaseText(
                          text: '查看与TA的往来转账记录',
                        ),
                        Image(
                          image: 'ic_jt_right'.png3x,
                          width: 22.w,
                          height: 22.w,
                        )
                      ],
                    ),
                  ).withOnTap(onTap: () {
                    Get.offAndToNamed(Routes.queryRecordPage, arguments: {
                      'oppositeAccount': state.billDetail.oppositeAccount
                    });
                  }),
                ],
              ),
              Positioned(
                  right: 0,
                  top: 40.w,
                  child: Image(
                    image: 'cjwt_tag'.png,
                    width: 75.w,
                    height: 25.w,
                  ).withOnTap(onTap: () {
                    Get.to(() => FixedNavPage(),
                        arguments: {'image': 'cjwt', 'title': '常见问题'});
                  })),
            ],
          ),
        ),
        Container(
          width: 1.sw,
          height: 62.w + ScreenUtil().bottomBarHeight,
          color: Colors.white,
          padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
          child: state.billDetail.type == '1'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AbcButton(
                      title: '向TA转账',
                      width: 1.sw - 40.w,
                      radius: 6.w,
                      onTap: () {
                        Get.to(() => CardTransferPage(), arguments: {
                          'icon': state.billDetail.icon,
                          'bankName': state.billDetail.oppositeBankName,
                          'id': state.billDetail.oppositeBankId,
                          'name': state.billDetail.oppositeName,
                          'bankCard': state.billDetail.oppositeAccount,
                        });
                      },
                    )
                  ],
                )
              : Row(
                  spacing: 12.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AbcButton(
                      title: '再转一笔',
                      width: 1.sw / 2 - 30.w,
                      radius: 6.w,
                      bgColor: Colors.white,
                      border: Border.all(color: BColors.mainColor, width: 1.w),
                      titleColor: BColors.mainColor,
                      onTap: () {
                        Get.to(() => CardTransferPage(), arguments: {
                          'icon': state.billDetail.icon,
                          'bankName': state.billDetail.oppositeBankName,
                          'id': state.billDetail.oppositeBankId,
                          'name': state.billDetail.oppositeName,
                          'bankCard': state.billDetail.oppositeAccount,
                        });
                      },
                    ),
                    AbcButton(
                      title: '通知收款人',
                      width: 1.sw / 2 - 30.w,
                      radius: 6.w,
                      onTap: () {
                        NoticeDataModel data = NoticeDataModel();
                        data.amount = state.billDetail.amount;
                        data.oppositeAccount = state.billDetail.oppositeAccount;
                        data.oppositeBank = state.billDetail.oppositeBankName;
                        data.oppositeName = state.billDetail.oppositeName;
                        data.postscript = state.billDetail.merchantBranch;
                        data.transactionTime = state.billDetail.transactionTime;
                        data.bank = state.billDetail.bankName;
                        data.account = state.billDetail.account;
                        Get.to(() => TransferNoticePage(),
                            arguments: {'model': data});
                      },
                    ),
                  ],
                ),
        )
      ],
    );
  }

  List<Widget> _titleWidgets() {
    return logic.titleName.map((e) {
      return Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: e,
              color: Color(0xff8D8D8D),
              fontSize: 14,
              strutStyle: StrutStyle(
                  fontSize: 14,
                  forceStrutHeight: true
              ),
            ),
            Expanded(
              child: BaseText(
                textAlign: TextAlign.end,
                maxLines: 2,
                text: logic.valueStr(e),
                color: Color(0xff212121),
                fontSize: 14,
                strutStyle: StrutStyle(
                  fontSize: 14,
                  forceStrutHeight: true
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}
