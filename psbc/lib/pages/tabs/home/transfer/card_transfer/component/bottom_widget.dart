import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/net_config/apis.dart';
import 'package:psbc/pages/tabs/home/transfer/transfer_result/transfer_result_view.dart';
import 'package:psbc/utils/abc_button.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  final CardTransferLogic logic = Get.find<CardTransferLogic>();
  final CardTransferState state = Get.find<CardTransferLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 40.w,
          ),
          AbcButton(
            title: '确定',
            onTap: () {
              if (state.cardReq.realName == '') {
                '请输入户名'.showToast;
                return;
              }
              if (state.cardReq.cardNo == '') {
                '请输入账户'.showToast;
                return;
              }
              if (state.cardReq.bankName == '') {
                '请选择收款银行'.showToast;
                return;
              }
              if (state.cardReq.amount == '') {
                '请输入金额'.showToast;
                return;
              }
              Http.post(Apis.billTransfer, data: state.cardReq.toJson())
                  .then((v) {
                    if(v != null){
                      Get.to(() => TransferResultPage(),arguments: {
                        'req':state.cardReq,
                      });
                    }
              });
            },
            width: 343.w,
            height: 44.w,
            radius: 12.w,
          ),
          SizedBox(height: 38.w),
          Image(image: 'zz_tips'.png3x, width: 335.w),
          SizedBox(height: 25.w),
        ],
      ),
    );
  }
}
