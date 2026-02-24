import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/abc_button.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/notice_data_model.dart';
import '../../../../component/right_widget.dart';
import '../transfer_notice/transfer_notice_view.dart';
import 'transfer_result_logic.dart';
import 'transfer_result_state.dart';

class TransferResultPage extends BaseStateless {
  TransferResultPage({super.key}) : super(title: '转账结果');

  final TransferResultLogic logic = Get.put(TransferResultLogic());
  final TransferResultState state = Get.find<TransferResultLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();



  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Image(image: 't_result_top'.png3x),
        Container(
          width: 1.sw,
          height: 139.w,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 8.w,
                  ),
                  BaseText(
                    text: '¥${double.parse(state.cardReq.amount).bankBalance}',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: state.tgaNames.map((e) {
                  if (e == '') {
                    return Container(
                      width: 1.w,
                      height: 15.w,
                      color: Color(0xff07070),
                    );
                  }
                  return BaseText(
                    text: e,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: BColors.mainColor,
                    ),
                  ).withOnTap(onTap: (){
                    if(e == '继续转账'){
                      Get.back();
                    }
                    if(e == '往来转账记录'){
                    }
                  });
                }).toList(),
              ).withPadding(bottom: 20.w, left: 20.w, right: 20.w)
            ],
          ),
        ),
        Container(
          height: 12.w,
          color: const Color(0xFFF5F5F5),
        ),
        Container(
          width: 1.sw,
          color: Colors.white,
          padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
          child: Column(
            children: state.titleNames.map((e) {
              if (e == '') {
                return Container(
                  width: 1.sw,
                  height: 36.w,
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                    text: e,
                    fontSize: 14.sp,
                    color: Color(0xff8E8E92),
                  ),
                  BaseText(text: logic.valueStr(e)),
                ],
              ).withContainer(
                  width: 1.sw,
                  height: 36.w,
                  padding: EdgeInsets.only(left: 15.w, right: 15.w));
            }).toList(),
          ),
        ),
        Container(
          width: 1.sw,
          color: Colors.white,
          padding: EdgeInsets.only(top: 60.w,bottom: ScreenUtil().bottomBarHeight+10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AbcButton(
                title: '完成',
                width: 160.w,
                height: 44.w,
                bgColor: Colors.white,
                border: Border.all(width: 1.w, color: BColors.mainColor),
                titleColor: BColors.mainColor,
                onTap: (){
                  Get.back();
                  Get.back();
                },
              ),
              Container(
                width: 15.w,
              ),
              AbcButton(
                title: '通知收款人',
                width: 160.w,
                height: 44.w,
                onTap: (){
                  NoticeDataModel data = NoticeDataModel();
                  data.amount = double.parse(state.cardReq.amount);
                  data.oppositeAccount = state.cardReq.cardNo;
                  data.oppositeBank = state.cardReq.bankName;
                  data.oppositeName = state.cardReq.realName;
                  data.postscript = state.cardReq.purpose;
                  data.transactionTime = logic.time;
                  Get.to(() => TransferNoticePage(),arguments: {
                    'model':data
                  });

                },
              )
            ],
          ),
        )
      ],
    );
  }
}
