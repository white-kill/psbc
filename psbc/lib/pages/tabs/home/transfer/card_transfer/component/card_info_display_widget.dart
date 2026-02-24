import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';

/// 显示已传入的收款人信息（只读样式）
class CardInfoDisplayWidget extends StatelessWidget {
  const CardInfoDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CardTransferState state = Get.find<CardTransferLogic>().state;

    return Container(
      width: 1.sw,
      color: Colors.white,
      child: Column(
        children: [
          BaseText(
            text: "收款人",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ).withContainer(
            width: 1.sw,
            height: 40.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.w),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 头像/银行图标：有传入图片则显示图片，否则显示默认图标
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: state.cardReq.bankLogo.isEmpty
                        ? const Color(0xff00A870)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: state.cardReq.bankLogo.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: state.cardReq.bankLogo,
                          width: 30.w,
                          height: 30.w,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Center(
                            child: SizedBox(
                              width: 24.w,
                              height: 24.w,
                            ),
                          ),
                          errorWidget: (_, __, ___) => Center(
                            child: SizedBox(
                              width: 24.w,
                              height: 24.w,
                            ),
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.w,
                          ),
                        ),
                ),
                SizedBox(width: 12.w),
                // 信息展示
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BaseText(
                            text: state.cardReq.realName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xff333333),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          BaseText(
                            text: "借记卡",
                            fontSize: 11.sp,
                            color: const Color(0xff999999),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            height: 10.w,
                            width: 1.w,
                            color: Color(0xff999999).withOpacity(0.5),
                          ),
                          BaseText(
                            text: state.cardReq.bankName.replaceAll('股份有限公司', ''),
                            fontSize: 11.sp,
                            color: const Color(0xff999999),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.w),
                      BaseText(
                        text: _formatCardNumber(state.cardReq.cardNo),
                        fontSize: 14.sp,
                        color: const Color(0xFF909090),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 格式化卡号，每4位加一个空格
  String _formatCardNumber(String cardNo) {
    if (cardNo.isEmpty) return '';
    String digitsOnly = cardNo.replaceAll(RegExp(r'\s+'), '');
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }
    return formatted;
  }
}
